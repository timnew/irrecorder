require 'serialport'
require 'colorize'

require 'yaml'
require 'json'
require 'highline'

Dir['./lib/extensions/*'].each{|f| require(f)}
Dir['./lib/models/*'].each{|f| require(f)}