gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

# Scan Your HTML For Assets & Optimize Them
gulp.task 'html', () ->
    assets = $.useref.assets({ searchPath: '{.tmp,' + config.path.htdocs + '}' })

    return gulp.src([
        config.path.htdocs + '**/*.html',
    ])
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
