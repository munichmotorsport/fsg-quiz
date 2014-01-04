class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :quiztories, :dependent => :destroy
  
  accepts_nested_attributes_for :questions, :allow_destroy => true, :reject_if => :all_blank
  
  validates_associated :questions
  
  def quiz_attributes
    "Season " + self.season.to_s + ", category " + self.category
  end
end
