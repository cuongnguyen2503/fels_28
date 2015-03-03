class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :choice
      t.references :word, index: true

      t.timestamps
    end
  end
end
