class Seminar < ActiveRecord::Base
  attr_accessible :day, :name, :session
  has_many :topics
end
