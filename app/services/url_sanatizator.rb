class UrlSanatizator < Callable
  PROTOCOL_REGEXP = /(https?:\/\/)|(www\.)/
  def initialize(url:)
     @dirty_url = url
  end

  def call
    return nil if @dirty_url.nil?

    sanitanize()
  end

  private

  def sanitanize
    local_url = @dirty_url.strip
    local_url = @dirty_url.downcase.gsub(PROTOCOL_REGEXP, '')
    local_url.slice!(-1) if local_url[-1]
    "http://#{local_url}"
  end
end
