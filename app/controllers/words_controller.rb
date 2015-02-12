class WordsController < ApplicationController
  def index
    @word  = Word.new
    course_id = get_selected_course_id
    rbtn_value = get_selected_rbtn_value
    @words = get_words_filtered_by(course_id, rbtn_value)
    @words = @words.paginate(page: params[:page], per_page: 20)
  end

  private
    # Get selected course's id from selected box
    def get_selected_course_id
      if params[:word].nil?
        Course.first.id
      else
        @selected_course_id = params[:word][:course_id]
      end
    end

    # Get selected radio button's value
    def get_selected_rbtn_value
      if params[:word].nil?
        @selected_rbtn_value = "all"
      else
        @selected_rbtn_value = params[:word][:learned_status]
      end
    end

    # Get list words by filter condition
    def get_words_filtered_by(course_id, rbtn_value)
      case rbtn_value
      when "learned"
        words = current_user.get_learned_words_in(course_id)
      when "not_learned"
        words = current_user.get_not_learned_words_in(course_id)
      when "all"
        words = Course.find_by(id: course_id).words
      end
    end
end
