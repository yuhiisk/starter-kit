gulp = require 'gulp'
config = require '../config'
sass = require('gulp-ruby-sass')
$ = (require 'gulp-load-plugins')()

# Compile and Automatically Prefix Stylesheets
gulp.task 'styles', () ->
    # For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        config.path.scss + '*.scss'
    ])
        .pipe($.plumber())
        .pipe($.changed('styles', { extension: '.scss' }))
        .pipe(sass({
            style: 'expanded',
            precision: 10,
            sourcemap: false
        }))
        # Use compass
        # .pipe($.compass({
        #     css: config.path.css
        #     sass: config.path.scss
        #     image: config.path.image
        # }))
        .on('error', (e) ->
            console.error(e)
            @emit("end")
        )
        .pipe($.autoprefixer({ browsers: config.autoprefixer }))
        # .pipe(gulp.dest('.tmp/scss'))
        .pipe(gulp.dest(config.path.css))
        .pipe($.size({ title: 'styles' }))
