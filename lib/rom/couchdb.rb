require 'rom'

require 'rom/couchdb/version'
require 'rom/couchdb/repository'
require 'rom/couchdb/dataset'
require 'rom/couchdb/relation'
require 'rom/couchdb/commands'

module ROM
  # CouchDB support for ROM
  module CouchDB
  end
end

ROM.register_adapter(:couchdb, ROM::CouchDB)
