gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Copy All Files At The Root Level (dist)
gulp.task 'copy', (dir) ->
    gulp.src([ config.path.dist ])
        .pipe(gulp.dest(dir))
        .pipe($.size({ title: 'copy' }))

gulp.task 'copy:common_html', () ->
    gulp.src([ config.path.src_common.src ])
        .pipe(gulp.dest(config.path.dist))

    gulp.src([ "#{config.path.src_common.src}**/*.html" ])
        .pipe(gulp.dest(config.path.common))
        .pipe($.size({ title: 'copy:common_html' }))

# gulp.task 'copy:docs', () ->
#     gulp.src([])
#         .pipe(gulp.dest())
