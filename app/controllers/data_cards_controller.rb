class DataCardsController < ApplicationController
  before_action :set_data_card, only: [:show, :edit, :update, :destroy]

  # GET /data_cards
  # GET /data_cards.json
  def index
    @data_cards = DataCard.all
  end

  # GET /data_cards/1
  # GET /data_cards/1.json
  def show
  end

  # GET /data_cards/new
  def new
    @data_card = DataCard.new
  end

  # GET /data_cards/1/edit
  def edit
  end

  # POST /data_cards
  # POST /data_cards.json
  def create
    @data_card = DataCard.new(data_card_params)

    if @data_card.save
      render json: @data_card, status: :created, location: @data_card
    else
      render json: @data_card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_cards/1
  # PATCH/PUT /data_cards/1.json
  def update
    @data_card = DataCard.find(params[:id])

    if @data_card.update(data_card_params)
      head :no_content
    else
      render json: @data_card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /data_cards/1
  # DELETE /data_cards/1.json
  def destroy
    @data_card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_card
      @data_card = DataCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_card_params
      params[:data_card]
    end
end
