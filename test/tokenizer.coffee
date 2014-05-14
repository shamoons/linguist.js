require '../lib/linguist'

should = require 'should'
{Tokenizer} = require '../lib/linguist/tokenizer'

Tokenizer = new Tokenizer()

tokenize = (data) ->
  Tokenizer.tokenize(data)

describe 'Tokenizer', ->
  it 'should skip string literals', ->
    tokenize('print ""').should.eql ['print']
    tokenize('print "Josh"').should.eql ['print']
    tokenize("print 'Josh'").should.eql ['print']
    tokenize('print "Hello \\"Josh\\""').should.eql ['print']
    tokenize("print 'Hello \\'Josh\\''").should.eql ['print']
    tokenize("print \"Hello\", \"Josh\"").should.eql ['print']
    tokenize("print 'Hello', 'Josh'").should.eql ['print']
    tokenize("print \"Hello\", \"\", \"Josh\"").should.eql ['print']
    tokenize("print 'Hello', '', 'Josh'").should.eql ['print']

  it 'should skip number literals', ->
    tokenize('1 + 1').should.eql ['+']
    tokenize('add(123, 456)').should.eql ['add', '(', ')']
    tokenize('0x01 | 0x10').should.eql ['|']
    tokenize('500.42 * 1.0').should.eql ['*']

  it.only 'should skip comments', ->
    tokenize("foo\n# Comment").should.eql ['foo']