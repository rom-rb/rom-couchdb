require 'test_helper'

class HashRefinementsTest < Minitest::Test
  using ROM::CouchDB::HashRefinements

  def test_symbolize_keys
    string_hash = { 'test_key' => 'test_value' }
    symbol_hash = { test_key: 'test_value' }
    assert_equal symbol_hash, string_hash.symbolize_keys
  end

  def test_symbolize_keys!
    string_hash = { 'test_key' => 'test_value' }
    symbol_hash = { test_key: 'test_value' }
    string_hash.symbolize_keys!
    assert_equal symbol_hash, string_hash
  end
end
