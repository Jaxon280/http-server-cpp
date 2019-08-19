class AddColumnsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, foreign_key: true
    add_column :messages, :room, :referencese
  end
end
