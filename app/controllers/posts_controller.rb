class PostsController < ApplicationController
  def index
    @posts = Posts::Post.all
  end

  def show
    @post = Posts::Post.find(params[:id])
  end

  def new
    @post = Posts::Post.new
  end

  def create
    cmd = Posting::CreatePost.new(
      post_params.to_h.symbolize_keys.merge(post_id: SecureRandom.uuid)
    )

    command_bus.(cmd)
    redirect_to(
      post_path(Posts::Post.find_by_uid(cmd.post_id)),
      notice: 'Post was successfully created.'
    )
  end


  private

  def post_params
    params.require(:posts_post).permit(:author, :title, :content)
  end
end
