class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :user_id1
      t.integer :user_id2

      t.timestamps
    end
  end
end
