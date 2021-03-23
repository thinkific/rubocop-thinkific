# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/thinkific'
require_relative 'rubocop/thinkific/version'
require_relative 'rubocop/thinkific/inject'

RuboCop::Thinkific::Inject.defaults!

require_relative 'rubocop/cop/thinkific_cops'
