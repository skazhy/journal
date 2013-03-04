#
# A basic (HT|X)ML compressor
#

module Jekyll
  module Compressor
    def output_html(dest, content)
      path = self.destination(dest)
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') {|f| f.write(content.gsub(/>\s+</, '><'))}
    end
  end

  class Post
    include Compressor
    def write(dest)
      self.output_html(dest, self.output)
    end
  end

  # index.html & feeds
  class Page
    include Compressor
    def write(dest)
      self.output_html(dest, self.output)
    end
  end
end
