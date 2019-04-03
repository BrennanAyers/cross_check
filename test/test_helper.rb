require 'simplecov'
require 'simplecov-console'
require "minitest/autorun"
require "csv"
require "./lib/game"
require "./lib/stat_tracker.rb"
SimpleCov.formatter = SimpleCov::Formatter::Console

SimpleCov.start
