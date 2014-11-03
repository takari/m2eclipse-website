module Jekyll
  module ShareButtonsFilter
    def share_buttons url
      full_url = "http://takari.io#{url}"
       
      <<-HTML
      <div class="buttons">
        <div class="fb-like"
          data-href="#{full_url}"
          data-send="true"
          data-layout="button_count"
          data-width="90"
          data-show-faces="false">
        </div>            
        <div class="twitter-button">
          <a href="https://twitter.com/share"
            class="twitter-share-button"
            data-url="#{full_url}"
            data-via="takari_io"
            data-lang="en">
          </a>
        </div>
        <div class="google_plus">
          <div class="g-plusone"
            data-href="#{full_url}"
            data-size="medium"
            data-annotation="bubble">
          </div>
        </div>
      </div> 
      HTML
    end
  end
end

Liquid::Template.register_filter Jekyll::ShareButtonsFilter
