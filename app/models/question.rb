class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, :dependent => :destroy
  
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => :all_blank
  
  validates_presence_of :content
  validates_associated :answers
end
