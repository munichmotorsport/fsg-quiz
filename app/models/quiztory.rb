class Quiztory < ActiveRecord::Base
  belongs_to :quiz
  has_and_belongs_to_many :users
  
  validates_associated :quiz
end
