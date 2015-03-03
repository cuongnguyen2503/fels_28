class RemoveUserIdFromLearnedWord < ActiveRecord::Migration
  def change
    remove_reference :learned_words, :user, index: true
  end
end
