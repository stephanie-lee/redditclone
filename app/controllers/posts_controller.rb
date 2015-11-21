class PostsController < ApplicationController
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to subs_path
    else
      render :new
    end
  end

  def edit
    @post = current_post
    @subs = Sub.all
    render :edit
  end

  def update
    @post = current_post

    if @post.update(post_params)
      fail
      redirect_to subs_path
    else
      render :edit
    end
  end

  def destroy
    current_post.destroy
    redirect_to subs_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_ids)
  end

  def current_post
    Post.find(params[:id])
  end
end
