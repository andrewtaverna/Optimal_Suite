class ResultsController < ApplicationController
  before_action :set_json, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :trial_end
  # GET /jsons
  # GET /jsons.json
  def index
    @results = Result.where(dashboardid: params[:dashboardid])
    render json: @results
  end

  # GET /jsons/1
  # GET /jsons/1.json
  def show
    render json: @result
  end

  # POST /jsons
  # POST /jsons.json
  def create
    @result = Result.new(result_params)

    if @result.save
      render json: @result, status: :created, location: @result
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jsons/1
  # PATCH/PUT /jsons/1.json
  def update
    @result = Result.find(params[:id])

    if @result.update(result_params)
      head :no_content
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jsons/1
  # DELETE /jsons/1.json
  def destroy
    @result.destroy

    head :no_content
  end

  private

    def set_json
      @result = Result.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:correct_node, :dashboardid, :timespent, :questionid, :participantid, :path, :firstclick)
    end

end