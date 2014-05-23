istextorbinary = require 'istextorbinary'
mime = require 'mime-types'
path = require 'path'
tika = require 'tika'

class BlobHelper
  extname: ->
    path.extname @name

  mime_type: ->
    mime.lookup(path.basename @name) || 'text/plain'

  content_type: (content_typeCb) ->
    # TODO: We return the charset encoding as well for all types
    tika.type @path, true, content_typeCb

module.exports = BlobHelper