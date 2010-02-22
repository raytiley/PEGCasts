class CommentsController < ApplicationController
  def index
    @commentable = find_commentable
    @comments = @commentable.comments.all
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @commentable = find_commentable
    @comment = @commentable.comments.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      flash[:notice] = "Successfully created comment."
      respond_to do |format|
        format.html {redirect_to original_commentable(@comment)}
        format.js
      end
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to @comment
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to comments_url
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def original_commentable comment
    original = comment
    while(original.class == Comment)
      original = original.commentable
    end
    return original
  end

end