require "spec_helper"

module Fx
  describe Configuration do
    after { restore_default_config }

    it "defaults the database adapter to postgres" do
      expect(Fx.configuration.database).to be_a Adapters::Postgres
      expect(Fx.database).to be_a Adapters::Postgres
    end

    it "allows the database adapter to be set" do
      adapter = double("Fx Adapter")

      Fx.configure do |config|
        config.database = adapter
      end

      expect(Fx.configuration.database).to eq adapter
      expect(Fx.database).to eq adapter
    end

    def restore_default_config
      Fx.configuration = Configuration.new
    end
  end
end
