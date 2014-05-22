FileBlob = require '../src/linguist/file_blob'

Samples = require 'linguist-samples'

path = require 'path'
should = require 'should'


samples_path = ->
  path.join __dirname, '../samples'

blob = (name) ->
  if name.match /^\//
    name = path.join samples_path(), name

  new FileBlob name, samples_path()

describe 'File Blobs', ->
  it 'should return just the name', ->
    blob('foo.rb').name.should.eql 'foo.rb'

  it 'should identify the mime type of a file', ->
    b = blob('Binary/octocat.ai')
    console.log b
    
