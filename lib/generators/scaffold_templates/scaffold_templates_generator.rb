class ScaffoldTemplatesGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  
  def copy_template_file
    copy_file "_form.html.erb.tt", "lib/templates/erb/scaffold/_form.html.erb.tt"
    copy_file "edit.html.erb.tt", "lib/templates/erb/scaffold/edit.html.erb.tt"
    copy_file "index.html.erb.tt", "lib/templates/erb/scaffold/index.html.erb.tt"
    copy_file "new.html.erb.tt", "lib/templates/erb/scaffold/new.html.erb.tt"
    copy_file "partial.html.erb.tt", "lib/templates/erb/scaffold/partial.html.erb.tt"
    copy_file "show.html.erb.tt", "lib/templates/erb/scaffold/show.html.erb.tt"
    
    copy_file "controller.rb.tt", "lib/templates/rails/controller.rb.tt"
    copy_file "api_controller.rb.tt", "lib/templates/rails/api_controller.rb.tt"
  end
end
