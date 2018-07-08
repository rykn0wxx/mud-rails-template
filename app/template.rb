copy_file 'app/assets/stylesheets/application.scss'
copy_file 'app/assets/stylesheets/_base.scss'
remove_file 'app/assets/stylesheets/application.css'

remove_file 'app/assets/javascripts/application.js'
copy_file 'app/assets/javascripts/application.js'

copy_file 'app/helpers/layout_helper.rb'
copy_file 'app/views/layouts/application.html.erb', :force => true
