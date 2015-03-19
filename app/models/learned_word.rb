class LearnedWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :choice

  scope :in_lesson, ->(lesson_id) {where lesson_id: lesson_id}
  scope :submitted_in_lessons, ->(lessons_ids) do
    where(lesson_id: lessons_ids).where.not(choice_id: nil)
  end
  scope :submitted_in_lesson, ->(lesson_id) do
    where(lesson_id: lesson_id).where.not(choice_id: nil)
  end
  scope :remain_in_lessons, ->(lessons_ids) do
    where(lesson_id: lessons_ids, choice_id: nil) 
  end
  scope :remain_in_lesson, ->(lesson_id) do
    where(lesson_id: lesson_id, choice_id: nil)
  end
end
