class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :translation
      t.references :course, index: true

      t.timestamps
    end
  end
end
