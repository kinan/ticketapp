class PrioritiesController < ApplicationController
  before_filter :authenticate
  load_and_authorize_resource
  
  # GET /priorities
  # GET /priorities.json
  def index
    @priorities = Priority.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @priorities }
    end
  end


  # GET /priorities/new
  # GET /priorities/new.json
  def new
    @priority = Priority.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @priority }
    end
  end

  # GET /priorities/1/edit
  def edit
    @priority = Priority.find(params[:id])
  end

  # POST /priorities
  # POST /priorities.json
  def create
    @priority = Priority.new(params[:priority])

    respond_to do |format|
      if @priority.save
        format.html { redirect_to priorities_url, notice: 'Priority was successfully created.' }
        format.json { render json: @priority, status: :created, location: @priority }
      else
        format.html { render action: "new" }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /priorities/1
  # PUT /priorities/1.json
  def update
    @priority = Priority.find(params[:id])

    respond_to do |format|
      if @priority.update_attributes(params[:priority])
        format.html { redirect_to priorities_url, notice: 'Priority was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /priorities/1
  # DELETE /priorities/1.json
  def destroy
    @priority = Priority.find(params[:id])
    @priority.destroy

    respond_to do |format|
      format.html { redirect_to priorities_url }
      format.json { head :no_content }
    end
  end
end
