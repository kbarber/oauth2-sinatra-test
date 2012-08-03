#!/usr/bin/env ruby

require 'rubygems'
require 'oauth2'

client = OAuth2::Client.new('puppet-module-face', '', :site => 'http://localhost:4567')
token = client.password.get_token('ken', 'puppet')

puts token.get('/api/v1/data.json').body
