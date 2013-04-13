class Topic < ActiveRecord::Base
  attr_accessible :name, :number, :seminar_id
  belongs_to :seminar
end
