Rails.application.routes.draw do
  resources :papersubject_subjectships
  resources :question_paperships
  resources :writing_questions
  resources :selection_questions
  resources :subjects
  resources :papers
  resources :paper_subjects
  resources :home
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
end
