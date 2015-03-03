class AddLessonIdAndChoiceIdToLearnedWord < ActiveRecord::Migration
  def change
    add_reference :learned_words, :lesson, index: true
    add_reference :learned_words, :choice, index: true
  end
end
