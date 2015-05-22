class CommentsController < ApplicationController
 def create
   @article = Article.find(params[:article_id])
   @comment = @article.comments.create(comment_params)
   
   redirect_to article_path(@article)
 end

 def destroy
 	@article = Article.find(params[:article_id])
 	@comment = @article.comments.find(params[:id])

 	if current_user.id == @comment.user_id
	 	@comment.destroy
	 	
	 	redirect_to article_path(@article)
	else
		redirect_to @article
	end
 end


 private
 	def comment_params
 		params.require(:comment).permit(:body, :user_id)
 	end
end
