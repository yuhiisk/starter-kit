/**
 * my gulpfile
 *
 * TODO:
 * * CSScomb lists
 * * sprites
 *
 */
'use strict';

var gulp = require('gulp'),
    $ = require('gulp-load-plugins')(),
    del = require('del'),
    browserSync = require('browser-sync'),
    reload = browserSync.reload,
    bowerFiles = require('main-bower-files'),
    runSequence = require('run-sequence'),
    pagespeed = require('psi'),

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


var root = 'test/src',
    config = {
        'path' : {
            'htdocs': root,
            'scss': root + '/scss',
            'sprite': root + '/sprite',
            'image': root + '/img'
        }
    };

// template task
// gulp.task('myTask', [], function() {
//     console.log('something.');
// });


// Lint Javascript
gulp.task('jshint', function () {
    return gulp.src('test/src/js/**/*.js')
        .pipe($.plumber())
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
        .pipe($.size({ title: 'images' }));
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
gulp.task('copy', function () {
    // src/docsディレクトリのコピー
    gulp.src('test/src/docs/**')
        .pipe(gulp.dest('test/dist/docs'));

    // src/htmlディレクトリのコピー
    gulp.src('test/src/html/**')
        .pipe(gulp.dest('test/dist/html'));
});

// Copy Web Fonts To Dist
gulp.task('fonts', function () {
    gulp.src(['test/src/fonts/**'])
        .pipe(gulp.dest('test/dist/fonts'))
        .pipe($.size({ title: 'fonts' }));
});

// Compile and Automatically Prefix Stylesheets
gulp.task('styles', function () {
    // For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        'test/src/scss/*.scss',
        'test/src/scss/**/*.scss',
        'test/src/scss/components/components.scss'
    ])
        .pipe($.plumber())
        .pipe($.changed('styles', { extension: '.scss' }))
        .pipe($.rubySass({
            style: 'expanded',
            precision: 10
        }))
        // .pipe($.compass({
        //     config_file: './config.rb',
        //     css: 'css',
        //     sass: 'scss'
        // }))
        .on('error', console.error.bind(console))
        .pipe($.autoprefixer({ browsers: AUTOPREFIXER_BROWSERS }))
        .pipe(gulp.dest('.tmp/scss'))
        // Concatenate And Minify Styles
        .pipe($.if('*.css', $.csscomb()))
        // .pipe($.if('*.css', $.csso()))
        .pipe(gulp.dest('test/dist/css'))
        .pipe($.size({ title: 'styles' }));
});

// Scan Your HTML For Assets & Optimize Them
gulp.task('html', function () {
    var assets = $.useref.assets({ searchPath: '{.tmp, test/src}' });

    return gulp.src('test/src/{,**/}*.html')
        .pipe($.plumber())
        .pipe(assets)
        // Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        // Remove Any Unused CSS
        // Note: If not using the Style Guide, you can delete it from
        // the next line to only include styles your project uses.
        .pipe($.if('*.css', $.uncss({
            html: [
                'src/index.html',
                'src/styleguide.html'
            ],
            // CSS Selectors for UnCSS to ignore
            ignore: [
                /.navdrawer-container.open/,
                /.app-bar.open/
            ]
        })))
        // Concatenate And Minify Styles
        // In case you are still using useref build blocks
        .pipe($.if('*.css', $.csso()))
        .pipe(assets.restore())
        .pipe($.useref())
        // Update Production Style Guide Paths
        .pipe($.replace('components/components.css', 'components/main.min.css'))
        // Minify Any HTML
        .pipe($.if('*.html', $.minifyHtml()))
        // Output Files
        .pipe(gulp.dest('test/dist'))
        .pipe($.size({ title: 'html' }));
});

// Clean Output Directory
gulp.task('clean', del.bind(null, ['.tmp', 'dist']));

gulp.task('coffee', function() {
    return gulp.src(['test/src/coffee/*.coffee'])
        .pipe($.plumber())
        .pipe($.coffee({ bare: true }))
        .pipe(gulp.dest('test/src/js'))
        .pipe($.size({ title: 'coffee' }))
});

gulp.task('typescript', function() {
    return gulp.src(['test/src/ts/*.ts'])
        .pipe($.plumber())
        .pipe($.tsc({
            sourcemap: true,
            sourceRoot: '../ts'
        }))
        .pipe(gulp.dest('test/src/js'))
        .pipe($.size({ title: 'typescript' }))
});

gulp.task('sprite', function() {
    var spriteData = gulp.src('test/src/img/sprite/*.png')
        .pipe($.plumber())
        .pipe($.spritesmith({
            imgName: 'sprite.png',
            cssName: 'sprite.scss',
            padding: 5
        }));
    spriteData.img.pipe(gulp.dest('test/dist/img'));
    spriteData.css.pipe(gulp.dest('test/dist/scss'));

});


// var root = 'test/src',
//     config = {
//         'path' : {
//             'htdocs': root,
//             'scss': root + '/scss',
//             'sprite': root + '/sprite',
//             'image': root + '/img'
//         }
//     };
//
// gulp.task('watch', function() {
//     gulp.watch(config.path.sprite + '/**/*.png', function(arg) {
//         var filePath = arg.path.match(/^(.+\/)(.+?)(\/.+?\..+?)$/);
//         var spriteData = gulp.src(filePath[1] + filePath[2] + '/*.png')
//             .pipe($.plumber())
//             .pipe(plumber)
//             .pipe($.spritesmith({
//                 imgName: filePath[2] + '.png',
//                 cssName: filePath[2] + '.scss'
//             }));
//         spriteData.img.pipe(gulp.dest(config.path.image));
//         spriteData.css.pipe(gulp.dest(config.path.sass));
//     })
// });

gulp.task('bower', function() {
    var jsFilter = $.filter('**/*.js'),
        cssFilter = $.filter('**/*.css');

    return gulp.src(bowerFiles())
        .pipe(jsFilter)
        .pipe($.uglify({ preserveComments: 'some' }))
        .pipe($.concat('lib.min.js'))
        .pipe(gulp.dest('test/src/js'))
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe(gulp.dest('test/src/css'));
});


// Watch Files For Changes & Reload
gulp.task('serve', ['styles'], function () {
    browserSync({
        notify: false,
        // Customize the BrowserSync console logging prefix
        logPrefix: 'WSK',
        // Run as an https by uncommenting 'https: true'
        // Note: this uses an unsigned certificate which on first access
        //       will present a certificate warning in the browser.
        // https: true,
        server: ['test/.tmp', 'test/src']
    });

    gulp.watch(['test/src/**/*.html'], reload);
    gulp.watch(['test/src/scss/**/*.{scss, css}'], ['styles', reload]);
    gulp.watch(['test/src/ts/{**/,}*.ts'], ['typescript']);
    // gulp.watch(['test/src/coffee/{**/,}*.coffee'], ['coffee']);
    gulp.watch(['test/src/js/*.js'], ['jshint']);
    gulp.watch(['test/src/img/**/*'], reload);
});

// Build and serve the output from the dist build
gulp.task('serve:dist', ['default'], function () {
    browserSync({
        notify: false,
        logPrefix: 'WSK',
        // Run as an https by uncommenting 'https: true'
        // Note: this uses an unsigned certificate which on first access
        //       will present a certificate warning in the browser.
        // https: true,
        server: 'test/dist'
    });
});

// Build Production Files, the Default Task
gulp.task('default', ['clean'], function (cb) {
    runSequence('styles', ['jshint', 'html', 'images', 'fonts', 'copy'], cb);
});

// Run PageSpeed Insights
// Update `url` below to the public URL for your site
gulp.task('pagespeed', pagespeed.bind(null, {
    // By default, we use the PageSpeed Insights
    // free (no API key) tier. You can use a Google
    // Developer API key if you have one. See
    // http://goo.gl/RkN0vE for info key: 'YOUR_API_KEY'
    url: 'https://example.com',
    strategy: 'mobile'
}));

// Load custom tasks from the `tasks` directory
// try { require('require-dir')('tasks'); } catch (err) { console.error(err); }



gulp.task('deploy', [], function() { });
