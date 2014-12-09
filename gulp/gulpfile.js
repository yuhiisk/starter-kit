/**
 * my gulpfile
 *
 * TODO:
 * * minify(html, useref)
 * * deploy task (ignore sourcemap)
 * * sprites
 * * error handling
 * * delete sourcemap option
 * * document
 *
 */
'use strict';

var gulp = require('gulp'),
    sass = require('gulp-ruby-sass'),
    $ = require('gulp-load-plugins')(),
    del = require('del'),
    bowerFiles = require('main-bower-files'),
    runSequence = require('run-sequence'),

    browserSync = require('browser-sync'),
    reload = browserSync.reload,

    pagespeed = require('psi'),
    PAGESPEED_TARGET_URL = 'http://example.com/',

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
    ],

    root = 'test/src/',
    config = {
        'path' : {
            'htdocs': root,
            'dist': 'test/dist/',
            'css': root + 'css/',
            'scss': root + 'scss/',
            'js': root + 'js/',
            'coffee': root + 'coffee/',
            'ts': root + 'ts/',
            'image': root + 'img/',
            'sprite': root + 'sprite/',
            'fonts': root + 'fonts/',

            'docs': root + 'docs/'
        }
    };


// Lint Javascript
gulp.task('jshint', function () {
    return gulp.src(config.path.js + '**/*.js')
        .pipe($.plumber())
        .pipe(reload({ stream: true, once: true }))
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'));
        // browserSyncが立ち上がっていないとerror logを吐く
        // なくてもいいかも
        //.pipe($.if(!browserSync.active, $.jshint.reporter('fail')));
});

// Optimize Images
gulp.task('images', function () {
    return gulp.src(config.path.image + '**/*')
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest(config.path.dist + 'img'))
        .pipe($.size({ title: 'images' }));
});

// Copy All Files At The Root Level (app)
gulp.task('copy', function () {
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
        '!' + config.path.ts,
        '!' + config.path.ts + '**',
        // '!test/src/{scss,scss/**}',
        // '!test/src/{coffee,coffee/**}',
        // '!test/src/{ts,ts/**}',
    ], {
        dot: true
    }).pipe(gulp.dest(config.path.dist))
        .pipe($.size({title: 'copy'}));
});

// Copy basic
// gulp.task('copy', function () {
   // // src/docsディレクトリのコピー
   // gulp.src(config.path.docs + '**')
   //     .pipe(gulp.dest(config.path.dist + 'docs'));

   // // src/htmlディレクトリのコピー
   // gulp.src(config.path.htdocs + 'html/**')
   //     .pipe(gulp.dest(config.path.dist + 'html'));
// });

// Copy Web Fonts To Dist
gulp.task('fonts', function () {
    gulp.src([config.path.fonts + '**'])
        .pipe(gulp.dest(config.path.fonts))
        .pipe($.size({ title: 'fonts' }));
});

// Compile and Automatically Prefix Stylesheets
gulp.task('styles', function () {
    // For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        config.path.scss + '*.scss'
    ])
        .pipe($.plumber())
        .pipe($.changed('styles', { extension: '.scss' }))
        .pipe($.rubySass({
            style: 'expanded',
            precision: 10
        }))
        // Use compass
        // .pipe($.compass({
        //     config_file: './config.rb',
        //     css: 'css',
        //     sass: 'scss'
        // }))
        .on('error', console.error.bind(console))
        .pipe($.autoprefixer({ browsers: AUTOPREFIXER_BROWSERS }))
        // .pipe(gulp.dest('.tmp/scss'))
        .pipe(gulp.dest(config.path.css))
        .pipe($.size({ title: 'styles' }));
});

// Scan Your HTML For Assets & Optimize Them
gulp.task('html', function () {
    var assets = $.useref.assets({ searchPath: '{.tmp,' + config.path.htdocs + '}' });

    return gulp.src(config.path.htdocs + '**/*.html')
        .pipe($.plumber())
        .pipe(assets)
        // Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        // Remove Any Unused CSS
        // Note: If not using the Style Guide, you can delete it from
        // the next line to only include styles your project uses.
        // .pipe($.if('*.css', $.uncss({
        //     html: [
        //         config.path.htdocs + 'index.html',
        //         // config.path.htdocs + 'styleguide.html'
        //     ],
        //     // CSS Selectors for UnCSS to ignore
        //     // ignore: [
        //     //     /.navdrawer-container.open/,
        //     //     /.app-bar.open/
        //     // ]
        // })))
        // Concatenate And Minify Styles
        // In case you are still using useref build blocks
        .pipe($.if('*.css', $.csscomb()))
        .pipe($.if('*.css', $.csso()))
        .pipe(assets.restore())
        .pipe($.useref())
        // Update Production Style Guide Paths
        // .pipe($.replace('components/components.css', 'components/main.min.css'))
        // Minify Any HTML
        // .pipe($.if('*.html', $.minifyHtml()))
        // Output Files
        .pipe(gulp.dest(config.path.dist))
        .pipe($.size({ title: 'html' }));
});

gulp.task('minify:html', function() {
    var assets = $.useref.assets({ searchPath: '{.tmp, ' + config.path.htdocs + '}' });

    return gulp.src(config.path.htdocs + '*.html')
        .pipe($.plumber())
        // Minify Any HTML
        .pipe($.if('*.html', $.minifyHtml()))
        // Output Files
        .pipe(gulp.dest(config.path.dist))
        .pipe($.size({ title: 'minify:html' }));
});

gulp.task('minify:styles', function () {
    // For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        config.path.css + '*.css'
    ])
        .pipe($.plumber())
        // Concatenate And Minify Styles
        .pipe($.if('*.css', $.csscomb()))
        .pipe($.if('*.css', $.csso()))
        .pipe(gulp.dest(config.path.dist + 'css'))
        .pipe($.size({ title: 'minify:styles' }));
});

gulp.task('minify:scripts', function () {
    return gulp.src(config.path.js + '**/*.js')
        .pipe($.plumber())
        // Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        // Output Files
        .pipe(gulp.dest(config.path.dist + 'js'))
        .pipe($.size({ title: 'minify:js' }));
});

// Clean Output Directory
gulp.task('clean', del.bind(null, [ '.tmp', config.path.dist + '*' ], { dot: true }));
// gulp.task('clean', del.bind(null, ['.tmp', 'dist/*', '!dist/.git'], {dot: true}));

gulp.task('coffee', function() {
    return gulp.src([config.path.coffee + '*.coffee'])
        .pipe($.plumber())
        .pipe($.coffee({ bare: true }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'coffee' }))
});

gulp.task('typescript', function() {
    return gulp.src([config.path.ts + '*.ts'])
        .pipe($.plumber())
        .pipe($.tsc({
            sourcemap: true,
            sourceRoot: '../ts'
        }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'typescript' }))
});

gulp.task('sprite', function() {
    var spriteData = gulp.src(config.path.sprite + '*.png')
        .pipe($.plumber())
        .pipe($.spritesmith({
            imgName: 'sprite.png',
            cssName: 'sprite.scss',
            padding: 5
        }));
    spriteData.img.pipe(gulp.dest(config.path.dist + 'img'));
    spriteData.css.pipe(gulp.dest(config.path.dist + 'scss'));

});

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
        .pipe(gulp.dest(config.path.js))
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe(gulp.dest(config.path.css));
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
        server: [ 'test/.tmp', config.path.htdocs ]
    });

    gulp.watch([config.path.htdocs + '**/*.html'], reload);
    gulp.watch([config.path.scss + '**/*.{scss, css}'], ['styles', reload]);
    gulp.watch([config.path.ts + '**/*.ts'], ['typescript']);
    gulp.watch([config.path.coffee + '**/*.coffee'], ['coffee']);
    gulp.watch([config.path.js + '*.js'], ['jshint']);
    gulp.watch([config.path.image + '**/*'], reload);
});

// Build and serve the output from the dist build
gulp.task('serve:dist', ['deploy'], function () {
    browserSync({
        notify: false,
        logPrefix: 'WSK',
        // Run as an https by uncommenting 'https: true'
        // Note: this uses an unsigned certificate which on first access
        //       will present a certificate warning in the browser.
        // https: true,
        server: config.path.dist
    });
});

// Build Production Files, the Default Task
gulp.task('default', ['clean'], function (cb) {
    runSequence('styles', ['jshint', 'images', 'fonts', 'copy'], cb);
});

gulp.task('deploy', ['clean'], function(cb) {
    runSequence(
      ['styles', 'coffee', 'typescript'],
      ['jshint', 'images', 'html', 'fonts', 'copy'],
      cb
    );
});

gulp.task('setup', [], function (cb) {
    // runSequence('styles', ['jshint', 'images', 'fonts', 'copy'], cb);
});

// Run PageSpeed Insights
// Update `url` below to the public URL for your site
gulp.task('pagespeed', pagespeed.bind(null, {
    // By default, we use the PageSpeed Insights
    // free (no API key) tier. You can use a Google
    // Developer API key if you have one. See
    // http://goo.gl/RkN0vE for info key: 'YOUR_API_KEY'
    url: PAGESPEED_TARGET_URL,
    strategy: 'mobile'
}));

// Load custom tasks from the `tasks` directory
// try { require('require-dir')('tasks'); } catch (err) { console.error(err); }


// task template
// gulp.task('myTask', [], function() {
//     console.log('something.');
// });
