# very 'weak' example of query object
# the query is not so 'large' to extracty it to separate
# class
# Still we have ability to extend this logic here without making
# e.g form object 'large'
class DuplicateUrlQuery

    def initialize(params = {}, relation = ShortUrl.all)
        @realtion = relation
        @params = params
    end

    def call
        sanitanized_url = @params[:sanitanized_url]
        return nil if sanitanized_url.nil?
        ShortUrl.find_by_sanitanized_url(sanitanized_url)
    end
end
