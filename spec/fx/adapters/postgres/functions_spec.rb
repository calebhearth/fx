require "spec_helper"

module Fx
  module Adapters
    describe Postgres::Functions, :db do
      it "returns fx view objects for plain old functions" do
        connection = ActiveRecord::Base.connection
        connection.execute <<-SQL
          CREATE FUNCTION getOne () RETURNS int AS $one$
          DECLARE one integer; BEGIN RETURN 1; END;
          $one$ LANGUAGE plpgsql;
        SQL

        functions = Postgres::Functions.new(connection).all
        first = functions.first

        expect(functions.size).to eq 1
        expect(first.name).to eq "getone"
        expect(first.source).to eq "DECLARE one integer; BEGIN RETURN 1; END;"
      end
    end
  end
end
