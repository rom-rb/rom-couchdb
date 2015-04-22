require 'rom/commands'

module ROM
  module CouchDB
    module Commands
      # CouchDB create command
      class Create < ROM::Commands::Create
        def collection
          relation.dataset
        end

        def execute(object)
          document = object.dup
          collection << document
          [document]
        end
      end

      # CouchDB update command
      class Update < ROM::Commands::Update
        def collection
          relation.dataset
        end

        def execute(object)
          document = object.dup
          collection << (document)
          [document]
        end
      end

      # CouchDB delete command
      class Delete < ROM::Commands::Delete
        def collection
          relation.dataset
        end

        def execute(object)
          collection.delete(object)
          [object]
        end
      end
    end
  end
end
