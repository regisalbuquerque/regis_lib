class DynamicSelectGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :select1, type: :string, default: "select1", banner: "select1"
  argument :select2, type: :string, default: "select2", banner: "select2"

  def url
    "#{select2.pluralize}_#{name.underscore.pluralize}_path"
  end

  def method_name
    "#{select2.pluralize}"
  end

  def select1_model
    select1.camelize 
  end

  def select2_model
    select2.camelize
  end

  def show_vars
    puts "Model: " + name
    puts "Select 1: " + select1
    puts "Select 2: " + select2
    puts url
    puts "Param: " + select1
    puts "method: " + method_name
    puts "Model Select 1: " + select1_model
    puts "Model Select 2: " + select2_model

  end

  def form_selects
    form_select_file = "form_selects_#{select1}_#{select2}" 
    template "_form_select_fields.html.erb.tt", "app/views/#{file_name.pluralize}/" + form_select_file + ".html.erb"
    
    render_str = "<%= render \"#{form_select_file}\", form:form %>"
    inject_into_file("app/views/#{file_name.pluralize}/_form.html.erb", "\n" + render_str + "\n", :after => "<div class=\"row\">" )

  end

  def model_select2
    # inject_into_file

    str = "scope :_search_#{select1}_id_, ->(#{select1}_id){\n"
    str += "  where(\"#{select1}_id = ?\", #{select1}_id)\n"
    str += "  .order(:id)\n"
    str += "}"

    inject_into_file("app/models/#{select2}.rb", "\n" + str + "\n", :after => "ApplicationRecord" )

  end

  def controller_inject

    # inject_into_file

    str = "def #{method_name}\n"
    str += "  @target = params[:target]\n"
    str += "  @#{method_name} = #{select2_model}._search_#{select1}_id_(params[:#{select1}])\n"
    str += "  respond_to do |format|\n"
    str += "    format.turbo_stream\n"
    str += "  end\n"
    str += "end\n"

    inject_into_file("app/controllers/#{file_name.pluralize}_controller.rb", "\n" + str + "\n", :before => "private" )
  end

  def turbo_stream_file
    template "search.turbo_stream.erb.tt", "app/views/#{file_name.pluralize}/#{method_name}.turbo_stream.erb"
  end

  def collection_route
    # inject_into_file

    str = "collection do\n"
    str += "  get :#{method_name}\n"
    str += "end\n"
    
    # inject_into_file("config/routes.rb", "\n" + str + "\n", :after => "resources :#{file_name.pluralize} do" )
    puts "Ajustar o arquivo config/routes.rb" 
    puts "resources :#{file_name.pluralize} do" 
    puts str
  end
end
