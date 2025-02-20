class Customer::WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_ENDPOINT_SECRET']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      p e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      p e
      status 400
      return
    end

    case event.type
    when 'checkout.session.completed'
      session = event.data.object # sessionの取得
      customer = Customer.find(session.client_reference_id)
      return unless customer # 顧客が存在するかどうか確認
      
      # トランザクション処理開始
      ApplicationRecord.transaction do
        order = create_order(session) # sessionを元にordersテーブルにデータを挿入
        session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ['line_items'] })
        session_with_expand.line_items.data.each do |line_item|
          create_order_details(order, line_item) # 取り出したline_itemをorder_detailsテーブルに登録
        end
      end
      # トランザクション処理終了
      customer.cart_items.destroy_all # 顧客のカート内商品を全て削除
      customer = Customer.find_by(email: session.customer_details.email)
      order = customer.orders.last if customer # 顧客の最後の注文を取得
      redirect_to session.success_url
    end
end

private

 def create_order(session)
   Order.create!({
                   customer_id: session.client_reference_id,
                   name: session.shipping_details.name,
                   postal_code: session.shipping_details.address.postal_code,
                   prefecture: session.shipping_details.address.state,
                   address1: session.shipping_details.address.line1,
                   address2: session.shipping_details.address.line2,
                   postage: session.shipping_options[0].shipping_amount,
                   total_amount: session.amount_total,
                   status: 'confirm_payment'
                 })
 end

 def create_order_details(order, line_item)
  # StripeのProductオブジェクトを取得
  product = Stripe::Product.retrieve(line_item.price.product)

  # RailsのProductモデルから該当する商品を取得
  purchased_product = Product.find_by(id: product.metadata.product_id)
  raise ActiveRecord::RecordNotFound, "Product not found for ID #{product.metadata.product_id}" if purchased_product.nil?

  # bean_stateを取得（metadataが存在する場合のみ）
  bean_state = product.metadata['bean_state']

# bean_stateがnilでない場合のみ変換を適用
  bean_state = CartItem.bean_states[bean_state] if bean_state.present?

  # 注文詳細を作成
  order_detail = order.order_items.create!(
    product_id: purchased_product.id,
    price: line_item.price.unit_amount,
    quantity: line_item.quantity,
    bean_state: bean_state # 修正: product.metadataから取得
  )

  # 在庫数を更新
  purchased_product.update!(stock: purchased_product.stock - order_detail.quantity)
end
end