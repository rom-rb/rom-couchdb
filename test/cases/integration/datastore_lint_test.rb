require 'test_helper'
require 'rom/lint/test'

class DatastoreLintTest < Minitest::Test
  include ROM::Lint::TestEnumerableDataset

  def setup
    @data  = [{ flavor: 'Peach', rank: 17 }, { flavor: 'Apple', rank: 29 }]
    @dataset = ROM::CouchDB::Dataset.new(@data, connection: nil)
  end
end
