require 'test_helper'
require 'support/user'
class AdapterTest < Minitest::Test
  def setup
    @database_name = 'testdb'
    @setup = ROM.setup(:couchdb, @database_name)

    @setup.relation(:users) do
      def find_by_id(id)
        find_by_id(id)
      end

      def find_by_view(name)
        find_by_view(name)
      end
    end

    @setup.commands(:users) do
      define(:create)
      define(:update)
      define(:delete)
    end

    @setup.mappers do
      define(:users) do
        model User

        register_as :model

        attribute :id, from: '_id'
        attribute :name, from: 'name'
        attribute :age, from: 'age'
      end
    end

    @rom = @setup.finalize
    @user_commands = @rom.command(:users)
  end

end
