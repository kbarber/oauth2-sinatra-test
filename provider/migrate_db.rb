#!/usr/bin/env ruby

require 'rubygems'
require 'dm-migrations'
require 'rack/oauth2/models/datamapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:///Users/ken/Development/oauth2-sinatra-test/provider/db/development.db')
DataMapper.auto_upgrade!
