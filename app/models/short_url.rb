class ShortUrl < ApplicationRecord
  validates :original_url, presence: true
  validates :original_url, format: { with: URI::regexp(%w(http https)), message: 'Link is not in proper format!' }
  before_create :generate_short_link
  before_create :sanitanize

  def already_shortened?
    self.find_existing.present?
  end

  def find_existing
    ShortUrl.find_by_sanitanized_url(self.sanitanized_url)
  end

  def sanitanize
    self.original_url.strip!
    self.sanitanized_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    self.sanitanized_url.slice!(-1) if self.sanitanized_url[-1] == "/"
    self.sanitanized_url = "http://#{self.sanitanized_url}"
  end

  def generate_short_link
    # we want a 8 character shortened version
    random_string = [ *('0'..'9'), *('A'..'Z'), *('a'..'z')].sample(8).join
    # check if given string is already there
    already_used = ShortUrl.where(shortened_url: random_string).present?
    # may be dangerous - recurring but after (62) ** 8
    # heroku limit for rows is 10k ?
    if already_used
      self.generate_short_link
    else
      self.shortened_url = random_string
    end
  end
end
