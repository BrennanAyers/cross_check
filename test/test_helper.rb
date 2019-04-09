require 'simplecov'
require 'simplecov-console'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/game_team'
require './lib/game'
require './lib/team'
require './lib/stat_tracker.rb'
require './lib/season'
require './lib/team_specific_stats'
require 'mocha/minitest'

SimpleCov.formatter = SimpleCov::Formatter::Console

SimpleCov.start
