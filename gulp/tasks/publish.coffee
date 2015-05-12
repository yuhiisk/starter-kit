gulp = require 'gulp'
awspublish = require 'gulp-awspublish'
config = require '../config'

# upload dist to s3 bucket
gulp.task 'publish', () ->
    credentials = require '../aws-credentials.json'
    publisher = awspublish.create(credentials)

    srcPattern = [
        config.path.dist + '/*.html',
        config.path.dist + '/**/?(css|js|img)/**.*'
    ]

    gulp.src(srcPattern)
        .pipe(publisher.publish())
        .pipe(publisher.sync())
        .pipe(awspublish.reporter({
            states: ['create', 'update', 'delete']
        }))
