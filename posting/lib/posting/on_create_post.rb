module Posting
  class OnCreatePost
    include CommandHandler

    def call(command)
      with_aggregate(Post, command.aggregate_id) do |post|
        post.create(
          author: command.author,
          title: command.title,
          content: command.content
        )
      end
    end

  end
end
