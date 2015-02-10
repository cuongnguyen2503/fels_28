class LessonsController < ApplicationController
  def index
    @lessons = Lesson.paginate(page: params[:page])
  end

  def new
  end

  def show
    @lesson = Lesson.find(params[:id])
    @result = @lesson.result
  end
end
