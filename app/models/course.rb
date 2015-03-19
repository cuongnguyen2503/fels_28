class Course < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  def words_not_in(word_ids)
    words.where.not id: word_ids
  end

  def lessons_learned_by_user(user_id)
    Lesson.learned_in_course_by_user id, user_id
  end

  def unfinished_lesson_by_user(user_id)
    unfinished_lesson = nil
    lessons_learned_by_user(user_id).each do |lesson|
      unfinished_lesson = lesson if lesson.not_finished?
    end
    unfinished_lesson
  end

  def finished_lessons_by_user(user_id)
    finished_lessons = []
    lessons_learned_by_user(user_id).each do |lesson|
      finished_lessons.push lesson if lesson.finished?
    end
    finished_lessons
  end
end
