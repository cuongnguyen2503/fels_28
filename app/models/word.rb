class Word < ActiveRecord::Base
  belongs_to :course

  has_many :learned_words, dependent: :destroy
  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, reject_if: ->(a){a[:choice].blank?}, allow_destroy: true

  scope :remain_in_course, ->(learned_words_ids, course_id) do
    where("course_id = #{course_id} and id not in (#{learned_words_ids})")
  end
end
