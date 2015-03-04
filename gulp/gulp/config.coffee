root = './'
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

module.exports =
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
    autoprefixer: AUTOPREFIXER_BROWSERS

    file:
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
        ]
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

