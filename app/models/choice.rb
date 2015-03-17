class Choice < ActiveRecord::Base
  belongs_to :word

  has_many :learned_words, dependent: :destroy

  scope :right_in_list, ->(choices_ids) {where(id: choices_ids, right_choice: true)}
end
