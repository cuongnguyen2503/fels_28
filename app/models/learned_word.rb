class LearnedWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :choice

  scope :in_lessons, ->(lessons_id) {where lesson_id: lessons_id}
end
