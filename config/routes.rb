Rails.application.routes.draw do
  get 'genarate_pdfs/index'

  get 'chd_login/index'
  get 'chd_login/login_test'
  get 'chd_login/login_other_method'
  get 'chd_login/login_with_cookie'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
