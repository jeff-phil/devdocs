module Docs
  class Sqlalchemy < UrlScraper
    self.name = 'SQLAlchemy'
    self.type = 'sphinx'
    self.release = '2.0'

    self.base_url = 'https://docs.sqlalchemy.org/en/20/'

    options[:container] = '#docs-body'

    options[:skip] = %w(
      genindex.html
      py-modindex.html
      search.html
    )

    options[:attribution] = <<-HTML
      &copy; SQLAlchemy authors and contributors
    HTML

    html_filters.push \
      'sqlalchemy/entries',
      'sqlalchemy/clean_html'
  end
end
