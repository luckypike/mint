class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[edit update show]

  layout 'app'

  def show
    authorize @collection

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @collection = Collection.new
    authorize @collection
  end

  def edit
    authorize @collection
  end

  def create
    @collection = Collection.new(collection_params)
    authorize @collection

    if @collection.save
      head :created, location: collections_path
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @collection

    if @collection.update(collection_params)
      head :ok, location: collection_path(@collection.id)
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def index
    authorize Collection

    @collections = Collection.all
  end

  private

  def set_collection
    @collection = Collection.friendly.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(
      :title, :slug, :desc, :text, :weight,
      image_ids: [], images_attributes: %i[id weight]
    )
  end
end
