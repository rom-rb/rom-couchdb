require 'test_helper'

class CommandsTest < Minitest::Test
  def setup
    @database_name = 'testdb'
    @setup = ROM.setup(:couchdb, @database_name)

    @setup.relation(:users)

    @setup.commands(:users) do
      define(:create)
      define(:update)
      define(:delete)
    end

    @rom = @setup.finalize
    @user_commands = @rom.command(:users)
  end

  def test_create_command
    user_data = { name: 'test_user_name', age: 12 }

    data = @user_commands.create.call(user_data)
    document = data.first

    assert_in_couch document

    # ensure the data is the same
    assert_equal ['test_user_name', 12], document.values_at(:name, :age)
  end

  def test_update_command
    #set up a raw couchdb connection and save a document
    connection = CouchRest.database(@database_name)
    document = {key: 'value'}
    connection.save_doc(document)

    assert_in_couch document

    #update the document
    document[:key] = 'new_value'

    updated_document = @user_commands.update.call(document).first

    #make sure the id is the same but the rev changed
    assert_equal document['_id'], updated_document['_id']
    refute_equal document['_rev'], updated_document['_rev']
  end

  def test_delete_command
    #set up a raw couchdb connection and save a document
    connection = CouchRest.database(@database_name)
    document = {key: 'value'}
    connection.save_doc(document)

    assert_in_couch document

    @user_commands.delete.call(document)

    # ensure the document was deleted
    assert_raises RestClient::ResourceNotFound do
      connection.get(document['_id'])
    end
  end

  private

  def assert_in_couch(document)
    # make sure we have a id and rev from couchdb
    refute_nil document['_id']
    refute_nil document['_rev']
  end
end
