class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :hash_id
      t.string :position_order, default: ''

      t.timestamps
    end
  end
end
