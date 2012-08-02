#!/usr/bin/env ruby

require 'rubygems'
require 'net/http'
require 'json'

uri = URI('http://localhost:4567/oauth/token')
res = Net::HTTP.post_form(uri,
  'client_id' => '5017fd0247c2c027c8000001',
  'client_secret' => '4142f3b56ac369f974267be05bd9d1e90927e940b5cac2b3f431d8a4a2ffd2e7',
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
