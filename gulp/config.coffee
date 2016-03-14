# Autoprefixer
AUTOPREFIXER_BROWSERS = [
    "ie >= 8",
    "ie_mob >= 10",
    "ff >= 30",
    "chrome >= 34",
    "safari >= 7",
    "opera >= 23",
    "ios >= 7",
    "android >= 4.0",
    "bb >= 10"
]

# Device type
typeStr = "%type%"
typeDist = "%type_dir%"

# Directory
root = "./"
src = "#{root}src/"
dist = "#{root}dist/"
# common = "#{root}dist/common/"
# src_common = "#{root}src/common/"

config =
    DEFAULT_TYPE: "pc"
    distTypeDir: ""
    # directory path
    path:
        # document root
        "htdocs" : dist + "#{typeDist}/"
        # distribution
        "dist"   : dist + "#{typeDist}/"
        "css"    : dist + "#{typeDist}/css/"
        "js"     : dist + "#{typeDist}/js/"
        "image"  : dist + "#{typeDist}/img/"
        # sources
        "src"         : src
        "scss_common" : src + "scss/common/"
        "scss"        : src + "scss/#{typeStr}/"
        "coffee"      : src + "coffee/#{typeStr}/"
        "jade"        : src + "jade/#{typeStr}/"
        "sprite"      : src + "sprite/#{typeStr}/"
        "fonts"       : src + "fonts/#{typeStr}/"

        # "docs": src + "docs/'

    # entry point
    entry:
        "css"    : "style.css"
        "js"     : "script.js"
        "coffee" : "script.coffee"

    # after compile name
    name:
        "css" : "style.css"
        "js"  : "script.js"

    # sass option
#    sass:
#        lib: ./src/scss/extension/function.rb"

    # task configs
    autoprefixer: AUTOPREFIXER_BROWSERS
    modernizr:
        filename: "modernizr.min.js"
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
            "canvas"
        ]

module.exports = config
