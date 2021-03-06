class ShortUrlsController < ApplicationController
  def index
    @urls = ShortUrl.all
  end

  def new
    @url = UrlForm.new
  end

  def create
    @url = UrlForm.new(url_params)

    if @url.exists?
      redirect_to short_url_path(@url.find_existing), alert: I18n.t('controllers.shortener.alerts.wasshortened')
    elsif @url.save
      redirect_to result, alert: I18n.t('controllers.shortener.alerts.shortened')
    end
    render :new
  end

  def redirect_original
    @whole_url = ShortUrl.find_by_shortened_url(params[:short_url])
    redirect_to @whole_url.original_url
  end

  def show
    @url = ShortUrl.find(params[:id])
  end

  private

  def url_params
    params.require(:short_url).permit(:original_url)
  end
end
