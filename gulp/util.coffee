###
 * https://github.com/frontainer/frontplate
 *
 * コンフィグタスク
 * config.jsを読み取り、パスを書きかえるタスク
 * 定数の設定も行う
###
# config = Object.create(require('./config'))
config = require './config'
_ = require('lodash')

###
 * コマンドで指定されたタイプを取得する
 * @param args
 * @returns {*}
###
getType = (args) ->
    result = _.findLast(args, (val) ->
        return /^-(?!-)+/.test(val)
    )
    if result then return result.replace(/^-/, '')
    return config.DEFAULT_TYPE

TYPE = getType(process.argv)
TYPE_REG = /%type%/g
TYPE_DIST_REG =
    if TYPE isnt config.DEFAULT_TYPE
        /%type_dir%/g
    else
        # TYPEが空
        /%type_dir%\//g

###
 * パスをタイプに合わせて書きかえる
 * @param data
 * @returns {}
###
buildPath = (data, reg, replaceStr) ->
    if typeof data is 'number' then return data
    if typeof data is 'string' then return data.replace(reg, replaceStr)

    for key of data
        value = data[key]
        delete data[key]
        data[buildPath(key, reg, replaceStr)] = buildPath(value, reg, replaceStr)

    return data

if config.DEFAULT_TYPE is TYPE
    buildPath(config.path, TYPE_DIST_REG, '')
else
    buildPath(config.path, TYPE_DIST_REG, TYPE)
buildPath(config.path, TYPE_REG, TYPE)
config.TYPE = TYPE
module.exports = config
