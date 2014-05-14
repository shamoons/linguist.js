_ = require 'lodash'
StringScanner = require 'StringScanner'

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

  singleLineArray = []
  _.forEach SINGLE_LINE_COMMENTS, (c) ->
    singleLineArray.push "\s*#{RegExp.escape(c)} "

  START_SINGLE_LINE_COMMENT = new RegExp singleLineArray.join('|')

  multipleLineArray = []
  _.forEach SINGLE_LINE_COMMENTS, (c) ->
    multipleLineArray.push RegExp.escape c[0]

  START_MULTI_LINE_COMMENT = new RegExp multipleLineArray.join('|')

  tokenize: (data) ->
    extract_tokens(data)

  extract_tokens = (data) ->
    s = new StringScanner(data)
    tokens = []

    console.log data
    console.log s.bol()
    console.log START_SINGLE_LINE_COMMENT
    console.log s.scan /s*\/\/ |s*# |s*% /
    until s.eos()
      break if s.pos >= BYTE_LIMIT

      if token = s.scan(/^#!.+$/)
        if name = extract_shebang(token)
          tokens.push "SHEBANG#!#{name}"

      #Single line comment
      else if s.bol() and token = s.scan(START_SINGLE_LINE_COMMENT)
        s.skipUntil(/\n|\Z/)

      # Multiline comments
      else if token = s.scan(START_MULTI_LINE_COMMENT)
        throw "NEED TO DO THIS!"

      # Skip single or double quoted strings
      else if s.scan(/"/)
        if s.peek(1) is "\""
          s.getch()
        else
          w = s.skipUntil(/[^\\]"/)
      else if s.scan(/'/)
        if s.peek(1) is "'"
          s.getch()
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
        s.getch()

    tokens




module.exports.Tokenizer = Tokenizer