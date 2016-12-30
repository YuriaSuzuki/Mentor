class User < ActiveRecord::Base
  has_many :attendance_managements
end
