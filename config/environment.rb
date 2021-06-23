ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'

Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['SINATRA_ENV'].to_sym)

require_relative '../app/models/concerns/slug_generator.rb'
require_all 'app'
