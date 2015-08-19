gulp = require 'gulp'
config = require '../config'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

gulp.task 'browserify', () ->
    return browserify({
        entries: [config.path.coffee + config.entry.coffee],
        extensions: ['.coffee']
    })
    .bundle()
    .pipe(source(config.name.js))
    .pipe(gulp.dest(config.path.js))
