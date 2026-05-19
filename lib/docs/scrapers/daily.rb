module Docs
  class Daily < UrlScraper
    self.name = 'Daily'
    self.slug = 'daily'
    self.type = 'simple'
    self.links = {
      home: 'https://daily.co/',
    }
    self.base_url = 'https://docs.daily.co/reference'
    html_filters.push 'daily/entries', 'daily/clean_html'

    options[:root_title] = 'Daily'

    options[:container] = '#main'
    options[:attribution] = 'Daily.co'
    options[:skip] = [
      /pricing/,
      /blog/,
    ]
  end
end
