class ArticlesController < ApplicationController
	
	def index
		redirect_to :action => "hot"
	end

	def hot
		@articles = []
		Article.all.each do |a|
			if a.votes.count >= 40
				@articles << a
			end
		end
		@articles = @articles.paginate(:page => params[:page], :per_page => 5)
	end

	def trending
		@articles = []
		Article.all.each do |a|
			if a.votes.count >= 20
				@articles << a
			end
		end
		@articles = @articles.paginate(:page => params[:page], :per_page => 5)
	end

	def fresh
		@articles = Article.paginate(:page => params[:page], :per_page => 5)
	end

	def show
		@article = Article.find(params[:id])
		@comments = @article.comments
	end

	def edit
		@article = Article.find(params[:id])
		if !(current_user.id == @article.user_id)
			redirect_to articles_path
		end
	end

	def update
	  @article = Article.find(params[:id])
	 
	  if @article.update(article_params)
	    redirect_to @article
	  else
	    render 'edit'
	  end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		if current_user.id == @article.user_id
			@article.destroy
		end
			
		redirect_to articles_path
	end

	private
		def article_params
			params.require(:article).permit(:title, :text, :user_id)
		end
end
