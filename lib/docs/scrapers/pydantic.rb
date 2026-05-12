module Docs
  class Pydantic < UrlScraper
    self.name = 'Pydantic'
    self.type = 'simple'
    self.release = 'latest'

    self.base_url = 'https://pydantic.dev/docs/validation/latest/'
    self.root_path = 'get-started/'

    options[:container] = '.main-pane'
    options[:attribution] = 'The Pydantic Maintainers'

    html_filters.push 'pydantic/entries', 'pydantic/clean_html'
  end
end
