class UpdateOrdersAddressFields < ActiveRecord::Migration[7.1]
  def change
    # address を address1 に変更
    rename_column :orders, :address, :address1

    # address2 カラムを追加
    add_column :orders, :address2, :string
  end
end
