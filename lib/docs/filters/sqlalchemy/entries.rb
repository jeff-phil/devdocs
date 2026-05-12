module Docs
  class Sqlalchemy
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('h1')&.text&.strip
      end

      def get_type
        if slug.start_with?('orm/')
          'ORM'
        elsif slug.start_with?('core/')
          'Core'
        elsif slug.start_with?('dialects/')
          'Dialects'
        else
          'SQLAlchemy'
        end
      end
    end
  end
end
