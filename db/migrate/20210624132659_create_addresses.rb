class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.bigint :user_id
      t.string :address
    end
  end
end
