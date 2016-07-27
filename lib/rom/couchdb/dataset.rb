require 'couchrest'

require 'rom/support/options'
require 'rom/support/data_proxy'

module ROM
  module CouchDB
    # CouchDB Dataset
    class Dataset
      include ROM::Options
      include ROM::DataProxy

      attr_reader :results

      option :connection, reader: true

      def initialize(data, options = {})
        @data = data
        super
      end

      def insert(object)
        input = stringify_proc.call(object.dup)
        resp = @connection.save_doc(input)
        # send back the id and revision of the document
        object[:_id] = resp['id']
        object[:_rev] = resp['rev']
        self
      end
      alias << insert

      def delete(object)
        input = stringify_proc.call(object.dup)
        @connection.delete_doc(input)
        self
      end

      def count
        @data.count
      end

      def to_a
        @data
      end

      def find_by_id(id, params = {})
        document = @connection.get(id, params).to_hash
        self.class.new([document], connection: @connection)
      end

      def find_by_view(name, params = {})
        results = @connection.view(name, params)
        self.class.new([results], connection: @connection)
      end

      def stringify_proc
        TransprocFunctions[:stringify_keys]
      end

      def self.row_proc
        TransprocFunctions[:symbolize_keys]
      end
    end
  end
end
