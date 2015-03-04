gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Copy All Files At The Root Level (app)
gulp.task 'copy', () ->
    return gulp.src([
        config.path.htdocs + '**',
        '!' + config.path.htdocs + '**/*.html',
        '!' + config.path.css,
        '!' + config.path.css + '**',
        '!' + config.path.js,
        '!' + config.path.js + '**',
        '!' + config.path.scss,
        '!' + config.path.scss + '**',
        '!' + config.path.coffee,
        '!' + config.path.coffee + '**',
        # '!' + config.path.ts,
        # '!' + config.path.ts + '**',
    ], {
        dot: true
    }).pipe(gulp.dest(config.path.dist))
        .pipe($.size({title: 'copy'}))
