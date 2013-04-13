class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.integer :topic_id
      t.integer :seminar_id
      t.integer :rank
      t.integer :user_id

      t.timestamps
    end
  end
end
