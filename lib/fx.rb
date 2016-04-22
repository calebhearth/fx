require "fx/configuration"
require "fx/adapters/postgres"
require "fx/command_recorder"
require "fx/definition"
require "fx/railtie"
require "fx/schema_dumper"
require "fx/statements"
require "fx/version"
require "fx/view"
require "fx/index"

# Fx adds methods `ActiveRecord::Migration` to create and manage database
# views in Rails applications.
module Fx
  # Hooks Fx into Rails.
  #
  # Enables fx migration methods, migration reversability, and `schema.rb`
  # dumping.
  def self.load
    ActiveRecord::ConnectionAdapters::AbstractAdapter.include Fx::Statements
    ActiveRecord::Migration::CommandRecorder.include Fx::CommandRecorder
    ActiveRecord::SchemaDumper.prepend Fx::SchemaDumper
  end

  # The current database adapter used by Fx.
  #
  # This defaults to {Adapters::Postgres} but can be overridden
  # via {Configuration}.
  def self.database
    configuration.database
  end
end
