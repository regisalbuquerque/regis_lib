require 'regis_lib/view_helpers'
module RegisLib
  class Railtie < Rails::Railtie
    initializer "regis_lib.view_helpers" do
      ActiveSupport.on_load(:action_view) { include RegisLib::ViewHelpers }
    end
  end
end
