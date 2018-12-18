module Posts
  class OnPostCreated
    def call(event)
      uid = event.data[:post_id]

      return if Post.where(uid: uid).exists?

      Post.create!(
        uid: uid,
        title: event.data[:title],
        content: event.data[:content],
        author: event.data[:author]
      )
    end
  end
end
