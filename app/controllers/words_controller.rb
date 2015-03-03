class WordsController < ApplicationController
  def index
    @word  = Word.new
    course_id = selected_course_id
    rbtn_value = selected_rbtn_value
    @words = words_filtered_by(course_id, rbtn_value)
    @words = @words.paginate(page: params[:page], per_page: 20)
  end

  def show
    if params[:word].nil?
      @course = Course.find params[:course_id]
      @word = Word.find params[:id]
      @choices = @word.choices
    else
      process_answer
      redirect_to course_path(params[:course_id])
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
        words = current_user.learned_words_in(course_id)
      when "not_learned"
        words = current_user.not_learned_words_in(course_id)
      when "all"
        words = Course.find_by(id: course_id).words
      end
    end

    # Processes the answer
    def process_answer
      answer = params[:word][:choice].to_s
      word = Word.find_by(id: params[:id])
      result = word.translation == answer
      LearnedWord.create!(user_id: current_user.id, word_id: word.id,
                          result: result)
    end
end
