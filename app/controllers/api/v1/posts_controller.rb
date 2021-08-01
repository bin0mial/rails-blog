class Api::V1::PostsController < Api::V1::ApplicationController
  before_action :set_post, only: %i[ show ]

  def index
    @posts = authorize(Post.all)
    success @posts, 200, PostBlueprint
  end

  def show
    success @post, 200, PostBlueprint
  end


  private
  def set_post
    @post = authorize Post.includes(:creator, :category).find(params[:id])
  end
end
