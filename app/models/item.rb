
# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  description :string(255)
#  category    :string(255)
#  status      :string(255)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#
class Item < ActiveRecord::Base
  belongs_to :user
  attr_accessible :category, :description, :status

  validates_presence_of :category, :description, :status
  validates :status, presence: true, inclusion: %w(open waiting done)
end
