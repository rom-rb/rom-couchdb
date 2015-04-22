require 'test_helper'
require 'rom/lint/test'

class RepositoryLintTest < Minitest::Test
  include ROM::Lint::TestRepository

  def setup
    @repository = ROM::CouchDB::Repository
    @identifier = :couchdb
    @uri = 'testdb'
  end

  def repository_instance
    ROM::CouchDB::Repository.new
  end
end
