require "rails"

module Fx
  # @api private
  module SchemaDumper
    def tables(stream)
      super
      functions(stream)
    end

    def functions(stream)
      if dumpable_functions_in_database.any?
        stream.puts
      end

      dumpable_functions_in_database.each do |function|
        stream.puts(function.to_schema)
        indexes(function.name, stream)
      end
    end

    private

    def dumpable_functions_in_database
      @dumpable_functions_in_database ||= Fx.database.functions.reject do |function|
        ignored?(function.name)
      end
    end
  end
end
