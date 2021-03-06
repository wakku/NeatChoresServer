# == Schema Information
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  outcome    :string(255)
#  task_id    :integer
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Review < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  attr_accessible :outcome

  validates_presence_of :task, :user
  validates :outcome, presence: true, inclusion: %w(approved disapproved)

  after_save { self.task.check_reviews }
end
