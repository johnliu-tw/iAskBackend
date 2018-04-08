Rails.application.routes.draw do
  resources :paper_sets
  devise_for :users
  resources :paper_gradeships
  resources :grades
  resources :papersubject_subjectships
  resources :question_paperships
  resources :writing_questions
  resources :selection_questions
  resources :subjects
  resources :papers do
    resources :questions
  end
  resources :paper_subjects
  resources :home
  resources :student_answer_logs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#management"
  post 'paper_subjects/:id', :to => 'paper_subjects#update'
  post 'papers/:id', :to => 'papers#update'
  post 'papers/:id/questions/:id', :to => 'questions#update'
  get  'homes/management', :to => 'home#management'
  get  'papers/tools/select', :to => 'papers#select'
  get  'papers/tools/show_papers', :to => 'papers#show_papers'
  get  'user_analytics', :to => 'user_analytics#index'
  get  'paper_analytics', :to => 'paper_analytics#index'
  get  'paper_set_buy_analytics', :to => 'paper_set_buy_analytics#index'

  # APIS
  get  'papers/api/get_paper_by_platform', :to => 'papers#get_paper_by_platform' 
  get  'papers/api/get_papers_by_subject', :to => 'papers#get_papers_by_subject' 
  get  'papers/api/get_papers_by_paper_set', :to => 'papers#get_papers_by_paper_set'
  get  'papers/api/get_papers_by_subject_and_grade', :to => 'papers#get_papers_by_subject_and_grade'  
  get  'questions/api/get_questionList_by_paperId', :to => 'questions#get_questionList_by_paperId'
  get  'questions/api/get_question_by_questionId', :to => 'questions#get_question_by_questionId'
  get  'grades/api/get_grades_by_platform', :to => 'grades#get_grades_by_platform'
  get  'subjects/api/get_subjects_by_grade', :to => 'subjects#get_subjects_by_grade' 
  get  'paper_sets/api/get_paper_sets_by_platform', :to => 'paper_sets#get_paper_sets_by_platform' 
  get  'paper_sets/api/get_paper_sets_by_id', :to => 'paper_sets#get_paper_sets_by_id' 
  get  'paper_sets/api/check_paper_bought', :to => 'paper_sets#check_paper_bought' 

  post 'homes/api/answer_question_logs', :to => 'home#answer_question_logs' 
  post 'homes/api/answer_question_correct', :to => 'home#answer_question_correct' 
  post 'homes/api/answer_question_correct_first', :to => 'home#answer_question_correct_first' 
  post 'homes/api/open_paper', :to => 'home#open_paper' 
  post 'homes/api/finish_paper', :to => 'home#finish_paper' 
  
  post 'homes/api/student_open_paper_log', :to => 'home#student_open_paper_log' 
  post 'homes/api/student_open_question_log', :to => 'home#student_open_question_log' 
  post 'homes/api/student_finish_paper', :to => 'home#student_finish_paper' 
  post 'homes/api/student_ask_teacher_question', :to => 'home#student_ask_teacher_question' 
  get 'homes/api/show_log_api_data', :to => 'home#show_log_api_data' 

  post 'papers/api/filter', :to => 'papers#filter'
  post 'paper_sets/api/clear_paper_paper_set_id', :to => 'paper_sets#clear_paper_paper_set_id'
  post 'paper_sets/api/student_buy_paper_set', :to => 'paper_sets#student_buy_paper_set'
  post 'paper_analytics/api/filter', :to => 'paper_analytics#filter'
  post 'user_analytics/api/filter', :to => 'user_analytics#filter'
  post 'paper_set_buy_analytics/api/filter', :to => 'paper_set_buy_analytics#filter'
  
end


