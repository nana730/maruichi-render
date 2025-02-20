class Admin::PagesController < ApplicationController
  before_action :authenticate_admin!

  def home
    @status = search_params[:status]
    @selected = params[:status] || 'all' # 初期値を設定
    @orders = filter_orders(Order.includes(:customer).order(created_at: :desc).page(params[:page]).per(12), @selected)
    @items = @orders # _paginator.html.erb で @items を使用
    @today_total_orders = total_orders(today_orders)
  end

  private

  # ステータスでオーダーをフィルタリングする
  def filter_orders(orders, status)
    case status
    when "waiting_payment"
      orders.where(status: :waiting_payment)
    when "confirm_payment"
      orders.where(status: :confirm_payment)
    when "shipped"
      orders.where(status: :shipped)
    when "out_of_delivery"
      orders.where(status: :out_of_delivery)
    when "delivered"
      orders.where(status: :delivered)
    else
      orders
    end
  end # ← 修正: ここに `end` を追加

  # 今日のオーダーを取得するためのメソッド
  def today_orders
    Order.includes(:customer).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  # # オーナー確認待ちのオーダーを取得するメソッド
  # def waiting_orders
  #   Order.includes(:customer).where(status: :オーナー確認待ち)
  # end

  # オーダーのカウントを返すメソッド
  def total_orders(orders)
    orders.count
  end

  def search_params
    params.permit(:status, :page) # 必要なパラメータだけ許可
  end
end # ← クラスの `end`
