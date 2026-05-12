module Docs
  class Pydantic
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        at_css('h1')&.content&.strip || 'Pydantic Validation'
      end

      def get_type
        case slug
        when /\Aget-started/ then 'Getting Started'
        when /\Aconcepts/    then 'Concepts'
        when /\Aapi/         then 'API'
        when /\Aerrors/      then 'Errors'
        when /\Ainternals/   then 'Internals'
        when /\Aintegrations/ then 'Integrations'
        when /\Aexamples/    then 'Examples'
        else 'Pydantic'
        end
      end

      def additional_entries
        entries = []
        page_name = get_name

        css('h2, h3').each do |node|
          next unless node['id']
          title = node.content.strip.gsub(/[¶#]\z/, '')
          entries << ["#{page_name} - #{title}", "##{node['id']}", get_type]
        end

        entries
      end
    end
  end
end
