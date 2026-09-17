class CreateConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :conversations do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps
    end
  end
end
