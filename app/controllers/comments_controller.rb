class CommentsController < ApplicationController
  before_filter :require_admin, :only => [:edit, :destroy]
  require "uri"
  require "net/http"
  
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
    else
      @commentable = find_commentable
      @comment = @commentable.comments.new(params[:comment])
      if verify_captcha(params[:recaptcha_challenge_field], params[:recaptcha_response_field]) && @comment.save
        flash[:notice] = "Successfully created comment."
        respond_to do |format|
          format.html {redirect_to original_commentable(@comment)}
          format.js
        end
      else
        respond_to do |format|
          flash[:notice] = "There were errors submitting your comment.  Please try again."
          format.html {render :action => 'new'}
          format.js {render :action => 'ajax_error'}
        end
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
  
  def verify_captcha challenge, response
    params = {'privatekey' => '6LeYBwkAAAAAAPvejlUsY4TOkqF_KhgUDa6QJ7z0',
              'remoteip'   => request.env['REMOTE_ADDR'],
              'challenge'  => challenge,
              'response'   => response }
    x = Net::HTTP.post_form(URI.parse('http://www.google.com/recaptcha/api/verify'), params)
    if x.body.include? "true"
      return true
    else
      flash[:notice] = "reCaptcha did not verify.  Please try again"
      return false
    end
  end
end