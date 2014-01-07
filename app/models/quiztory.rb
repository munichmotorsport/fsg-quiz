class Quiztory < ActiveRecord::Base
  belongs_to :quiz
  has_and_belongs_to_many :users
    
  validates_associated :quiz
  
  serialize :failed_submits, Hash
  serialize :answer_values, Array
  
  def submit_delay user_id
    unless (submits = self.failed_submits).empty?
      unless (user_submits = submits.select{ |k,v| v == user_id }).empty?
        last_user_submit = user_submits.keys.last
        time_delta = Time.now - last_user_submit
        if (delay = 30.0 - time_delta) > 0.0
          delay.round
        else
          0
        end
      else
        0
      end
    else
      0
    end
  end
  
  def duration
    duration_sec = self.updated_at - self.created_at
    duration_min = (duration_sec / 60).to_i
    duration_sec = (duration_sec % 60).to_i
    [duration_min, duration_sec]
  end
end
