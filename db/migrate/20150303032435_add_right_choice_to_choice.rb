class AddRightChoiceToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :right_choice, :boolean, default: false
  end
end
