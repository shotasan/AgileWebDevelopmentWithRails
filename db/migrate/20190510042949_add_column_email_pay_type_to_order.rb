class AddColumnEmailPayTypeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :email, :string
    add_column :orders, :pay_type, :string
  end
end
