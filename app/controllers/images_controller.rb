class ImagesController < ApplicationController
  def create
    image = Image.new(image_params)
    authorize image

    if image.save
      # head :ok
      render json: { image: image, url: image_path(image) }
    else
      render text: "\"#{image.errors.full_messages.first}\"", status: 422
    end
  end

  def weight
    image = Image.find(params[:id])
    authorize image

    image.update_attribute(:weight, params[:weight])
    head :ok
  end

  def destroy
    image = Image.find(params[:id])
    authorize image
    image.destroy


    respond_to do |format|
      format.html {
        redirect_to [:variants, image.imagable.product]
      }
      format.json {
        render json: image
      }
    end
  end

  private
  def image_params
    params.require(:image).permit(:id, :photo, :imagable_type, :imagable_id)
  end
end
