# Rom::CouchDB

[![Build Status](https://travis-ci.org/rom-rb/rom-couchdb.svg)](https://travis-ci.org/hmadison/rom-couchdb) [![Gem Version](https://badge.fury.io/rb/rom-couchdb.svg)](http://badge.fury.io/rb/rom-couchdb)

Experimental CouchDB support for ROM. Uses [couchrest](https://github.com/couchrest/couchrest) as the connection adapter.

## Installing

Add `gem 'rom-couchdb'` to your Gemfile.

## Example


```ruby
class Color
  attr_reader :name, :code, :id, :rev

  def initialize(attributes)
    puts attributes
    @name, @code, @id, @rev = attributes.values_at(:name, :code, :id, :rev)
  end
end

ROM.setup(:couchdb, 'testdb')

class Colors < ROM::Relation[:couchdb]
  def find_id(id)
    find_by_id(id)
  end

  def find_view(name, params)
    find_by_view(name, params)
  end
end

class ColorMapper < ROM::Mapper
  relation :colors
  register_as :entity

  model Color

  attribute :id, from: :'_id'
  attribute :rev, from: :'_rev'
  attribute :name
  attribute :code
end

class CreateColor < ROM::Commands::Create[:couchdb]
  register_as :create
  relation :colors
  result :one
end

class UpdateColor < ROM::Commands::Update[:couchdb]
  register_as :update
  relation :colors
  result :one
end

rom = ROM.finalize.env
color_commands = rom.command(:colors)
color_relations = rom.relation(:colors)


color = color_commands.as(:entity).create.call(name: "Red", code: 8)
update = color_commands.as(:entity).create.call(name: "Blue", code: 9, _id: color.id, _rev: color.rev)

find = color_relations.as(:entity).find_id(color.id).one
all_docs = color_relations.find_view('_all_docs', {})
```
