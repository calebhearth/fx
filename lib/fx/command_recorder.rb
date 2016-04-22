require "fx/command_recorder/statement_arguments"

module Fx
  # @api private
  module CommandRecorder
    def create_view(*args)
      record(:create_view, args)
    end

    def drop_view(*args)
      record(:drop_view, args)
    end

    def update_view(*args)
      record(:update_view, args)
    end

    def invert_create_view(args)
      [:drop_view, args]
    end

    def invert_drop_view(args)
      perform_fx_inversion(:create_view, args)
    end

    def invert_update_view(args)
      perform_fx_inversion(:update_view, args)
    end

    private

    def perform_fx_inversion(method, args)
      fx_args = StatementArguments.new(args)

      if fx_args.revert_to_version.nil?
        message = "#{method} is reversible only if given a revert_to_version"
        raise ActiveRecord::IrreversibleMigration, message
      end

      [method, fx_args.invert_version.to_a]
    end
  end
end
