class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %w(preview)
  
  def index
    @post = Post.last
  end

  def preview
    @post = Post.new(
      title: params[:title], 
      content: params[:content], 
      user_id: current_user.id, 
      created_at: DateTime.now)
    render :index
  end
end
