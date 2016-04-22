module Fx
  class Configuration
    # The Fx database adapter instance to use when executing SQL.
    #
    # Defualts to an instance of {Adapters::Postgres}
    # @return Fx adapter
    attr_accessor :database

    def initialize
      @database = Fx::Adapters::Postgres.new
    end
  end

  # @return [Fx::Configuration] Fx's current configuration
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Set Fx's configuration
  #
  # @param config [Fx::Configuration]
  def self.configuration=(config)
    @configuration = config
  end

  # Modify Fx's current configuration
  #
  # @yieldparam [Fx::Configuration] config current Fx config
  # ```
  # Fx.configure do |config|
  #   config.database = Fx::Adapters::Postgres.new
  # end
  # ```
  def self.configure
    yield configuration
  end
end
