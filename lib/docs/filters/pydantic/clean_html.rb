module Docs
  class Pydantic
    class CleanHtmlFilter < Filter
      def call
        # Remove MkDocs Material UI artifacts inside the article container
        css('.md-sidebar').remove
        css('a.md-content__button').remove # "Edit on GitHub" buttons
        css('.headerlink').remove          # Anchor link icons
        css('.md-source-file').remove      # Source file tags
        
        doc
      end
    end
  end
end
