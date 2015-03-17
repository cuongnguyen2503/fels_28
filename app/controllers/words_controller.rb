class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @word  = Word.new
    course_id = selected_course_id
    rbtn_value = selected_rbtn_value
    @words = words_filtered_by(course_id, rbtn_value)
    @words = @words.paginate(page: params[:page], per_page: 20)
  end

  def show
    @word = Word.find params[:id]
    @lesson = Lesson.find params[:lesson_id]
    @course = @lesson.course
    if params[:word].nil?
      @choices = @word.choices
    else
      process_answer
      next_word = @lesson.first_remain_word
      if next_word.nil?
        redirect_to lesson_path params[:lesson_id]
      else
        redirect_to lesson_word_path(@lesson.id, next_word.id)
      end
    end
  end

  private
    # Get selected course's id from selected box
    def selected_course_id
      if params[:word].nil?
        Course.first.id
      else
        @selected_course_id = params[:word][:course_id]
      end
    end

    # Get selected radio button's value
    def selected_rbtn_value
      if params[:word].nil?
        @selected_rbtn_value = "all"
      else
        @selected_rbtn_value = params[:word][:learned_status]
      end
    end

    # Get list words by filter condition
    def words_filtered_by(course_id, rbtn_value)
      case rbtn_value
      when "learned"
        words = current_user.learned_words_in course_id
      when "not_learned"
        words = current_user.not_learned_words_in course_id 
      when "all"
        words = Course.find_by(id: course_id).words
      end
    end

    def process_answer
      answer = params[:word][:choice]
      submitted_word = LearnedWord.find_by word_id: @word.id,
                                           lesson_id: params[:lesson_id] 
      submitted_word.update_attributes choice_id: answer
    end
end
