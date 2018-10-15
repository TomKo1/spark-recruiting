class ShortUrl < ApplicationRecord
  validates :original_url, presence: true
  before_create :generate_short_link


  def generate_short_link
    # we want a 8 character shortened version
    random_string = [('0'..'9'),('A'..'Z'),('a'..'z')].sample(8).to_s
    # check if given string is already there
    already_used = ShortUrl.where(generate_short_link: random_string).empty?
    if already_used
      self.generate_short_link
    else
      self.shortened_url = random_string
    end
  end
end
