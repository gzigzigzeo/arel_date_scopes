$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

begin
  require "bundler"
  Bundler.setup
rescue Bundler::GemNotFound
  raise RuntimeError, "Bundler couldn't find some gems." +
    "Did you run `bundle install`?"
end

Bundler.require :test
Bundler.require

require 'logger'
require 'support/fake_record'

# Fake connection to supress ConnectionNotEstablished on AR tests
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3", 
  "database" => ":memory:"
)

# Replace AREL engine by our fake engine with schema and so on
Arel::Table.engine = Arel::Sql::Engine.new(FakeRecord::Base.new)

ActiveRecord::Base.logger = Logger.new(nil)
ActiveRecord::Base.send(:include, ArelDateScopes::ActiveRecord)

class User < ActiveRecord::Base
  set_table_name 'users'
  date_scopes_for :created_at
end

$: << File.join(File.dirname(__FILE__), '..', 'lib')