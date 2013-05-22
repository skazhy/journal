module Jekyll
  class Post
    ATTRIBUTES_FOR_LIQUID.push('draft?')

    def draft?
      @base.include? '/_drafts'
    end
  end
end
