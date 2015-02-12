class Course < ActiveRecord::Base
  belongs_to :user

  has_many :words, dependent: :destroy
end
