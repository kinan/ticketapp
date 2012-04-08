class CommentsController < ApplicationController
  before_filter :authenticate
  load_and_authorize_resource

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.paginate(:page => params[:page])
    @ticket = Ticket.find(params[:ticket_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end


  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    ticket = Ticket.find params[:ticket_id]
    @comment.ticket = ticket

    respond_to do |format|
      if @comment.save
        format.html { redirect_to ticket, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        flash[:error] = "Couldn't save your comment"
        format.html { redirect_to ticket }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

end
