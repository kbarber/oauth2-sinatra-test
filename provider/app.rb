#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra/base'
require 'rack/oauth2/sinatra'

class MyApp < Sinatra::Base
  configure :production, :development do
    mime_type :json, 'application/json'
    enable :logging
  end

  # Oauth2 stuff
  register Rack::OAuth2::Sinatra

  # Changing the token path, because the OAuth2 client seems to expect
  # this path instead of the default.
  oauth.access_token_path = '/oauth/token'

  oauth.database = Mongo::Connection.new["my_db"]
#  oauth.authenticator = lambda do |username, password|
#    user = User.find(username)
#    user if user && user.authenticated?(password)
#  end

  # Oauth specific stuff
  get '/oauth/authorize' do
    #if current_user
      #render 'oauth/authorize'
      erb :authorize
    #else
    #  redirect "/oauth/login?authorization=#{oauth.authorization}"
    #end
  end

  get '/oauth/grant' do
    oauth.grant! 'Superman'
  end

  get '/oauth/deny' do
    oauth.deny!
  end

  # Just some test content
  get '/hi' do
    "Hello world!: #{oauth.inspect}"
  end

  oauth_required "/api/v1/*"

  # Sample of protected data
  get '/api/v1/data.json' do
    content_type :json
    {'secret_data' => 'your_mum'}.to_json
  end

  run! if app_file == $0
end
