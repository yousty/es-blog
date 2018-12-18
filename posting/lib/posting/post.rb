require 'aggregate_root'

module Posting
  class Post
    include AggregateRoot

    AlreadyCreated = Class.new(StandardError)

    def initialize(id)
      @id = id
      @state = :draft
    end

    def create(author:, title:, content:)
      raise AlreadyCreated if @state == :created
      apply PostCreated.new(
        data: {
          post_id: @id, author: author, title: title, content: content
        }
      )
    end

    on PostCreated do |event|
      @author = event.data[:author]
      @title = event.data[:title]
      @content = event.data[:content]
      @state = :created
    end
  end
end
