class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :postcode
      t.string :phone_number
      t.string :email
      t.text :product_details
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
