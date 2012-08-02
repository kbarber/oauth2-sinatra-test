#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'oauth2'
require 'json'

set :port, 9494
enable :sessions
enable :logging

def client
  OAuth2::Client.new("5017fd0247c2c027c8000001", "4142f3b56ac369f974267be05bd9d1e90927e940b5cac2b3f431d8a4a2ffd2e7", :site => "http://localhost:4567")
end

get "/auth/test" do
  redirect client.auth_code.authorize_url(
    :redirect_uri => redirect_uri,
    #:scope => 'asdf',
    :state => 'fdsasf'
  )
end

get '/auth/test/callback' do
  if @error = params[:error]
    erb :failure
  else
    access_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
    session[:access_token] = access_token.token
    @message = "Successfully authenticated with the server"
    erb :success
  end
end

get '/yet_another' do
  @message = get_response('data.json')
  erb :success
end
get '/another_page' do
  @message = get_response('data.json')
  erb :another
end

def get_response(url)
  access_token = OAuth2::AccessToken.new(client, session[:access_token])
  JSON.parse(access_token.get("/api/v1/#{url}").body)
end

def redirect_uri
  uri = URI.parse(request.url)
  uri.path = '/auth/test/callback'
  uri.query = nil
  uri.to_s
end
