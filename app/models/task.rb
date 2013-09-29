# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  description :string(255)
#  status      :string(255)
#  due_date    :date
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#
class Task < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  attr_accessible :description, :due_date, :status, :user

  validates :status, presence: true, inclusion: %w(open waiting done)

  def check_reviews
  	self.status = "done" if self.reviews.size == User.all.size
  	self.save!
  end

  def self.check_punishment user
  	result = false
  	@user = User.find_by_uid(user)
  	self.where(status: "open", user_id: @user).each do |t|
  		if t.due_date < Time.now.to_date && t.updated_at < 1.day.ago
  			result = true
  			t.updated_at = Time.now
  			t.save!
  		end
  	end
  	return result
	end
end


