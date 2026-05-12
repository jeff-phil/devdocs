module Docs
  class Sqlalchemy
    class CleanHtmlFilter < Filter
      def call
        css(
           '#fixed-sidebar',
           '.headerlink',
           '.sphinxsidebar',
           '.related'
        ).remove
        doc
      end
    end
  end
end
