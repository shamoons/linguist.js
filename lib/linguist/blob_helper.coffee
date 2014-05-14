mime = require 'mime'
path = require 'path'

class BlobHelper
  extname: (fileName) ->
    path.extname fileName

  _mime_type: (fileName) ->
    if @_mime_type?
      return @_mime_type
    else
      guesses = mime.lookup extname fileName

      console.log guesses

