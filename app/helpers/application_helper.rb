module ApplicationHelper
  def status_badge(status)
    # ステータスに応じてクラスを切り替え
    badge_class = case status
                  when "waiting_payment"
                    "bg-info text-white"
                  when "confirm_payment"
                    "bg-success text-white"
                  when "shipped"
                    "bg-success text-white"
                  when "out_of_delivery"
                    "bg-success text-white"
                  when "delivered"
                    "bg-success text-white"
                  else
                    "bg-secondary text-white" # デフォルトのスタイル
                  end

    # バッジ HTML を返す
    content_tag(:span, status, class: "badge #{badge_class}")
  end
end
