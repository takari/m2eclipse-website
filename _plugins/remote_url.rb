require 'net/http'
require 'uri'

module Jekyll

  class RemoteUrlTag < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      #markup is what is defined in the tag. Lets make it a URL so devs 
      #don't have to update code if the URL changes.
      url = markup

      if url =~ URI::regexp
        @doc = open(url)
      else
        raise 'Invalid URL passed to RemoteUrlTag'
      end

      super
    end

    def open(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      http.request(request).body
    end

    def render(context)
      output = super
      if @doc 
        @doc
      else
        "Something went wrong in RemoteFooterTag"
      end
    end
  end
end

Liquid::Template.register_tag('remote_url', Jekyll::RemoteUrlTag)
