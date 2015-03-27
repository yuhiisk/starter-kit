root = './'
dev = './src/'
assets = dev + 'assets/'
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
        'assets': assets,
        'dist': dist,
        'css': assets + 'css/',
        'scss': dev + 'scss/'
        'js': assets + 'js/',
        'coffee': dev + 'coffee/',
        'image': assets + 'img/',
        'sprite': assets + 'img/sprite/',
        'fonts': assets + 'fonts/',

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

