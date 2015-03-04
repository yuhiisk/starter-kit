gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

gulp.task 'typescript', () ->
    return gulp.src([config.path.ts + '*.ts'])
        .pipe($.plumber())
        .pipe($.tsc({
            sourcemap: true,
            sourceRoot: '../ts'
        }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'typescript' }))
