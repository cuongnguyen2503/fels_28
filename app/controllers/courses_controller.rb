class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_user,   only: [:edit, :update]  
  before_action :admin_user,     only: [:destroy]

  def index
    @courses = Course.paginate page: params[:page]
  end

  def show
    @course = Course.find params[:id]
    @lessons = @course.lessons_learned_by_user current_user.id
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

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end      
end
