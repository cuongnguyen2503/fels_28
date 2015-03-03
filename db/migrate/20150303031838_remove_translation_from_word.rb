class RemoveTranslationFromWord < ActiveRecord::Migration
  def change
    remove_column :words, :translation, :string
  end
end
