require 'test_helper'

class DatasetTest < Minitest::Test
  def setup
    @sample_data = [{ test_key: 'test_value' }]
    @connection_mock = Minitest::Mock.new

    @dataset = ROM::CouchDB::Dataset.new(@connection_mock, @sample_data)
  end

  def test_insert
    @connection_mock.expect :save_doc, {}, [Hash]
    dataset = @dataset.insert(test_key: 'test_value')

    @connection_mock.verify
    assert_equal dataset, @dataset
  end

  def test_each
    @dataset.each do |data|
      @sample_data.include?(data)
    end
  end

  def test_find_by_id
    @connection_mock.expect :get, { new_key: 'new_value' }, [String, Hash]

    dataset = @dataset.find_by_id('test_id')

    @connection_mock.verify
    refute_equal dataset, @dataset
    assert_equal [{ new_key: 'new_value' }], dataset.results
  end

  def test_find_by_view
    @connection_mock.expect :view, {total_rows: 1, offset: 0, row: [{ new_key: 'new_value' }]}, [String, Hash]

    dataset = @dataset.find_by_view('view_name', {})

    @connection_mock.verify
    refute_equal dataset, @dataset
    assert_equal ([{total_rows: 1, offset: 0, row: [{ new_key: 'new_value' }]}]), dataset.results
  end
end
