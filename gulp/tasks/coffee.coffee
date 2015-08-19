gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

gulp.task 'coffee', () ->
    return gulp.src([
        config.path.coffee + '*.coffee'
    ])
        .pipe($.plumber())
        .pipe($.coffee({ bare: true }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'coffee' }))
