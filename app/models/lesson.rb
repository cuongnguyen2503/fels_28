class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :learned_words, dependent: :destroy

  scope :in_course, ->(course_id) {where course_id: course_id}
  scope :learned_in_course_by_user, ->(course_id, user_id) do
    where(course_id: course_id, user_id: user_id)
  end

  def finished?
    LearnedWord.remain_in_lesson(id).count == 0
  end

  def not_finished?
    LearnedWord.remain_in_lesson(id).count > 0
  end

  def num_of_right_answers
    choices_id = LearnedWord.in_lesson(id).pluck :choice_id
    Choice.right_in_list(choices_id).count
  end

  def num_of_submitted_words
    LearnedWord.submitted_in_lesson(id).count
  end

  def first_remain_word
    LearnedWord.remain_in_lesson(id).first
  end
end
