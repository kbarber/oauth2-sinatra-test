#!/usr/bin/env ruby

require 'rubygems'
require 'oauth2'

client = OAuth2::Client.new('5017fd0247c2c027c8000001', '4142f3b56ac369f974267be05bd9d1e90927e940b5cac2b3f431d8a4a2ffd2e7', :site => 'http://localhost:4567')
token = client.password.get_token('ken', 'puppet')

puts token.get('/api/v1/data.json').body
