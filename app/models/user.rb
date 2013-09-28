# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  UID        :string(255)
#  group_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class User < ActiveRecord::Base
  belongs_to :group
  has_many :tasks
  attr_accessible :UID, :name, :surname, :group
end

