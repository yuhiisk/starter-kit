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
    return ''

TYPE = getType(process.argv)
TYPE_REG =
    if TYPE isnt ''
        /%type%/g
    else
        # TYPEが空
        /%type%\//g

###
 * パスをタイプに合わせて書きかえる
 * @param data
 * @returns {}
###
buildPath = (data) ->
    if typeof data is 'number' then return data
    if typeof data is 'string' then return data.replace(TYPE_REG, TYPE)

    for key of data
        value = data[key]
        delete data[key]
        data[buildPath(key)] = buildPath(value)

    return data

buildPath(config.path)
config.TYPE = TYPE
module.exports = config
