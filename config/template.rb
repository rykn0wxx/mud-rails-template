apply 'config/application.rb'

directory 'config/environments', 'config/environments', :force => true

generate :controller, 'welcome index'

remove_file 'config/routes.rb'
copy_file 'config/routes.rb'
