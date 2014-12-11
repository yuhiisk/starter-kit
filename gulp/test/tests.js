// unit test
'use strict';

QUnit.test( "a basic test example", function( assert ) {
    var value = 'hello';
    assert.equal( value, "hello", "We expect value to be hello" );
});

// ok(): trueかどうか
QUnit.test( "ok test", function( assert ) {
    // 通る
    assert.ok( true, "true succeeds" );
    assert.ok( "non-empty", "non-empty string succeeds" );

    // 失敗
    assert.ok( false, "false fails" );
    assert.ok( 0, "0 fails");
    assert.ok( NaN, "NaN fails");
    assert.ok( "", "empty string fails");
    assert.ok( null, "null fails");
    assert.ok( undefined, "undefined fails");
});

// equal(): trueかどうかだけど、2つの値がtrueかどうか
QUnit.test( "equal test", function( assert ) {
    assert.equal( 0, 0, "Zero, Zero; equal succeeds" );
    assert.equal( "", 0, "Empty, Zero; equal succeeds" );
    assert.equal( "", "", "Empty, Empty; equal succeeds" );
    assert.equal( 0, false, "Zero, false; equal succeeds" );

    assert.equal( "three", 3, "Three, 3; equal fails" );
    assert.equal( null, false, "null, false; equal fails" );
});
// strictEqual() [===] もある

// deepEqual(): objectのkey,valueや配列や関数の比較
QUnit.test( "deepEqual test", function( assert ) {
    var obj = { foo: "bar" };
    var f = test;

    assert.deepEqual( obj, { foo: "bar" }, "Two objects can be the same in value");
    assert.deepEqual( f, test, "Two objects can be the same in value");
});

// expect(): 同期処理 アサーションの数を指定する,数が違えば失敗
QUnit.test( "a test" , function( assert ) {
    assert.expect( 2 );

    function calc( x, operation ) {
        return operation( x );
    }

    var result = calc( 2, function( x ) {
        assert.ok( true, "calc() calls operation function" );
        return x * x;
    });

    assert.equal( result, 4, "2 square equals 4" );
});

QUnit.test( "a test", function( assert ) {
    assert.expect( 1 );

    var $body = $( "body" );

    $body.on( "click", function() {
        assert.ok( true, "body was clicked!" );
    });

    $body.trigger( "click" );
});

// async(): 非同期処理
QUnit.test( "asynchronous test: async input focus", function( assert ) {
    var done = assert.async();
    var input = $( "#test-input" ).focus();
    setTimeout(function() {
        assert.equal( document.activeElement, input[0], "Input was focused" );
        done();
    }, 0);
});


// user action
function KeyLogger( target ) {
    this.target = target;
    this.log = [];

    var that = this;
    this.target.off( "keydown" ).on( "keydown", function( event ) {
        that.log.push( event.keyCode );
    });
}

QUnit.test( "keylogger api behavior", function( assert ) {
    var $doc = $( document ),
        keys = new KeyLogger( $doc );

    // Trigger the key event
    $doc.trigger( $.Event( "keydown", { keyCode: 9 } ) );
    // Verify expected behavior
    assert.deepEqual( keys.log, [ 9 ], "correct key was logged");
});

