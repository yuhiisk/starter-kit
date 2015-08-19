gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Copy Web Fonts To Dist
gulp.task 'fonts', () ->
    gulp.src([
        config.path.fonts + '**'
    ])
        .pipe(gulp.dest(config.path.fonts))
        .pipe($.size({ title: 'fonts' }))
