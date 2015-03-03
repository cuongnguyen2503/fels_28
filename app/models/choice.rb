class Choice < ActiveRecord::Base
  belongs_to :word

  has_many :learned_words, dependent: :destroy
end
