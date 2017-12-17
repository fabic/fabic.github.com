# A simple way to inspect liquid template variables.
# Usage:
#  Can be used anywhere liquid syntax is parsed (templates, includes, posts/pages)
#  {{ site | debug }}
#  {{ site.posts | debug }}
#
# Found at https://joshuacox.github.io/jekyll/2015/12/02/Jekyll-Debug/
# through https://stackoverflow.com/a/34049498/643087
# original author (?): https://raw.githubusercontent.com/progrium/blogrium/master/_plugins/debug.rb
#
require 'pp'
module Jekyll
  # Need to overwrite the inspect method here because the original
  # uses < > to encapsulate the psuedo post/page objects in which case
  # the output is taken for HTML tags and hidden from view.
  #
  class Post
    def inspect
      "#Jekyll:Post @id=#{self.id.inspect}"
    end
  end

  class Page
    def inspect
      "#Jekyll:Page @name=#{self.name.inspect}"
    end
  end

end # Jekyll

module Jekyll
  module DebugFilter

    def debug(obj, stdout=false)
      puts obj.pretty_inspect if stdout
      "<pre>#{obj.class}\n#{obj.pretty_inspect}</pre>"
    end

  end # DebugFilter
end # Jekyll

Liquid::Template.register_filter(Jekyll::DebugFilter)
