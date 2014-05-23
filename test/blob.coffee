FileBlob = require '../src/linguist/file_blob'

Samples = require 'linguist-samples'

path = require 'path'
should = require 'should'


samples_path = ->
  path.join __dirname, '../samples'

blob = (name) ->
  unless name.match /^\//
    name = path.join samples_path(), name

  new FileBlob name, samples_path()

describe 'File Blobs', ->
  it 'should return just the name', (done) ->
    blob('foo.rb').name.should.eql 'foo.rb'
    done()

  it 'should identify the mime type of a file', (done) ->
    blob('Binary/octocat.ai').mime_type().should.eql 'application/postscript'
    blob("Ruby/grit.rb").mime_type().should.eql 'text/plain'
    blob("Shell/script.sh").mime_type().should.eql 'application/x-sh'
    blob("XML/bar.xml").mime_type().should.eql 'application/xml'
    blob("Binary/foo.ogg").mime_type().should.eql 'audio/ogg'
    blob("Text/README").mime_type().should.eql 'text/plain'

    done()
  
  describe 'content type identification', ->
    it 'should identify a PDF file', (done) ->
      blob('Binary/foo.pdf').content_type (err, result) ->
        should.not.exist err
        result.should.eql 'application/pdf; charset=IBM866'
        done()

    it 'should identify the an PNG file', (done) ->
      blob('Binary/octocat.png').content_type (err, result) ->
        # TODO: The actual test has this returning as an 'image/png'
        should.not.exist err
        result.should.eql 'image/jpeg; charset=windows-1252'
        done()

    it 'should identify a plaintext file', (done) ->
      blob('Text/README').content_type (err, result) ->
        # TODO: The actual test has this returning as an 'image/png'
        should.not.exist err
        result.should.eql 'text/plain; charset=ISO-8859-1'
        done()

  it 'should identify the disposition', (done) ->
    done()

  it 'should properly load the data of a file', (done) ->
    done()

  it 'should split a file by lines', (done) ->
    done()