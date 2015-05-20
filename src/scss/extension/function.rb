require 'base64'
require "sass"

module SkywardDesignFunctions
    def zeropadding(beam, i)
        assert_type beam, :Number
        assert_type i, :Number
        
        retVal = sprintf("%0" + beam.to_s + "d", i)
        Sass::Script::String.new(retVal)
    end

    def str_replace(search_cond, replace_str, str)
        assert_type search_cond, :String
        assert_type replace_str, :String
        assert_type str, :String

        if (/\/.+\// =~ search_cond.value) then
            search_cond.value.gsub!(/\//, "")
            retVal = str.value.gsub(/#{search_cond.value}/, replace_str.value)
        else
            retVal = str.value.sub(search_cond.value, replace_str.value)
        end

        Sass::Script::String.new(retVal)
    end
end

module Sass::Script::Functions

    include SkywardDesignFunctions

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

    def url64(image)
        assert_type image, :String

        # compute file/path/extension
        
        # from the current directory /sass/ (which is one level down from root) I'd expect ../ to take me up to the root
        # i don't know why but to find base path we need to set it one level higher than expected?
        base_path = '../../../' # root 

        root = File.expand_path(base_path, __FILE__)
        path = image.to_s[1, image.to_s.length-2]
        fullpath = File.expand_path(path, root)
        absname = File.expand_path(fullpath)
        ext = File.extname(path)

        # optimize image if it's a gif, jpg, png
        if ext.index(%r{\.(?:gif|jpg|png)}) != nil
            # homebrew link to pngcrush is outdated so need to avoid pngcrush for now
            # also homebrew doesn't support pngout so we ignore that too!
            # The following links show the compression settings...
            # https://github.com/toy/image_optim/blob/master/lib/image_optim/worker/advpng.rb
            # https://github.com/toy/image_optim/blob/master/lib/image_optim/worker/optipng.rb
            # https://github.com/toy/image_optim/blob/master/lib/image_optim/worker/jpegoptim.rb
            # image_optim = ImageOptim.new(:pngcrush => false, :pngout => false, :advpng => {:level => 4}, :optipng => {:level => 7}, :jpegoptim => {:max_quality => 1}) 
            
            # we can lose the ! and the method will save the image to a temp directory, otherwise it'll overwrite the original image
            # image_optim.optimize_image!(fullpath)
        end

        # base64 encode the file
        file = File.open(fullpath, 'rb') # read mode & binary mode
        filesize = File.size(file) / 1000# seems to report the size as being 1kb smaller than it actually is (so if our limit is 32kb for IE8 then we need our limit to be 31kb)
        text = file.read
        file.close

        if filesize < 31 # we're avoiding IE8 32kb data uri size restriction
            text_b64 = Base64.encode64(text).gsub(/\r/,'').gsub(/\n/,'')
            contents = 'url(data:' + mime(ext) + ';base64,' + text_b64 + ')'
        else
            contents = 'url(' + image.to_s + ')' # if larger than 32kb then we'll just return the original image path url
        end

        Sass::Script::String.new(contents)
    end

    def mime(extension)
        case extension
        when '.svg'
            'image/svg+xml'
        else
            'image/' + extension[1, extension.length-1]
        end
    end

    declare :url64, :args => [:string]
end