gulp = require 'gulp'
config = require '../config'
del = require 'del'

# Clean Output Directory
gulp.task 'clean', del.bind(null, [ '.tmp', config.path.dist + '*' ], { dot: true })
