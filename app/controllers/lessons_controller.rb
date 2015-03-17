class LessonsController < ApplicationController
  before_action :logged_in_user, only: [:show]

  def show
    @lesson = Lesson.find params[:id]
    @course = @lesson.course
    @learned_words = @lesson.learned_words
  end
end
