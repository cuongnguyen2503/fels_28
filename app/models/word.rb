class Word < ActiveRecord::Base
  belongs_to :course

  has_many :learned_words, dependent: :destroy
end
