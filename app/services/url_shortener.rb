class UrlShortener < Callable
    # http://leohetsch.com/include-vs-prepend-vs-extend/
  def initialize(url:)
    @url = url
  end

  def call
    return nil if @url.nil?

    short_link()
  end

  private

  def short_link
    random_string = [ *('0'..'9'), *('A'..'Z'), *('a'..'z')].sample(8).join
    already_used = ShortUrl.where(shortened_url: random_string).exists?
    if already_used
      short_link()
    else
      random_string
    end
  end
end
