class AddTranslationToWords < ActiveRecord::Migration
  def change
    add_column :words, :translation, :string
  end
end
