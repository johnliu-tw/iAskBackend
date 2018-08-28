module QuestionsHelper
    def render_question_answer_options(f, question_type, question_option_counts)
        case question_type
        when "single"
            case question_option_counts         
            when 4
                return  f.input :answer, collection: [ "A", "B", "C","D"],:item_wrapper_class => 'inline', as: :radio_buttons,input_html:{class: "question_answer_radio"}, label: ' 答案 ' 
            when 5
                return f.input :answer, collection: [ "A", "B", "C","D","E"],:item_wrapper_class => 'inline', as: :radio_buttons,input_html:{class: "question_answer_radio"}, label: ' 答案 ' 
            when 6
                return f.input :answer, collection: [ "A", "B", "C","D","E","F"],:item_wrapper_class => 'inline', as: :radio_buttons,input_html:{class: "question_answer_radio"}, label: ' 答案 '     
            end
                
        when "multiple"
            case question_option_counts
            when 4
                return f.input :answer, collection: [ "A", "B", "C","D"],:item_wrapper_class => 'inline', as: :check_boxes,input_html:{class: "question_answer_checkbox"}, label: ' 答案 ' 
            when 5
                return f.input :answer, collection: [ "A", "B", "C","D","E"],:item_wrapper_class => 'inline', as: :check_boxes,input_html:{class: "question_answer_checkbox"}, label: ' 答案 ' 
            when 6
                return f.input :answer, collection: [ "A", "B", "C","D","E","F"],:item_wrapper_class => 'inline', as: :check_boxes,input_html:{class: "question_answer_checkbox"}, label: ' 答案 ' 
            end
        end       
    end
end