class CommentsController < ApplicationController
  before_action :set_comment %i[edit update destroy]
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    respond_to do |format|
      if @comment.save!
        format.js { render :index }
      else
        format.html { redirect_to article_path(@article), notice: '投稿できませんでした...' }
      end
    end
  end

  def edit; end

  def update
    redirect_to article_path(@comment.article) if @comment.update(comment_params)
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.js { render :index }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article_id, :content, :article_id).merge(user_id: current_user.id)
  end
end
