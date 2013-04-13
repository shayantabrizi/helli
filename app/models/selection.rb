class Selection < ActiveRecord::Base
  attr_accessible :rank, :seminar_id, :topic_id, :user_id
  belongs_to :user
  
end
