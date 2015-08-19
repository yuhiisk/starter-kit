# Autoprefixer
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

# Device type
typeStr = '%type%'

# Directory
root = './'
src = "#{root}src/#{typeStr}/"
dist = "#{root}dist/#{typeStr}/"
common = "#{root}dist/common/"
src_common = "#{root}src/common/"

config =
    # directory path
    path:
        # document root
        'htdocs' : dist
        # distribution
        'dist'   : dist
        'css'    : dist + 'css/'
        'js'     : dist + 'js/'
        'image'  : dist + 'img/'
        'common' : dist + 'common/'
        # sources
        'src'    : src
        'scss'   : src + 'scss/'
        'coffee' : src + 'coffee/'
        'jade'   : src + 'jade/'
        'sprite' : src + 'sprite/'
        'fonts'  : src + 'fonts/'
        # common
        'src_common':
            'src'    : src_common
            'scss'   : src_common + 'scss/'
            'coffee' : src_common + 'coffee/'
            'jade'   : src_common + 'jade/'
            'sprite' : src_common + 'sprite/'
            'fonts'  : src_common + 'fonts/'

        # 'docs': src + 'docs/'

    # entry point
    entry:
        'css'    : 'style.css'
        'js'     : 'script.js'
        'coffee' : 'script.coffee'

    # after compile name
    name:
        'css' : 'style.css'
        'js'  : 'script.js'

    # sass option
    sass:
        lib: './src/common/scss/extension/function.rb'

    # task configs
    autoprefixer: AUTOPREFIXER_BROWSERS
    modernizr:
        filename: 'modernizr.min.js'
        options: [
            "setClasses",
            "addTest",
            "html5shiv",
            "testProp",
            "fnBind"
        ]
        tests: [
            "csstransitions",
            "opacity",
            "canvas",
            "webgl",
            "es5undefined",
            "es5function",
            "es5syntax",
            "es6math",
        ]

module.exports = config
