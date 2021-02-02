class PostController < ApplicationController
  def create
  end

  def store
  	auth = {
		  cloud_name: ENV["cloud_name"],
		  api_key:    ENV["api_key"],
		  api_secret: ENV["api_secret"]
		}

  	@image = Cloudinary::Uploader.upload(params[:media], auth) if params[:media].present?
  	url = @image['secure_url'] if @image.present?
    # create a new post object and save to db
    @post = current_user.posts.new({:title => params[:title], :body => params[:body], :author => params[:author],  :media => url})
    @post.save
    # trigger an event with pusher
    redirect_to(post_list_path)
  end

  def list
  	if current_user.superadmin_role? 
  		@posts = Post.all.order("created_at DESC")
		elsif current_user.user_role? 
			@posts = current_user.posts.order("created_at DESC")
		end 
  end

 	def destroy
 		post = Post.find(params[:id]) rescue nil
 		post.destroy if post.present?
 		redirect_to(post_list_path)
 	end

 	def edit
 		@post = Post.find(params[:id]) rescue nil
 	end

 	def update
 		@post = Post.find(params[:id]) rescue nil
 
 		if @post.present?
 			@post.update({:title => params[:title], :body => params[:body], :author => params[:author]})
 		end
 		redirect_to(post_list_path)
 	end

 	def comment_create
 		@post = Post.find(params[:id]) rescue nil
 		if @post.present?
 			@post.comments.create(comment_text: params[:comment_text])
 		end
 		redirect_to(post_list_path)
 	end

 	def comment_update
 		comment = Comment.find(params[:id]) rescue nil
 		comment.update(comment_text: params[:comment_text]) if comment.present?
 		redirect_to(post_list_path)
 	end

 	def comment_delete
 		comment = Comment.find(params[:id]) rescue nil
 		comment.destroy if comment.present?
 		redirect_to(post_list_path)
 	end
end
