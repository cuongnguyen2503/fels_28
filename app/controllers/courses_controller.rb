class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]  
  before_action :admin_user,     only: [:destroy]

  def index
    @courses = Course.paginate(page: params[:page])
  end

  def show
    @course = Course.find(params[:id])
    not_learned_words = current_user.not_learned_words_in(@course.id)
    if !not_learned_words.empty?
      redirect_to course_word_path(@course.id, not_learned_words.first.id)
    else
      redirect_to result_path(@course.id)
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "New course has been created!"
      redirect_to courses_path
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "Course updated"
      redirect_to courses_path
    else
      render 'edit'
    end
  end

  private
    def course_params
      params.require(:course).permit(:name, :content) 
    end  

    # Confirm correct user to edit course
    def correct_user
      @course = current_user.courses.find_by(id: params[:id])
      redirect_to courses_path if @course.nil?
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end      
end
