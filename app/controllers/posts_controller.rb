class PostsController < ApplicationController
  include SessionsHelper
  include PostsHelper
  def create
    @success = false
    @post = Post.new(post_params)
    @image = nil
    if !active_session_user.blank?
      @post.user_id = active_session_user.id
      @post.short_description = create_short_description(@post.description)
      @post.save
      if @post.errors.empty?
        if !params[:post][:tagphoto].blank? 
          @image = Image.create(file: params[:post][:tagphoto], imageable_type: 'Post', imageable_id: @post.id)
        end
        @post.update_attributes(tagphoto_url: @image.file.url)
        @success = true
      end
    end        
    redirect_to root_path
  end
  def global
  end
  def package
  end
  private
  def post_params
    params.require(:post).permit(:description, :player_embed)
  end
end
