Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#management"
  post 'paper_subjects/:id', :to => 'paper_subjects#update'
  post 'papers/:id', :to => 'papers#update'
  post 'papers/:id/questions/:id', :to => 'questions#update'
  get  'homes/management', :to => 'home#management'
  # APIS
  get  'papers/api/get_paper_by_platform', :to => 'papers#get_paper_by_platform' 
  get  'papers/api/get_papers_by_subject', :to => 'papers#get_papers_by_subject' 
  get  'questions/api/get_questionList_by_paperId', :to => 'questions#get_questionList_by_paperId'
  get  'questions/api/get_question_by_questionId', :to => 'questions#get_question_by_questionId'
  get  'grades/api/get_grades_by_platform', :to => 'grades#get_grades_by_platform'
  get  'subjects/api/get_subjects_by_grade', :to => 'subjects#get_subjects_by_grade' 

  post 'homes/api//homes/api/answer_question_logs', :to => 'homes#answer_question_logs' 
  post 'homes/api//homes/api/answer_question_correct', :to => 'homes#answer_question_correct' 
  post 'homes/api//homes/api/answer_question_correct_first', :to => 'homes#answer_question_correct_first' 
  post 'homes/api//homes/api/open_paper', :to => 'homes#open_paper' 
  post 'homes/api//homes/api/finish_paper', :to => 'homes#finish_paper' 

  post 'papers/api/filter', :to => 'papers#filter'
end
