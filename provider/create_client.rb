#!/usr/bin/env ruby

require 'rubygems'
require 'rack/oauth2/server'
require 'rack/oauth2/models/datamapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:///Users/ken/Development/oauth2-sinatra-test/provider/db/development.db')

client = Rack::OAuth2::Server.register(
  :secret => '4142f3b56ac369f974267be05bd9d1e90927e940b5cac2b3f431d8a4a2ffd2e7',
  :display_name => 'oauth2-sinatra-test-consumer',
  :link => 'http://localhost:9494/',
  :redirect_uri => "http://localhost:9494/auth/test/callback",
  :id => '5017fd0247c2c027c8000001',
  :scope => []
)
