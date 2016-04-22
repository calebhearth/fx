require "scenic/configuration"
require "scenic/adapters/postgres"
require "scenic/command_recorder"
require "scenic/definition"
require "scenic/railtie"
require "scenic/schema_dumper"
require "scenic/statements"
require "scenic/version"
require "scenic/view"
require "scenic/index"

# Fx adds methods `ActiveRecord::Migration` to create and manage database
# views in Rails applications.
module Fx
  # Hooks Fx into Rails.
  #
  # Enables scenic migration methods, migration reversability, and `schema.rb`
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
