class JsonsController < ApplicationController
  before_action :set_json, only: [:show, :update, :destroy]
  # GET /jsons
  # GET /jsons.json
  def index
    @jsons = Json.where(dashboardid: params[:dashboardid])
    render json: @jsons
  end

  # GET /jsons/1
  # GET /jsons/1.json
  def show
    render json: @json
  end

  # POST /jsons
  # POST /jsons.json
  def create
    @json = Json.new(json_params)

    if @json.save
      render json: @json, status: :created, location: @json
    else
      render json: @json.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jsons/1
  # PATCH/PUT /jsons/1.json
  def update
    @json = Json.find(params[:id])

    if @json.update(json_params)
      head :no_content
    else
      render json: @json.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jsons/1
  # DELETE /jsons/1.json
  def destroy
    @json.destroy

    head :no_content
  end

  private

    def set_json
      @json = Json.find(params[:id])
    end

    def json_params
      params.require(:json).permit(:text, :parent, :id, :dashboardid)
    end
end
