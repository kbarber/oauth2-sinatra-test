#!/usr/bin/env ruby

require 'rubygems'
require 'net/http'
require 'json'

uri = URI('http://localhost:4567/oauth/token')
res = Net::HTTP.post_form(uri,
  'client_id' => 'puppet-module-face',
  'client_secret' => '',
  'grant_type' => 'password',
  'username' => 'ken',
  'password' => 'puppet'
)

result = JSON.parse(res.body)
token = result['access_token']

puts "Recieved token: #{token}"

uri = URI('http://localhost:4567/api/v1/data.json')
req = Net::HTTP::Get.new(uri.request_uri)

req['Authorization'] = "Bearer #{token}"

res = Net::HTTP.start(uri.host, uri.port) do |http|
  http.request(req)
end

puts res.body
