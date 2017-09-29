Rails.application.routes.draw do
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
  root "home#index"
  post 'paper_subjects/:id', :to => 'paper_subjects#update'
  post 'papers/:id', :to => 'papers#update'
end
