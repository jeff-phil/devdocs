module Docs
  class Pydantic
    class CleanHtmlFilter < Filter
      def call
        # Remove MkDocs Material UI artifacts inside the article container
        css('.md-sidebar').remove
        css('a.md-content__button').remove # "Edit on GitHub" buttons
        css('.headerlink').remove          # Anchor link icons
        css('.md-source-file').remove      # Source file tags

        # Prevent inline SVGs from becoming huge
        css('svg').each do |node|
          # Explicitly set boundaries so DevDocs' default CSS doesn't blow them up
          node['style'] = "max-width: 1.5rem; max-height: 1.5rem; display: inline-block; vertical-align: middle;"
        end
        
        # Handle <img> tags without sizes
        css('img').each do |node|
          # Skip if the image already has hardcoded HTML width/height attributes
          next if node['width'] || node['height']

          # If it's a MkDocs Twemoji (inline emoji), keep it inline and text-sized
          if node['class'] && node['class'].include?('twemoji')
            node['style'] = "width: 1.25em; height: 1.25em; vertical-align: -0.25em;"
          
          # For all other images, ensure they never break the reading container
          # but otherwise let them maintain their natural aspect ratio.
          else
            existing_style = node['style'] || ""
            node['style'] = "#{existing_style} max-width: 100%; height: auto;".strip
          end
        end

        doc
      end
    end
  end
end
