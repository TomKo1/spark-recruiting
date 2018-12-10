class UrlForm
  MESSAGE = 'Link is not in proper format!'.freeze
  URL_REGEXP = URI::regexp(%w(http https))
  include ActiveModel::Model

  attr_accessor :original_url, :shortened_url, :sanitanized_url

  validates :original_url, presence: true
  validates :original_url, format: { with: URL_REGEXP, message: MESSAGE }

  # not good idea?
  def initialize(attributes={})
    super
    self.original_url = attributes[:original_url]
    self.sanitanized_url = UrlSanatizator.call(url: self.original_url)
    self.shortened_url = UrlShortener.call(url: self.sanitanized_url)
  end

  def save
    return false unless valid?

    ShortUrl.create(original_url: original_url, shortened_url: shortened_url, sanitanized_url: sanitanized_url)
  end

  def find_existing
    DuplicateUrlQuery.new(sanitanized_url: self.sanitanized_url).call
  end

  def exists?
    find_existing.present?
  end

  # for form_for helper
  def self.model_name
    ActiveModel::Name.new(self, nil, 'ShortUrl')
  end
end

