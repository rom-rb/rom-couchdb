require 'rom'

require 'rom/couchdb/version'
require 'rom/couchdb/gateway'
require 'rom/couchdb/dataset'
require 'rom/couchdb/relation'
require 'rom/couchdb/commands'
require 'rom/couchdb/transproc_functions'

module ROM
  # CouchDB support for ROM
  module CouchDB
  end
end

ROM.register_adapter(:couchdb, ROM::CouchDB)
