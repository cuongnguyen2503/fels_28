class RemoveUserIdFromCourse < ActiveRecord::Migration
  def change
    remove_reference :courses, :user, index: true
  end
end
