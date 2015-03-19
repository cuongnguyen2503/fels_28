class AddNameToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :name, :string
  end
end
