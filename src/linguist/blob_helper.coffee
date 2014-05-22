mime = require 'mime-types'
path = require 'path'

class BlobHelper
  extname: ->
    path.extname @name

  mime_type: ->
    mime.lookup(path.basename @name) || 'text/plain'

module.exports = BlobHelper