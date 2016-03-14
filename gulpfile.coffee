'use strict'

config = require './gulp/config'
util = require './gulp/util'

gulp = require 'gulp'

# Load custom tasks from the `tasks` directory
try
    (require 'require-dir')('./gulp/tasks', { recurse: true })
catch err
    console.error err

$ = (require 'gulp-load-plugins')()
runSequence = require 'run-sequence'
browserSync = require 'browser-sync'
reload = browserSync.reload

# Compile source
gulp.task 'build', ['styles', 'coffeelint', 'coffee']

# Watch Files For Changes & Reload
gulp.task 'serve', () ->
    browserSync.init(
        notify: false,
        # Customize the BrowserSync console logging prefix
        logPrefix: 'Starter Kit',
        # Run as an https by uncommenting 'https: true'
        # Note: this uses an unsigned certificate which on first access
        #       will present a certificate warning in the browser.
        # https: true,
        # host: '192.168.1.1',
        # port: 3000,
        server:
            baseDir: [ config.path.htdocs ]
            index: 'index.html'
            # routes:
    )

    # default
    $.watch([config.path.htdocs + '**/*.html'], reload)
    $.watch([config.path.jade + '**/*.jade'], -> runSequence('jade', reload))
    $.watch([
        config.path.scss + '**/*.scss'
    ], -> runSequence('styles', reload))
    # $.watch([config.path.js + '**/*.js'], reload)
    $.watch([config.path.coffee + '**/*.coffee'], -> runSequence('coffeelint', 'coffee', reload))

# Build Production Files, the Default Task
gulp.task 'default', (cb) ->
    runSequence('build', 'serve', cb)

gulp.task 'deploy', (cb) ->
    runSequence('build', 'coffeelint', cb)

# gulp.task 'minify', (cb) ->
#     runSequence('minify:html', 'minify:styles', 'minify:scripts', cb)
