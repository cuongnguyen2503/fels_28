class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :learned_words, dependent: :destroy
end
