module ROM
  module CouchDB
    # Support #symbolize_keys for Hash
    module HashRefinements
      refine Hash do
        def symbolize_keys
          result = self.class.new
          keys.each do |key|
            result[key.to_sym] = delete(key)
          end
          result
        end

        def symbolize_keys!
          keys.each do |key|
            self[key.to_sym] = delete(key)
          end
          self
        end
      end
    end
  end
end
