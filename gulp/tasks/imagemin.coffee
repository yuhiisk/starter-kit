gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Optimize Images
gulp.task 'imagemin', () ->
    return gulp.src([
        config.path.image + '**/*'
    ])
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest(config.path.dist + 'img'))
        .pipe($.size({ title: 'imagemin' }))
