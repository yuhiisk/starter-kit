gulp = require 'gulp'
config = require '../config'
$ = (require 'gulp-load-plugins')()

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
