class TeamsController < ApplicationController
  load_and_authorize_resource
  

  def index  
    @teams = Team.all

    # Modal form
    @team = Team.new # not the best practice but works for now
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end


  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end


  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        flash[:error] = 'Team Name and Users are required'
        format.html { redirect_to teams_path }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to teams_path, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @team = Team.find(params[:id])
    if @team.open_tickets.empty?
      @team.destroy
    else
      flash[:notice] = "This team can't be deleted because it has open tickets"
    end

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
