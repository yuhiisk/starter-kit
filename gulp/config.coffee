root = './'
src = "#{root}src/"
dist = "#{root}dist/" # distribution

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

    # directory path
    path:
        'htdocs': dist,

        'dist': dist,
        'css': dist + 'css/',
        'js': dist + 'js/',
        'image': dist + 'img/',

        'scss': src + 'scss/'
        'coffee': src + 'coffee/',
        'jade': src + 'jade/',
        'sprite': src + 'sprite/',
        'fonts': src + 'fonts/',
        # 'docs': src + 'docs/'

    # entry point
    entry:
        'css': 'style.css',
        'js': 'script.js'
        'coffee': 'script.coffee'

    # after compile name
    name:
        'css': 'style.css'
        'js': 'script.js'

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
