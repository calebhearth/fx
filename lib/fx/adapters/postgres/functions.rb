module Fx
  module Adapters
    class Postgres
      # Fetches defined functions from the Postgres connection.
      # @api private
      class Functions
        def initialize(connection)
          @connection = connection
        end

        # All of the functions that this connection has defined.
        #
        # @return [Array<Fx::Function>]
        def all
          functions_from_postgres.map(&method(:to_fx_function))
        end

        private

        attr_reader :connection

        def functions_from_postgres
          connection.execute(<<-SQL)
            SELECT  p.proname, p.prosrc
              FROM pg_catalog.pg_namespace n
            JOIN pg_catalog.pg_proc p
              ON p.pronamespace = n.oid
            WHERE   n.nspname = 'public'
          SQL
        end

        def to_fx_function(result)
          Fx::Function.new(
            name: result["proname"],
            source: result["prosrc"].strip,
          )
        end
      end
    end
  end
end
