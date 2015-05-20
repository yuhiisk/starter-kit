gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

gulp.task 'stylestats', () ->
    return gulp.src([
        config.path.css + '*.css'
    ])
        .pipe($.stylestats())
