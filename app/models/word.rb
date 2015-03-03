class Word < ActiveRecord::Base
  belongs_to :course

  has_many :learned_words, dependent: :destroy
  has_many :choices, dependent: :destroy
  
  scope :not_learned_in_course, ->(learned_words_id, course_id)
    {where("course_id = #{course_id} and id not in (#{learned_words_id})")}

  # Gets result of learned word
  def get_result(user_id)
    LearnedWord.where("user_id = #{user_id} and word_id = #{id}").select(:result).first.result
  end
end
