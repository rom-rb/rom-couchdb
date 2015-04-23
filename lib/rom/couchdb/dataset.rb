require 'couchrest'

module ROM
  module CouchDB
    # CouchDB Dataset
    class Dataset
      using HashRefinements
      attr_reader :results
      def initialize(connection, results = [])
        @connection, @results = connection, results
      end

      def insert(object)
        @connection.save_doc(object.stringify_keys!)
        object.symbolize_keys!
        self
      end
      alias_method :<<, :insert

      def delete(object)
        @connection.delete_doc(object)
        self
      end

      def each(&block)
        @results.each(&block)
      end

      def count
        @results.count
      end

      def to_a
        @results
      end

      def find_by_id(id, params = {})
        document = @connection.get(id, params).to_hash
        self.class.new(@connection, [document.symbolize_keys!])
      end

      def find_by_view(name, params = {})
        documents = @connection.view(name, params).symbolize_keys
        self.class.new(@connection, documents)
      end
    end
  end
end
