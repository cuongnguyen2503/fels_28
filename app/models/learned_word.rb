class LearnedWord < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :choice

  scope :in_lesson, ->(lesson_id) {where lesson_id: lesson_id}
  scope :submitted_in_lessons, ->(lessons_ids) do
    where("lesson_id in (#{lessons_ids}) and choice_id is not NULL")
  end
  scope :submitted_in_lesson, ->(lesson_id) do
    where("lesson_id = #{lesson_id} and choice_id is not NULL")
  end
  scope :remain_in_lessons, ->(lessons_ids) do
    where("lesson_id in (#{lessons_ids}) and choice_id is NULL")
  end
  scope :remain_in_lesson, ->(lesson_id) do
    where(lesson_id: lesson_id, choice_id: nil)
  end
end
