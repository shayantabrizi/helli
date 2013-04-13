class User < ActiveRecord::Base
  attr_accessible :name, :number, :selections_attributes
  has_many :selections, :dependent => :destroy
  accepts_nested_attributes_for :selections

  
  validates :number, presence:   true,
                    uniqueness: { case_sensitive: false }
end
