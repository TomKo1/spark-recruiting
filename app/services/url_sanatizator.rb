class UrlSanatizator < Callable

    def initialize(url:)
        @dirty_url = url
    end

    def call
        sanitanize()
    end

    private

    def sanitanize
        @dirty_url.strip!
        local_url = @dirty_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
        local_url.slice!(-1) if local_url[-1]
        "http://#{local_url}"
    end
end
