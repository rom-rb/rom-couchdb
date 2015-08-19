require 'rom/relation'

module ROM
  module CouchDB
    # CouchDB relation support
    class Relation < ROM::Relation
      adapter :couchdb
      forward :insert, :find_by_id, :find_by_view

      def count
        dataset.count
      end
    end
  end
end
