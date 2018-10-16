class ShortUrlsController < ApplicationController
  def new
    @url = ShortUrl.new
  end

  def create
    @url = ShortUrl.new(url_params)
    @url.sanitanize
    if @url.already_shortened?
      redirect_to short_url_path(id: @url.find_existing), alert: 'Link was already shortened'
    else
      if @url.save
      else
        render :new
      end
    end
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
