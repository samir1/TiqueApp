Rails.application.routes.draw do

    root    'home#index'
    resources :users
    get     '/signup',                           to: 'users#new'
    get     '/credentials',                      to: 'users#show'
    post    'users/create'
    get     '/login',                            to: 'sessions#new'
    post    '/login',                            to: 'sessions#create'
    delete  '/logout',                           to: 'sessions#destroy'
    get     '/logout',                           to: 'sessions#destroy'
    get     '/addinstructor',                    to: 'instructor_student_lookups#add_instructor'
    post    '/addinstructor',                    to: 'instructor_student_lookups#create'
    get     '/viewinstructors',                  to: 'instructor_student_lookups#view_instructors'
    get     '/my_feedback',                      to: 'critiques#my_feedback'
    get     '/give_feedback/:instructor_code',   to: 'critiques#give_feedback'
    post    '/submit_feedback/:instructor_code', to: 'critiques#submit_feedback'
    get     '/users',                            to: 'home#index'
    # resources :critiques
    
end