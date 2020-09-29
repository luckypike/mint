class PagesController < ApplicationController
  before_action :authorize_page

  def index
    @slides = Slide.with_translations(I18n.available_locales)
      .includes(:video_mp4_attachment)
      .where.not(image: nil).order(weight: :asc)
  end

  def instagram
    url = "https://graph.instagram.com/me/media?fields=id,media_type,media_url,permalink&access_token=#{Rails.application.credentials.dig(:instagram, :token)}"

    @posts = JSON.parse(Net::HTTP.get(URI(url))).with_indifferent_access

    respond_to :json
  end

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  def about; end

  # def contacts; end

  private

  def authorize_page
    authorize :page
  end
end
