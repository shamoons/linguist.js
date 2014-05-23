fs = require 'fs'

BlobHelper = require './blob_helper'

class FileBlob extends BlobHelper
  constructor: (path, base_path = null) ->
    # super
    @path = path
    @name = if base_path? then path.replace("#{base_path}/", '') else path
    
  data: ->
    fs.readFileSync @path




module.exports = FileBlob