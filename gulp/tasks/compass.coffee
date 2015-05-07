gulp = require 'gulp'
config = require '../config'
sass = require('gulp-ruby-sass')
$ = (require 'gulp-load-plugins')()

# Compile and Automatically Prefix Stylesheets
gulp.task 'compass', () ->
    # For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        config.path.scss + '*.scss'
    ])
        .pipe($.plumber())
        .pipe($.changed('styles', { extension: '.scss' }))
        .pipe($.compass(
            config_file: './config.rb',
            css: config.path.css,
            sass: config.path.scss
        ))
        .on('error', console.error.bind(console))
        .pipe($.autoprefixer({ browsers: config.autoprefixer }))
        # .pipe(gulp.dest('.tmp/scss'))
        .pipe(gulp.dest(config.path.css))
        .pipe($.size({ title: 'styles' }))
