'use strict'

config = require './gulp/config'
gulp = require 'gulp'
# Load custom tasks from the `tasks` directory
try
    (require 'require-dir')('./gulp/tasks', { recurse: true })
catch err
    console.error err

runSequence = require 'run-sequence'
browserSync = require 'browser-sync'
reload = browserSync.reload


# Watch Files For Changes & Reload
gulp.task 'serve', ['styles'], () ->
    browserSync(
        notify: false,
        # Customize the BrowserSync console logging prefix
        logPrefix: 'WSK',
        # Run as an https by uncommenting 'https: true'
        # Note: this uses an unsigned certificate which on first access
        #       will present a certificate warning in the browser.
        # https: true,
        # host: '172.21.33.241',
        server: [config.path.htdocs]
    )

    gulp.watch([config.path.htdocs + '**/*.html'], reload)
    gulp.watch([config.path.scss + '**/*.scss'], ['styles', reload])
    gulp.watch([config.path.coffee + '**/*.coffee'], ['browserify', reload])


# Build Production Files, the Default Task
gulp.task 'default', (cb) ->
    runSequence(
        'styles',
        'browserify',
        'serve',
        cb
    )

gulp.task 'deploy', (cb) ->
    runSequence(
        'styles',
        'browserify',
        'clean',
        'copy',
        'jshint'
        cb
    )

# gulp.task 'minify', (cb) ->
#     runSequence(
#         'minify:html',
#         'minify:styles',
#         'minify:scripts',
#         cb
#     )
