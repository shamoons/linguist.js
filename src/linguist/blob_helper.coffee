_ = require 'lodash'
istextorbinary = require 'istextorbinary'
mime = require 'mime-types'
path = require 'path'
tika = require 'tika'

class BlobHelper
  MEGABYTE = 1024 * 1024

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

  isImage: =>
    -1 isnt _.indexOf ['.png', '.jpg', '.jpeg', '.gif'], @extname()

  isLarge: ->
    @size() > MEGABYTE

  isViewable: ->
    not @isLarge() and @isText()

  lines: ->
    if @isViewable() and @data()
      @data().split(/\r\n|\r|\n/)
    else
      []



module.exports = BlobHelper