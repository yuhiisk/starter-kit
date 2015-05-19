module Sass::Script::Functions

    # TODO: escape
    def escape(string)
        assert_type string, :String
        Sass::Script::Value::String.new(string.value.codepoints.map{ |i|
            '\\' + i.to_s(16).upcase
        }.join(''), string.type)
    end
    declare :escape, :args => [:string]
    
    def getUnicode(string)
        assert_type string, :String
        Sass::Script::String.new("\\"+string.value.ord.to_s(16), :string)
    end
    declare :getUnicode, :args => [:string]

    # reverse
    def reverse(string)
        assert_type string, :String
        Sass::Script::Value::String.new(string.value.reverse, string.type)
    end
    declare :reverse, [:string]

end