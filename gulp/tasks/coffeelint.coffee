gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Lint Javascript
gulp.task 'coffeelint', () ->
    return gulp.src([
            config.path.coffee + '**/*.coffee'
        ])
        .pipe($.plumber())
        .pipe($.coffeelint())
        .pipe($.coffeelint.reporter('coffeelint-stylish'))