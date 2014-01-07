class Quiztory < ActiveRecord::Base
  belongs_to :quiz
  has_and_belongs_to_many :users
    
  validates_associated :quiz
  
  serialize :failed_submits, Hash
  serialize :answer_values, Array
  
  def submit_delay user_id
    time_difference = Time.now - self.updated_at
    delay = 30.0 - time_difference
    
    
    unless (submits = self.failed_submits).empty?
      unless (user_submits = submits.select{ |k,v| v == user_id }).empty?
        last_user_submit = user_submits.keys.last
        time_delta = Time.now - last_user_submit
        delay = 30.0 - time_delta
        
        delay.round
      else
        0
      end
    else
      0
    end
  end
end
