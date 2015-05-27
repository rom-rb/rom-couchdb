require 'test_helper'
require 'rom/lint/test'

class GatewayLintTest < Minitest::Test
  include ROM::Lint::TestGateway

  def setup
    @gateway = ROM::CouchDB::Gateway
    @identifier = :couchdb
    @uri = 'testdb'
  end

  def gateway_instance
    ROM::CouchDB::Gateway.new
  end
end
