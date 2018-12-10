class DuplicateUrlQuery
  def initialize(params = {}, relation = ShortUrl.all)
    @realtion = relation
    @params = params
  end

  def call
    sanitanized_url = @params[:sanitanized_url]
    return nil if sanitanized_url.nil?

    @relation.find_by_sanitanized_url(sanitanized_url)
  end
end
