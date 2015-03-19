class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit, :update, :index, :show]
  before_action :admin_user,     only: [:new, :edit, :update, :destroy]

  def index
    @courses = Course.paginate page: params[:page]
  end

  def show
    @course = Course.find params[:id]
    @lessons = @course.lessons_learned_by_user current_user.id
  end

  def new
    @course = Course.new
    @lesson = @course.lessons.build
    @word = @course.words.build
    4.times {@word.choices.build}
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "New course has been created!"
      redirect_to courses_path
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      flash[:success] = "Course updated"
      redirect_to courses_path
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    flash[:success] = "Course deleted"
    redirect_to request.referrer || root_url     
  end

  private
    def course_params
      params.require(:course).permit :name, :content, lessons_attributes: [:course_id, :name], words_attributes: [:course_id, :word, :translation, choices_attributes: [:word_id, :choice]]
    end  

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end      
end
