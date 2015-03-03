class RemoveResultFromLearnedWord < ActiveRecord::Migration
  def change
    remove_column :learned_words, :result, :boolean
  end
end
