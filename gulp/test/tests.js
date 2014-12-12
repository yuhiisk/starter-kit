// unit test
'use strict';

QUnit.test('basic test', function(assert) {
    assert.ok('1' == 1, 'number is 1.')
});

QUnit.test('basic test(deep)', function(assert) {
    assert.equal('1' , 1, 'number is 1.')
});

QUnit.test('basic test(deep)', function(assert) {
    assert.deepEqual('1' , 1, 'number is 1.')
});

