_ = require 'lodash'
istextorbinary = require 'istextorbinary'
mime = require 'mime-types'
path = require 'path'
tika = require 'tika'

class BlobHelper
  extname: ->
    path.extname(@name).toLowerCase()

  mime_type: ->
    mime.lookup(path.basename @name) || 'text/plain'

  content_type: (content_typeCb) ->
    # TODO: We return the charset encoding as well for all types
    tika.type @path, true, content_typeCb

  disposition: ->
    if @isText() or @isImage()
      'inline'
    else if @name is null
      'attachment'
    else
      "attachment; filename=#{encodeURIComponent(path.basename @name).replace(/%20/g, '+')}"

  isBinary: ->
    istextorbinary.isBinarySync @path, @data()

  isText: ->
    istextorbinary.isTextSync @path, @data()

  # isText: ->

  isImage: =>
    -1 isnt _.indexOf ['.png', '.jpg', '.jpeg', '.gif'], @extname()


module.exports = BlobHelper