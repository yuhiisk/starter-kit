/**
 * my gulpfile
 */
'use strict';

var gulp = require('gulp'),
    $ = require('gulp-load-plugins')(),
    browserSync = require('browser-sync'),
    reload = browserSync.reload,

    AUTOPREFIXER_BROWSERS = [
        'ie >= 10',
        'ie_mob >= 10',
        'ff >= 30',
        'chrome >= 34',
        'safari >= 7',
        'opera >= 23',
        'ios >= 7',
        'android >= 4.4',
        'bb >= 10'
    ];

// template task
// gulp.task('myTask', [], function() {
//     console.log('something.');
// });


// Lint Javascript
gulp.task('jshint', function () {
    return gulp.src('test/src/js/**/*.js')
        .pipe(reload({ stream: true, once: true }))
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'))
        .pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
});

// Optimize Images
gulp.task('images', function () {
    return gulp.src('test/src/images/**/*')
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest('test/dist/images'))
        .pipe($.size({title: 'images'}));
});

// Copy All Files At The Root Level (app)
// gulp.task('copy', function () {
//     return gulp.src([
//         'app/*',
//         '!app/*.html',
//         'node_modules/apache-server-configs/dist/.htaccess'
//     ], {
//         dot: true
//     }).pipe(gulp.dest('dist'))
//         .pipe($.size({title: 'copy'}));
// });

// Copy basic
gulp.task('copy', function() {
    // src/docsディレクトリのコピー
    gulp.src('test/src/docs/**').
        pipe(gulp.dest('test/dist/docs'));

    // src/htmlディレクトリのコピー
    gulp.src('test/src/html/**').
        pipe(gulp.dest('test/dist/html'));
});

// Copy Web Fonts To Dist
gulp.task('fonts', function () {
    return gulp.src(['test/src/fonts/**'])
        .pipe(gulp.dest('test/dist/fonts'))
        .pipe($.size({title: 'fonts'}));
});

// --------------------------------------------------------
// TODO: continue
// --------------------------------------------------------


gulp.task('browser-sync', function() {
    browserSync({
        server: {
            baseDir: "test/src/html/"
        }
    });
});

gulp.task('bs-reload', function() {
    reload();
})



// commands
gulp.task('default', ['browser-sync'], function() {
    gulp.watch('test/src/html/*.html', ['bs-reload']);
});
gulp.task('deploy', [], function() { });
