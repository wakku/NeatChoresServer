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
end


