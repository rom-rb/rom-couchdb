require 'couchrest'

module ROM
  module CouchDB
    # CouchDB Dataset
    class Dataset
      attr_reader :results
      def initialize(connection, results = [])
        @connection, @results = connection, results
      end

      def insert(object)
        @connection.save_doc(object)
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

      def find_by_id(id, params = {})
        document = @connection.get(id, params).to_hash
        self.class.new(@connection, [document])
      end

      def find_by_view(name, params = {})
        documents = @connection.view(name, params)
        self.class.new(@connection, documents)
      end
    end
  end
end
