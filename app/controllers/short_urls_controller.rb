class ShortUrlsController < ApplicationController
    def new
      @url = ShortUrl.new
    end

    def create
      @url = ShortUrl.new(url_params)
      # TODO: to this as remot on the same page home (with ne and create form)
      if @url.save
        redirect_to @url, notice: 'Successfully shortened yout link!'
      else
        render :new
      end
    end

    def show
      @url = ShortUrl.find(params[:id])
    end

    private

    def url_params
      params.require(:short_url).permit(:original_url, :shortened_url)
    end
end
