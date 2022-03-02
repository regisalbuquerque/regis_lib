# frozen_string_literal: true

require_relative "regis_lib/version"
require 'regis_lib/railtie' if defined?(Rails)

module RegisLib
  class Error < StandardError; end
  # Your code goes here...
end
