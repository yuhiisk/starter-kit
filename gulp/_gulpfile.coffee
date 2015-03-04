###
 # my gulpfile
 #
 #  TODO:
 #  * deploy task (concat)
 #  * sprites
 #  * error handling
 #  * delete sourcemap option
 #  * document
###

'use strict'

gulp = require('gulp')
$ = require('gulp-load-plugins')()
sass = require('gulp-ruby-sass')
del = require('del')
browserify = require('browserify')
source = require('vinyl-source-stream')
bowerFiles = require('main-bower-files')
runSequence = require('run-sequence')

browserSync = require('browser-sync')
reload = browserSync.reload

AUTOPREFIXER_BROWSERS = [
    'ie >= 8',
    'ie_mob >= 10',
    'ff >= 30',
    'chrome >= 34',
    'safari >= 7',
    'opera >= 23',
    'ios >= 7',
    'android >= 4.4',
    'bb >= 10'
]

root = './'
config =
    path:
        'htdocs': root,
        'dist': './dist/',
        'css': root + 'css/',
        'scss': root + 'scss/',
        'js': root + 'js/',
        'coffee': root + 'coffee/',
        'ts': root + 'ts/',
        'jade': root + 'jade/',
        'image': root + 'img/',
        'sprite': root + 'img/sprite/',
        'fonts': root + 'fonts/',

        'docs': root + 'docs/'

file =
    name:
        'css': 'style.css',
        'js': 'lib.min.js'
    lib: [
        'js/lib/underscore-min.js',
        'js/lib/jquery.mockjax.js',
        'js/lib/backbone.js',
        'js/lib/boombox.min.js',
        'js/lib/easeljs-0.8.0.js',
        'js/lib/tweenjs-0.6.0.js',
        'js/lib/preloadjs-0.6.0.js'
    ],
    classes: [
        'js/EventDispatcher.js',
        'js/namespace.js',
        'js/util.js',
        'js/config.js',
        'js/bitmap.js',
        'js/item.js',
        'js/people.js',
        'js/scene.js',
        'js/model.js',
        'js/view.js',

        'js/scene_opening.js',
        'js/scene1.js',
        'js/scene2.js',
        'js/scene3.js',
        'js/scene4.js',
        'js/scene5.js',
        'js/scene6.js',
        'js/scene_ending.js'
        # , 'js/app.js'
    ]


# Lint Javascript
gulp.task 'jshint', () ->
    return gulp.src([
            config.path.js + '**/*.js',
            '!' + config.path.js + 'lib/*.js',
        ])
        .pipe($.plumber())
        # .pipe(reload({ stream: true, once: true }))
        .pipe($.jshint())
        .pipe($.jshint.reporter('jshint-stylish'))
        # browserSyncが立ち上がっていないとerror logを吐く
        # なくてもいいかも
        #.pipe($.if(!browserSync.active, $.jshint.reporter('fail')))


# Optimize Images
gulp.task 'images', () ->
    return gulp.src(config.path.image + '**/*')
        .pipe($.cache($.imagemin({
            progressive: true,
            interlaced: true
        })))
        .pipe(gulp.dest(config.path.dist + 'img'))
        .pipe($.size({ title: 'images' }))


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


# Copy Web Fonts To Dist
gulp.task 'fonts', () ->
    gulp.src([config.path.fonts + '**'])
        .pipe(gulp.dest(config.path.fonts))
        .pipe($.size({ title: 'fonts' }))


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
            precision: 10
        }))
        # Use compass
        # .pipe($.compass({
        #     config_file: './config.rb',
        #     css: 'css',
        #     sass: 'scss'
        # }))
        .on('error', console.error.bind(console))
        .pipe($.autoprefixer({ browsers: AUTOPREFIXER_BROWSERS }))
        # .pipe(gulp.dest('.tmp/scss'))
        .pipe(gulp.dest(config.path.css))
        .pipe($.size({ title: 'styles' }))


# Scan Your HTML For Assets & Optimize Them
gulp.task 'html', () ->
    assets = $.useref.assets({ searchPath: '{.tmp,' + config.path.htdocs + '}' })

    return gulp.src(config.path.htdocs + '**/*.html')
        .pipe($.plumber())
        .pipe(assets)
        # Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        # Remove Any Unused CSS
        # Note: If not using the Style Guide, you can delete it from
        # the next line to only include styles your project uses.
        # .pipe($.if('*.css', $.uncss({
        #     html: [
        #         config.path.htdocs + 'index.html',
        #         # config.path.htdocs + 'styleguide.html'
        #     ],
        #     # CSS Selectors for UnCSS to ignore
        #     # ignore: [
        #     #     /.navdrawer-container.open/,
        #     #     /.app-bar.open/
        #     # ]
        # })))
        # Concatenate And Minify Styles
        # In case you are still using useref build blocks
        .pipe($.if('*.css', $.csscomb()))
        .pipe($.if('*.css', $.csso()))
        .pipe(assets.restore())
        .pipe($.useref())
        # Minify Any HTML
        # .pipe($.if('*.html', $.minifyHtml()))
        # Output Files
        .pipe(gulp.dest(config.path.dist))
        .pipe($.size({ title: 'html' }))


gulp.task 'minify:html', () ->
    assets = $.useref.assets({ searchPath: '{.tmp, ' + config.path.htdocs + '}' })

    return gulp.src(config.path.htdocs + '*.html')
        .pipe($.plumber())
        # Minify Any HTML
        .pipe($.if('*.html', $.minifyHtml()))
        # Output Files
        .pipe(gulp.dest(config.path.dist))
        .pipe($.size({ title: 'minify:html' }))


gulp.task 'minify:styles', () ->
    # For best performance, don't add Sass partials to `gulp.src`
    return gulp.src([
        config.path.css + '*.css'
    ])
        .pipe($.plumber())
        # Concatenate And Minify Styles
        .pipe($.if('*.css', $.csscomb()))
        .pipe($.if('*.css', $.csso()))
        # .pipe($.concat(file.name.css))
        .pipe(gulp.dest(config.path.dist + 'css'))
        .pipe($.size({ title: 'minify:styles' }))


gulp.task 'minify:lib', () ->
    return gulp.src(file.lib)
        .pipe($.plumber())
        .pipe($.concat('lib.min.js'))
        # Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        # Output Files
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'minify:lib' }))


gulp.task 'minify:classes', () ->
    return gulp.src(file.classes)
        .pipe($.plumber())
        .pipe($.concat('kazoku.min.js'))
        # Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        # Output Files
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'minify:classes' }))


gulp.task 'minify:all', () ->
    return gulp.src(
        file.lib,
        file.classes,
        [ 'js/app.js' ]
    )
        .pipe($.plumber())
        .pipe($.concat('all.min.js'))
        # Concatenate And Minify JavaScript
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        # Output Files
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'minify:all' }))


# Clean Output Directory
gulp.task 'clean', del.bind(null, [ '.tmp', config.path.dist + '*' ], { dot: true })
# gulp.task('clean', del.bind(null, ['.tmp', 'dist/*', '!dist/.git'], {dot: true}))


gulp.task 'jade', () ->
    return gulp.src([
        config.path.jade + '**/!(_)*.jade'#, '!' + config.path.jade + '**/_*.jade'
    ])
        .pipe($.plumber())
        .pipe($.data((file) ->
            return require(config.path.jade + 'config.json')
        ))
        .pipe($.jade({
            pretty: true
            basedir: config.path.jade
        }))
        .pipe(gulp.dest(config.path.htdocs))
        .pipe($.size({ title: 'jade' }))


gulp.task 'coffee', () ->
    return gulp.src([config.path.coffee + '*.coffee'])
        .pipe($.plumber())
        .pipe($.coffee({ bare: true }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'coffee' }))


gulp.task 'typescript', () ->
    return gulp.src([config.path.ts + '*.ts'])
        .pipe($.plumber())
        .pipe($.tsc({
            sourcemap: true,
            sourceRoot: '../ts'
        }))
        .pipe(gulp.dest(config.path.js))
        .pipe($.size({ title: 'typescript' }))


gulp.task 'browserify', () ->
    return browserify({
        entries: ['./' + config.path.coffee + 'app.coffee'],
        extensions: ['.coffee']
    })
    # .transform('coffeeify')
    .bundle()
    .pipe(source('app.concat.js'))
    .pipe(gulp.dest(config.path.js))


gulp.task 'watch', () ->
    gulp.watch(config.path.sprite + '/**/*.png', (arg) ->
        filePath = arg.path.match(/^(.+\/)(.+?)(\/.+?\..+?)$/)
        spriteData = gulp.src(filePath[1] + filePath[2] + '/*.png')
            .pipe($.plumber())
            .pipe($.spritesmith({
                imgName: filePath[2] + '.png',
                cssName: filePath[2] + '.scss'
            }))
        spriteData.img.pipe(gulp.dest(config.path.image))
        spriteData.css.pipe(gulp.dest(config.path.scss))
    )


gulp.task 'bower', () ->
    jsFilter = $.filter('**/*.js')
    cssFilter = $.filter('**/*.css')

    return gulp.src(bowerFiles())
        .pipe(jsFilter)
        .pipe($.uglify({ preserveComments: 'some' }))
        .pipe($.concat(file.name.js))
        .pipe(gulp.dest(config.path.js))
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe(gulp.dest(config.path.css))


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
    gulp.watch([config.path.scss + '**/*.{scss, css}'], ['styles', reload])
    gulp.watch([config.path.jade + '**/*.jade'], ['jade'])
    gulp.watch([config.path.ts + '**/*.ts'], ['typescript'])
    gulp.watch([config.path.coffee + '**/*.coffee'], ['browserify' , reload])


# Build and serve the output from the dist build
gulp.task 'serve:dist', ['deploy'], () ->
    browserSync(
        notify: false,
        logPrefix: 'WSK',
        # Run as an https by uncommenting 'https: true'
        # Note: this uses an unsigned certificate which on first access
        #       will present a certificate warning in the browser.
        # https: true,
        server: config.path.dist
    )


# Build Production Files, the Default Task
gulp.task 'default', (cb) ->
    runSequence(
        'styles',
        'jade',
        'browserify',
        ['jshint'],
        'serve',
        cb
    )


gulp.task 'deploy', [], (cb) ->
    runSequence(
      ['styles', 'browserify'],
      ['jshint', 'images', 'html', 'fonts', 'copy'],
      cb
    )


gulp.task 'setup', ['bower'], (cb) ->
    # runSequence('styles', ['jshint', 'images', 'fonts', 'copy'], cb)



# Load custom tasks from the `tasks` directory
# try { require('require-dir')('tasks') } catch (err) { console.error(err) }
