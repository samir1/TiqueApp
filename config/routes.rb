Rails.application.routes.draw do

    root    'home#index'
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
    get     '/my_feedback/:instructor_code',     to: 'critiques#my_feedback_with_code'
    get     '/give_feedback/:instructor_code',   to: 'critiques#give_feedback'
    get     '/refresh_pluses_minuses/:instructor_code',   to: 'critiques#refresh_pluses_minuses'
    post    '/submit_feedback/:instructor_code', to: 'critiques#submit_feedback'
    post    '/delete_critique/:instructor_code', to: 'critiques#delete_critique'
    get     '/users',                            to: 'users#index'    
    get     '/rules',                            to: 'application#rules'
    post    '/submit_vote/:instructor_code',     to: 'votes#create'
    get     '/get_tiqued',                       to: 'codes#get_tiqued'

    # TODO: edit_ta_emails needs to use GET instead of POST
    get     '/edit_ta_emails',                   to: 'codes#get_tiqued'
    post    '/edit_ta_emails',                   to: 'codes#edit_ta_emails'
    post    '/update_ta_emails',                 to: 'codes#update_ta_emails'
    resources :users
    resources :critiques, only: [:show, :index, :destroy]
    resources :codes, only: [:create, :destroy]

end
