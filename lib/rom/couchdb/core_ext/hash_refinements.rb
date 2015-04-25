module ROM
  module CouchDB
    # Support #symbolize_keys for Hash
    module HashRefinements
      refine Hash do
        def stringify_keys
          result = self.class.new
          keys.each do |key|
            result[key.to_s] = self[key]
          end
          result
        end

        def stringify_keys!
          keys.each do |key|
            self[key.to_s] = delete(key)
          end
          self
        end

        def symbolize_keys
          result = self.class.new
          keys.each do |key|
            result[key.to_sym] = self[key]
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
