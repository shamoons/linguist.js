FileBlob = require '../src/linguist/file_blob'

Samples = require 'linguist-samples'

path = require 'path'
should = require 'should'


samples_path = ->
  path.join __dirname, '../samples'

blob = (name) ->
  if name.match /^\//
    name = path.join samples_path(), name

  a = new FileBlob name, samples_path()

describe 'File Blobs', ->
  it 'should return just the name', (done) ->
    blob('foo.rb').name.should.eql 'foo.rb'
    done()

  it.only 'should identify the mime type of a file', (done) ->
    blob('Binary/octocat.ai').mime_type().should.eql 'application/postscript'
    blob("Ruby/grit.rb").mime_type().should.eql 'text/plain'
    blob("Shell/script.sh").mime_type().should.eql 'application/x-sh'
    blob("XML/bar.xml").mime_type().should.eql 'application/xml'
    blob("Binary/foo.ogg").mime_type().should.eql 'audio/ogg'
    blob("Text/README").mime_type().should.eql 'text/plain'

    done()
  
  it 'should identify the content type', (done) ->
    done()

  it 'should identify the disposition', (done) ->
    done()

  it 'should properly load the data of a file', (done) ->
    done()

  it 'should split a file by lines', (done) ->
    done()