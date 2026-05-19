export SDKROOT=$(xcrun --show-sdk-path)
mkdir -p lib/docs/filters/pydantic
# add files for filters and scraper

gem install bundler
bundle install

# did have to do this when bundle install failed failed then re-run bundle install:
# bundle config build.eventmachine "--with-cflags=-Wno-error=implicit-function-declaration -Wno-error=nullability-completeness"

# if change Gemfile, may need to do this:
# bundle update

bundle exec thor docs:generate pydantic --verbose
bundle exec thor docs:generate sqlalchemy --verbose
bundle exec thor docs:generate fastapi --verbose
bundle exec thor docs:generate sveltekit --verbose
bundle exec thor docs:generate daily --verbose

# to view files:
bundle exec rackup -p 9292
# and connect to http://localhost:9292

cp -R public/docs/pydantic /Users/jeffrey/.pi/agent/.local/share/dedoc/docsets/
cp -R public/docs/sqlalchemy /Users/jeffrey/.pi/agent/.local/share/dedoc/docsets/
cp -R public/docs/fastapi /Users/jeffrey/.pi/agent/.local/share/dedoc/docsets/
cp -R public/docs/sveltekit /Users/jeffrey/.pi/agent/.local/share/dedoc/docsets/
cp -R public/docs/daily /Users/jeffrey/.pi/agent/.local/share/dedoc/docsets/
cp public/docs/docs.json /Users/jeffrey/.pi/agent/.local/share/dedoc/docs.json.extras
