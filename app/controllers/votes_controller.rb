class VotesController < ApplicationController
	def vote
		@article = Article.find(params[:id])
		@vote = Vote.create!(article_id: @article.id, user_id: current_user.id)
	end

	def remove_vote
		@article = Article.find(params[:id])
		@vote = Vote.find_by_article_id(@article.id)

		@vote.destroy
	end
end
