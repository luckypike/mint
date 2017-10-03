class ThemesController < ApplicationController
  before_action :set_theme, only: [:edit, :update, :destroy, :show]

  def colors

  end

  def index
    authorize Theme
    # redirect_to Theme.order(weight: :asc).first
  end

  def show
    authorize @theme

    kits = Kit.includes(:images, :variants).where.not(kitables: { id: nil }).where(variants: { state: [:active, :out] }, theme: @theme, state: :active).where.not(images: { id: nil })
    excluded_products = kits.map(&:variants).flatten.map(&:id)

    variants = Variant.includes(:images, :kitables, :product).themed_by([@theme.id]).where(state: [:active, :out], products: { state: :active }).where.not(images: { id: nil }, id: excluded_products)
    @products = kits + variants
  end

  def new
    @theme = Theme.new
  end

  def edit
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      redirect_to @theme, notice: 'Theme was successfully created.'
    else
      render :new
    end
  end

  def update
    if @theme.update(theme_params)
      redirect_to @theme, notice: 'Theme was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url, notice: 'Theme was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def theme_params
      params.require(:theme).permit(:title, :slug, :desc)
    end
end
