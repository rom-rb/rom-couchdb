require 'couchrest'

module ROM
  module CouchDB
    # CouchDB gateway for ROM
    class Gateway < ROM::Gateway
      attr_reader :connection, :sets

      def initialize(uri)
        @connection = CouchRest.database(uri)
        @sets = {}
      end

      def dataset(name)
        @sets[name] = Dataset.new([], connection: @connection)
      end

      def [](name)
        @sets.fetch(name)
      end

      def dataset?(name)
        @sets.include?(name)
      end
    end
  end
end
