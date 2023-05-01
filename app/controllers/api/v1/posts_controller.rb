class Api::V1::PostsController < Api::V1::ApiController
  def create
    post = Post.new(post_params)
  
    # Create associated tags
    tag_ids = params.dig(:data, :attributes, :relationships, :tags, :data).pluck(:id)
    tags = Tag.where(id: tag_ids)
  
    post.tags = tags
  
    if post.save
      render jsonapi: post, status: :created
    else
      render jsonapi_errors: post.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def post_params
    params.require(:data).require(:attributes).permit(:title, :content, :brief)
  end
end