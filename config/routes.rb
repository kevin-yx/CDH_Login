Rails.application.routes.draw do
  get 'genarate_pdfs/index'
  get 'genarate_pdfs/report_page'
  get 'genarate_pdfs/report_page2'
  get 'genarate_pdfs/export_by_css'
  get 'chd_login/index'
  get 'chd_login/bbb'
  get 'chd_login/login_test'
  get 'chd_login/login_other_method'
  get 'chd_login/login_with_cookie'
  get 'chd_login/test_login'
  get 'chd_login/abc'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
