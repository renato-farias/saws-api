require 'rubygems'
require 'sinatra'
require 'yaml'
require 'net/http'
require 'uri'
require 'cgi'
require 'time'
require 'openssl'
require 'base64'
require 'timeout'
require 'xmlsimple'
require 'pry'

require File.expand_path('../application.rb', __FILE__)
run App