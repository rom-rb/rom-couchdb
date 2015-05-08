require 'test_helper'

class DatasetTest < Minitest::Test
  def setup
    @sample_data = [{ test_key: 'test_value' }]
    @connection = CouchRest.database('testdb')

    @dataset = ROM::CouchDB::Dataset.new(@sample_data, connection: @connection)
  end

  def test_insert
    dataset = @dataset.insert(test_key: 'test_value')

    assert_equal dataset, @dataset
  end

  def test_each
    @dataset.each do |data|
      @sample_data.include?(data)
    end
  end

  def test_find_by_id
    @sample_doc = { key: 'value' }
    @connection.save_doc(@sample_doc)

    dataset = @dataset.find_by_id(@sample_doc['_id'])

    refute_equal dataset, @dataset
    assert_equal @sample_doc['_id'], dataset.to_a.first['_id']
  end

  def test_find_by_view
    dataset = @dataset.find_by_view('_all_docs', {})

    refute_equal dataset, @dataset
    assert_equal %w(total_rows offset rows), dataset.to_a.first.keys
  end
end
