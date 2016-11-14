require './config/boot'
require 'pry'

Dir['./app/**/*.rb'].each {|file| require file}
Pry.start
