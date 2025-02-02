class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum status: {
    waiting_payment: 0,       # 支払い待ち
    confirm_payment: 1,       # 支払い確認済み
    shipped: 2,               # 発送済み
    out_of_delivery: 3,       # 配達中
    delivered: 4              # 配達済み
  }
  
  
  validates :name, presence: true
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :address1, presence: true
  validates :postage, presence: true
  validates :total_amount, presence: true
  validates :status, presence: true
    # ステータスのスコープ
    scope :confirm_payment, -> { where(status: :confirm_payment) }
    scope :shipped,-> { where(status: :shipped) }
    scope :delivered,-> { where(status: :delivered) }
    scope :today_orders, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

    def subtotal
      order_items.sum(&:subtotal)
    end
end
