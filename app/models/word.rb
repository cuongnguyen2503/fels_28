class Word < ActiveRecord::Base
  belongs_to :course

  has_many :learned_words, dependent: :destroy
  has_many :choices, dependent: :destroy

  # Gets result of learned word
  def get_result(user_id)
    LearnedWord.where("user_id = #{user_id} and word_id = #{id}").select(:result).first.result
  end
end
