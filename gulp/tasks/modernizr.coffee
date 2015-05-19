gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Lint Javascript
gulp.task 'modernizr', () ->
    return gulp.src([
            config.path.js + '*.js'
        ])
        .pipe($.plumber())
        .pipe($.modernizr(config.modernizr.filename,
            # Avoid unnecessary builds (see Caching section below)
            "cache": true,

            # Path to the build you're using for development.
            "devFile": false,

            # Path to save out the built file
            "dest": false,

            # Based on default settings on http://modernizr.com/download/
            "options": config.modernizr.options,

            # By default, source is uglified before saving
            "uglify": true,

            # Define any tests you want to explicitly include
            "tests": config.modernizr.tests,

            # Useful for excluding any tests that this tool will match
            # e.g. you use .notification class for notification elements,
            # but don’t want the test for Notification API
            "excludeTests": [],

            # By default, will crawl your project for references to Modernizr tests
            # Set to false to disable
            "crawl": true,

            # Set to true to pass in buffers via the "files" parameter below
            "useBuffers": false,

            # By default, this task will crawl all *.js, *.css, *.scss files.
            "files": {
                "src": [
                    "*[^(g|G)runt(file)?].{js,css,scss}",
                    "**[^node_modules]/**/*.{js,css,scss}",
                    "!lib/**/*"
                ]
            },

            # Have custom Modernizr tests? Add them here.
            "customTests": []
        ))
        .pipe($.uglify({ preserveComments: 'some' }))
        .pipe(gulp.dest(config.path.js + "lib/"))
        .pipe($.size({ title: 'modernizr' }))
