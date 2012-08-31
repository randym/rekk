class CommentsController < ApplicationController

  before_filter :find_commentable, only: [:index, :new, :create, :update]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @commentable.comments.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /comments/#id/edit
  # GET /comments/#id/edit.json

  def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html { render action: "new", layout: false }
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  # requires that params contans commentable and commentable_id
  def new
    @comment = Comment.new(options_for_commentable)
    respond_to do |format|
      format.html { render layout: false } # new.html.erb
      format.json { render json: @users }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy()
    render nothing: true
  end

  # GET /comments/1
  # GET /comments/1.json
  def create
    @comment = Comment.find_or_initialize_by_id(params[:id])
    params[:comment][:user] = current_user
    @comment.update_attributes(params[:comment])

    if @comment.save
      respond_to do |format|
        format.html { render action: "show", layout: false }
        format.json { render json: @comment }
      end
    else
      respond_to do |format|
        format.html { render action: "new", layout: false }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    create
  end

  private

  def find_commentable
    @commentable = Comment.find_commentable(params[:type] || params[:comment][:commentable],
                                            params[:commentable_id] || params[:comment][:commentable_id])
    instantiate_commentable_param
  end

  def instantiate_commentable_param
    if params[:comment] && params[:comment][:commentable]
      params[:comment][:commentable] = @commentable
    end
  end

  def options_for_commentable
    { commentable: @commentable,
      commentable_id: @commentable.id, 
      user: current_user }
  end
end
