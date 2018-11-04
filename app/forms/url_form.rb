class UrlForm
  include ActiveModel::Model

  attr_accessor(
      :original_url,
      :shortened_url,
      :sanitanized_url
  )

  validates :original_url, presence: true
  validates :original_url, format: { with: URI::regexp(%w(http https)), message: 'Link is not in proper format!' }

  def save
    return false unless valid?
    # maybe this 2 methods should
    # be extracted to model or override initializer?
    sanitanize()
    generate_short_link()
    ShortUrl.create(original_url: original_url, shortened_url: shortened_url, sanitanized_url: sanitanized_url)
  end

  def find_existing
    sanitanize()
    DuplicateUrlQuery.new({sanitanized_url: self.sanitanized_url}).call
  end

  def exists?
    find_existing().present?
  end

  # for form_for helper
  def self.model_name
    ActiveModel::Name.new(self, nil, 'ShortUrl')
  end

  private

  def sanitanize
    if self.sanitanized_url.nil?
      self.sanitanized_url = UrlSanatizator.call(url: self.original_url)
    end
  end

  def generate_short_link
    sanitanize()
    self.shortened_url = UrlShortener.call(url: self.sanitanized_url)
  end
end

