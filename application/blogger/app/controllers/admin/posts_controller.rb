class Admin::PostsController < Admin::ApplicationController
  def index
    @posts = Post.get_all params
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.save_data post_params, current_user
    if @post.valid?
      flash[:success] = "Post was successfully created."
      redirect_to admin_posts_path
    else
      flash[:warning] = "Cannot create post, please try again."
      render :new
    end
  end

  def edit
    get_by_id params[:id]
    if @post.nil?
      flash[:warning] = "Post with id #{params[:id]} not found."
      redirect_to admin_posts_path
      return
    end
    render :new
  end

  def update
    @post = Post.save_data post_params, current_user
    if @post.valid?
      flash[:success] = "Post was successfully updated."
      redirect_to admin_posts_path
    else
      flash[:warning] = "Cannot update post, please try again."
      render :edit
    end
  end

  def destroy
    get_by_id params[:id]
    if @post.delete
      flash[:success] = "Post was successfully deleted."
    else
      flash[:warning] = "Cannot delete post, please try again."
    end
    redirect_to admin_posts_path
  end

  def show
    get_by_id params[:id]
    if @post.nil?
      flash[:warning] = "Post with id #{params[:id]} not found."
      redirect_to admin_posts_path
    end
  end

  private 
    def get_by_id(id)
      begin
        @post = Post.friendly.find id
      rescue ActiveRecord::RecordNotFound => e
        @post = nil
      end
    end

  private
    def post_params
      params.require(:post).permit(:category_id, :title, :content, :id)
    end
end
