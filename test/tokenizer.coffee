require '../lib/linguist'

should = require 'should'
{Tokenizer} = require '../lib/linguist/tokenizer'

Tokenizer = new Tokenizer()

tokenize = (data) ->
  Tokenizer.tokenize(data)

describe 'Tokenizer', ->
  it 'should skip string literals', ->
    tokenize('print ""')[0].should.equal 'print'
    tokenize('print ""')[0].should.equal 'print'
    tokenize('print "Josh"')[0].should.equal 'print'
    tokenize("print 'Josh'")[0].should.equal 'print'
    tokenize('print "Hello \"Josh\""')[0].should.equal 'print'
    tokenize("print 'Hello \\'Josh\\''")[0].should.equal 'print'
    tokenize("print \"Hello\", \"Josh\"")[0].should.equal 'print'
    tokenize("print 'Hello', 'Josh'")[0].should.equal 'print'
    tokenize("print \"Hello\", \"\", \"Josh\"")[0].should.equal 'print'
    tokenize("print 'Hello', '', 'Josh'")[0].should.equal 'print'

  it 'should skip number literals', ->