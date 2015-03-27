gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Copy All Files At The Root Level (app)
gulp.task 'copy', () ->
    gulp.src([
        "#{config.path.htdocs}**/*.html",
        "#{config.path.assets}"
    ])
        .pipe(gulp.dest(config.path.dist))
        .pipe($.size({title: 'copy:html'}))

    gulp.src([
        "#{config.path.assets}**/*"
    ])
        .pipe(gulp.dest("#{config.path.dist}assets/"))
        .pipe($.size({title: 'copy:assets'}))
