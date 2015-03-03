class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :learned_words, dependent: :destroy

  scope :in_course, ->(course_id) {where course_id: course_id}
  scope :learned_by_user, ->(user_id) {where user_id: user_id}
end
