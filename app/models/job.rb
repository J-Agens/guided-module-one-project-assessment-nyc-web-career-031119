class Job < ActiveRecord::Base
  has_many :applications
  has_many :users, through: :applications
end
