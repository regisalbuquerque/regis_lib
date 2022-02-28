require "rails/generators/resource_helpers"

class ResourceviewGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "field:type field:type"
  class_option :parent, type: :string

  def inicializar  
     @parent = options[:parent]
  end

  def controller_class_name
    file_name.pluralize.camelize
    # Nao foi usado o name.pluralize pq tem problemas com a pluralização da palavra item (items em vez de itens)    
  end

  def parent_model_resource_name 
    @parent.underscore
  end

  def singular_parent_table_name 
    @parent.underscore
  end
  
  def plural_parent_table_name 
    @parent.underscore.pluralize
  end

  def model_name 
    name
  end
  
  def model_name_pluralize 
    name.pluralize
  end

  def parent_model_name
    @parent
  end
  
  def permitted_params
     params = ''
     for attribute in attributes do
       virgula = ','
       if attribute == attributes.last
          virgula = ''
       end
       params += ' :' + attribute.name + virgula
     end
     params
  end 

  def create_files
    # O FORM fica no template de SCAFFOLD:
    template "../erb/scaffold/_form.html.erb.tt", "app/views/#{file_name.pluralize}/_form.html.erb"

    # TEMPLATES DO GENERATOR:
    template "_partial.html.erb.tt", "app/views/#{file_name.pluralize}/_#{file_name}.html.erb"
    template "_partial_header.html.erb.tt", "app/views/#{file_name.pluralize}/_#{file_name}_header.html.erb"
    template "_new.html.erb.tt", "app/views/#{file_name.pluralize}/_new.html.erb"
    template "edit.html.erb.tt", "app/views/#{file_name.pluralize}/edit.html.erb"
    template "show.html.erb.tt", "app/views/#{file_name.pluralize}/show.html.erb"

    template "_parent_list.html.erb.tt", "app/views/#{plural_parent_table_name}/_#{file_name.pluralize}.html.erb"
    template "resource_controller.rb.tt", "app/controllers/#{file_name.pluralize}_controller.rb"

    puts "CHECKLIST:"
    if @parent.present? 
      puts "Include in app/models/#{singular_parent_table_name}.rb :" 
      puts " has_many :#{file_name.pluralize}"
      puts " ------- "
      puts "Include in app/views/#{plural_parent_table_name}/show.html.erb (AFTER: <%= render @#{singular_parent_table_name} %>) :"
      puts "<%= render \"#{plural_parent_table_name}/#{file_name.pluralize}\", #{singular_parent_table_name}: @#{singular_parent_table_name} %>"
      puts " ------- "
      puts "Include in config/routes.rb :"
      puts " resources :#{plural_parent_table_name} do"
      puts "    resources :#{plural_table_name}"
      puts " end"
      puts " resources :#{plural_table_name}"
    end   


  end


end
