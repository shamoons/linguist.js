_ = require 'lodash'
StringScanner = require 'pstrscan'

class Tokenizer
  # Read up to 100KB
  BYTE_LIMIT = 100000

  # Start state on token, ignore anything till the next newline
  SINGLE_LINE_COMMENTS = [
    '//', # C
    '#',  # Ruby
    '%',  # Tex
  ]

  # Start state on opening token, ignore anything until the closing
  # token is reached.
  MULTI_LINE_COMMENTS = [
    ['/*', '*/'],    # C
    ['<!--', '-->'], # XML
    ['{-', '-}'],    # Haskell
    ['(*', '*)'],    # Coq
    ['"""', '"""']   # Python
  ]

  RegExp.escape = (str) ->
    String(str).replace /([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1"


  START_SINGLE_LINE_COMMENT = new RegExp _.map(SINGLE_LINE_COMMENTS, (c) ->
    "\\s*#{RegExp.escape(c)} "
  ).join('|')


  START_MULTI_LINE_COMMENT = new RegExp _.map(MULTI_LINE_COMMENTS, (c) ->
    RegExp.escape(c)
  ).join('|')

  tokenize: (data) ->
    extract_tokens(data)

  extract_tokens = (data) ->
    s = new StringScanner(data)
    tokens = []

    # console.log data
    # console.log s.atBOL()
    # console.log START_SINGLE_LINE_COMMENT
    # console.log START_SINGLE_LINE_COMMENT.exec(data)
    console.log s.scan(START_SINGLE_LINE_COMMENT)

    # console.log data.substr(0).search(START_SINGLE_LINE_COMMENT)
    until s.hasTerminated()
      break if s.pos >= BYTE_LIMIT

      if token = s.scan(/^#!.+$/)
        if name = extract_shebang(token)
          tokens.push "SHEBANG#!#{name}"

      #Single line comment
      else if s.atBOL() and token = s.scan(START_SINGLE_LINE_COMMENT)
        console.log s
        s.skipUntil(/\n|$/)
        console.log s

      # Multiline comments
      else if token = s.scan(START_MULTI_LINE_COMMENT)
        throw "NEED TO DO THIS!"

      # Skip single or double quoted strings
      else if s.scan(/"/)
        if s.peek(1) is "\""
          s.scanChar()
        else
          w = s.skipUntil(/[^\\]"/)
      else if s.scan(/'/)
        if s.peek(1) is "'"
          s.scanChar()
        else
          s.skipUntil(/[^\\]'/)

      # Skip number literals
      else if s.scan(/(0x)?\d(\d|\.)*/)

      # SGML style brackets
      else if token = s.scan(/<[^\s<>][^<>]*>/)
        # extract_sgml_tokens(token).each { |t| tokens << t }

      # Common programming punctuation
      else if token = s.scan(/;|\{|\}|\(|\)|\[|\]/)
        tokens.push token

      # Regular token
      else if token = s.scan(/[\w\.@#\/\*]+/)
        tokens.push token

      # Common operators
      else if token = s.scan(/<<?|\+|\-|\*|\/|%|&&?|\|\|?/)
        tokens.push token

      else
        s.scanChar()

    tokens




module.exports.Tokenizer = Tokenizer