class ResultsController < ApplicationController
  def show
    @course = Course.find_by id: params[:id]
    @learned_words = current_user.learned_words_in(@course.id)
  end
end
