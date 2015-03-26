root = './'
dev = './src/'
dist = './dist/'

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
        'htdocs': dev,
        'dist': dist,
        'css': dev + 'css/',
        'scss': dev + 'scss/'
        'js': dev + 'js/',
        'coffee': dev + 'coffee/',
        'image': dev + 'img/',
        'sprite': dev + 'img/sprite/',
        'fonts': dev + 'fonts/',

        'docs': dev + 'docs/'

    autoprefixer: AUTOPREFIXER_BROWSERS

    # entry point
    entry:
        'css': 'style.css',
        'js': 'script.js'
        'coffee': 'script.coffee'

    # after compile name
    name:
        'css': 'style.css'
        'js': 'script.js'

