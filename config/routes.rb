Rails.application.routes.draw do
  # get 'patient_lab/index'
  resources :patient_lab, only: [:index, :create]
end
