class AddSeminarIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :seminar_id, :integer
  end
end
