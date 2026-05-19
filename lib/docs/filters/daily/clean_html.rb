module Docs
  class Daily
    class CleanHtmlFilter < Filter
      def call
        css(
           '#fixed-sidebar',
           '.breadcrumb',
           '.docs-breadcrumbs'
        ).remove
        # Prevent inline SVGs from becoming huge
        css('svg').each do |node|
          # Explicitly set boundaries so DevDocs' default CSS doesn't blow them up
          node['style'] = "max-width: 1.5rem; max-height: 1.5rem; display: inline-block; vertical-align: middle;"
        end

        doc
      end
    end
  end
end
