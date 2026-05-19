module Docs
  class Sveltekit < UrlScraper
    self.name = 'SvelteKit'
    self.slug = 'sveltekit'
    self.type = 'simple'
    self.root_path = '/'
    self.links = {
      home: 'https://svelte.dev/',
      code: 'https://github.com/sveltejs/svelte'
    }

    options[:root_title] = 'SvelteKit'

    # https://github.com/sveltejs/svelte/blob/master/LICENSE.md
    options[:attribution] = <<-HTML
      &copy; 2016–2025 Rich Harris and contributors<br>
      Licensed under the MIT License.
    HTML

    self.base_url = 'https://svelte.dev/docs/kit/'
    html_filters.push 'sveltekit/entries', 'sveltekit/clean_html'

    self.release = '2.59.1'
  end
end
