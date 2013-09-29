ROOT = File.join(File.dirname(__FILE__), %w[ .. ])
$LOAD_PATH.unshift ROOT

require 'active_support/core_ext'
require 'rspec'
require 'conditions'
require 'rule'
require 'rules_engine'
