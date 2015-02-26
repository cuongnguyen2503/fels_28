class AddResultToLearnedwords < ActiveRecord::Migration
  def change
    add_column :learned_words, :result, :boolean, default: false
  end
end
