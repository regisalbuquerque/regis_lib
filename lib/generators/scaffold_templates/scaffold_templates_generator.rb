class ScaffoldTemplatesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)
  
  def copy_template_file
    copy_file "_form.html.erb.tt", "lib/templates/erb/scaffold/_form2.html.erb"
   # copy_file "_partial_header.html.erb.tt", "app/views/#{file_name.pluralize}/_#{file_name}_header.html.erb"
   # copy_file "_form.html.erb.tt", "app/views/#{file_name.pluralize}/_form.html.erb"
   # copy_file "_new.html.erb.tt", "app/views/#{file_name.pluralize}/_new.html.erb"
   # copy_file "edit.html.erb.tt", "app/views/#{file_name.pluralize}/edit.html.erb"
   # copy_file "show.html.erb.tt", "app/views/#{file_name.pluralize}/show.html.erb"
    
    copy_file "controller.rb.tt", "lib/templates/rails/controller2.rb"
  end
end
