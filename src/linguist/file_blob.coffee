BlobHelper = require './blob_helper'

class FileBlob extends BlobHelper
  constructor: (path, base_path = null) ->
    super
    @path = path
    @name = if base_path? then path.replace("#{base_path}/", '') else path


  # # Read up to 100KB
  # BYTE_LIMIT = 100000

  # # Start state on token, ignore anything till the next newline
  # SINGLE_LINE_COMMENTS = [
  #   '//', # C
  #   '#',  # Ruby
  #   '%',  # Tex
  # ]

  # # Start state on opening token, ignore anything until the closing
  # # token is reached.
  # MULTI_LINE_COMMENTS = [
  #   ['/*', '*/'],    # C
  #   ['<!--', '-->'], # XML
  #   ['{-', '-}'],    # Haskell
  #   ['(*', '*)'],    # Coq
  #   ['"""', '"""']   # Python
  # ]

  # RegExp.escape = (str) ->
  #   String(str).replace /([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1"


  # START_SINGLE_LINE_COMMENT = new RegExp _.map(SINGLE_LINE_COMMENTS, (c) ->
  #   "\s*#{RegExp.escape(c)} "
  # ).join('|')


  # START_MULTI_LINE_COMMENT = new RegExp _.map(MULTI_LINE_COMMENTS, (c) ->
  #   RegExp.escape(c[0])
  # ).join('|')

  # tokenize: (data) ->
  #   extract_tokens(data)

  # extract_tokens = (data) ->
  #   s = new StringScanner(data)
  #   tokens = []

  #   until s.hasTerminated()
  #     break if s.pos >= BYTE_LIMIT

  #     if token = s.scan(/^#!.+$/)
  #       if name = extract_shebang(token)
  #         tokens.push "SHEBANG#!#{name}"

  #     #Single line comment
  #     else if s.atBOL() and token = s.scan(START_SINGLE_LINE_COMMENT)
  #       s.skipUntil(/\n|$/)

  #     # Multiline comments
  #     else if token = s.scan(START_MULTI_LINE_COMMENT)
  #       MULTI_LINE_COMMENTS_flat = _.flatten MULTI_LINE_COMMENTS
  #       close_token = MULTI_LINE_COMMENTS_flat[_.indexOf(MULTI_LINE_COMMENTS_flat, token) + 1]

  #       close_token_regex = new RegExp RegExp.escape(close_token)

  #       s.skipUntil(close_token_regex)

  #     # Skip single or double quoted strings
  #     else if s.scan(/"/)
  #       if s.peek(1) is "\""
  #         s.scanChar()
  #       else
  #         w = s.skipUntil(/[^\\]"/)
  #     else if s.scan(/'/)
  #       if s.peek(1) is "'"
  #         s.scanChar()
  #       else
  #         s.skipUntil(/[^\\]'/)

  #     # Skip number literals
  #     else if s.scan(/(0x)?\d(\d|\.)*/)

  #     # SGML style brackets
  #     else if token = s.scan(/<[^\s<>][^<>]*>/)
  #       _.forEach extract_sgml_tokens(token), (t) ->
  #         tokens.push t

  #     # Common programming punctuation
  #     else if token = s.scan(/;|\{|\}|\(|\)|\[|\]/)
  #       tokens.push token

  #     # Regular token
  #     else if token = s.scan(/[\w\.@#\/\*]+/)
  #       tokens.push token

  #     # Common operators
  #     else if token = s.scan(/<<?|\+|\-|\*|\/|%|&&?|\|\|?/)
  #       tokens.push token

  #     else
  #       s.scanChar()

  #   tokens

  # extract_sgml_tokens = (data) ->
  #   s = new StringScanner data

  #   tokens = []

  #   until s.hasTerminated()
  #     # Emit start token
  #     if token = s.scan(/<\/?[^\s>]+/)
  #       tokens.push "#{token}>"

  #     # Emit attributes with trailing =
  #     else if token = s.scan(/\w+=/)
  #       tokens.push token

  #       # Then skip over attribute value
  #       if s.scan(/"/)
  #         s.skipUntil(/[^\\]"/)
  #       else if s.scan(/'/)
  #         s.skipUntil(/[^\\]'/)
  #       else
  #         s.skipUntil(/\w+/)

  #     # Emit lone attributes
  #     else if token = s.scan(/\w+/)
  #       tokens.push token

  #     # Stop at the end of the tag
  #     else if s.scan(/>/)
  #       s.terminate()

  #     else
  #       s.scanChar()
  #     end
  #   end

  #   tokens



module.exports = FileBlob