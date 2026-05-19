module Docs
  class Daily
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('h1')&.text&.strip || slug
      end

      def get_type
        if slug.start_with?('rest-api/')
          'REST API'
        elsif slug.start_with?('daily-js/')
          'Daily JS'
        elsif slug.start_with?('daily-react/')
          'Daily React'
        elsif slug.start_with?('rn-daily-js/')
          'React Native'
        elsif slug.start_with?('android/')
          'Android SDK'
        elsif slug.start_with?('ios/')
          'iOS SDK'
        elsif slug.start_with?('flutter/')
          'Flutter SDK'
        elsif slug.start_with?('daily-python/')
          'Python SDK'
        elsif slug.start_with?('vcs/')
          'Video Component System'
        else
          'Daily Reference Docs'
        end
      end
    end
  end
end
#module Docs
#  class Daily
#    class EntriesFilter < Docs::EntriesFilter
#      def get_name
#        puts "URL=#{current_url}"
#        puts "SLUG=#{slug.inspect}"
#
#        name = at_css('h1')&.text&.strip || slug
#
#        puts "NAME=#{name.inspect}"
#
#        name
#      end
#
#      def get_type
#        puts "TYPE_SLUG=#{slug.inspect}"
#
#        'Daily'
#      end
#    end
#  end
#end
