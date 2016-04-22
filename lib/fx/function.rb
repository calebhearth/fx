module Fx
  # The in-memory representation of a function' source.
  #
  # **This object is used internally by adapters and the schema dumper and is
  # not intended to be used by application code. It is documented here for
  # use by adapter gems.**
  #
  # @api extension
  class Function
    # The name of the function
    # @return [String]
    attr_reader :name

    # The SQL declarations and statements that make up the function
    # @return [String]
    #
    # @example
    #   "DECLARE one integer; BEGIN RETURN 1; END;"
    attr_reader :source

    # Returns a new instance of Function.
    #
    # @param name [String] The name of the function.
    # @param source [String] The SQL for the declarations and statements that make up the function.
    def initialize(name:, source:)
      @name = name
      @source = source
    end

    # @api private
    def ==(other)
      name == other.name && source == other.source
    end

    # @api private
    def to_schema
      <<-SOURCE
  create_function :#{name}, sql_source: <<-\SQL
    #{source.indent(2)}
  SQL

      SOURCE
    end
  end
end
