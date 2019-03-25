class User < ActiveRecord::Base
  has_many :applications
  has_many :jobs, through: :applications
end
