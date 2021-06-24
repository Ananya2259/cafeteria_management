class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.datetime :date
      t.bigint :user_id
    end
  end
end
