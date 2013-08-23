class PostsController < ApplicationController

  # Set the @post for all actions that expect an post to
  # already exist.
  before_filter :except => [:index, :new, :create] do
    @post = Post.find(params[:id])
  end

  # Authenticate logged in member is an officer.
  before_filter :except => [:index, :show] do
    logged_in! :as_officer => true
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    render :edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, :notice => "Created post."
    else
      render :edit
    end
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to @post, :notice => "Updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, :notice => "Post deleted successfully."
  end

  private

  # Requires
  # * `:post`
  # Permits
  # * `:title`
  # * `:body`
  #
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
