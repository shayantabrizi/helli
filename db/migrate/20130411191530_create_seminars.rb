class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.integer :day
      t.integer :session
      t.string :name

      t.timestamps
    end
  end
end
