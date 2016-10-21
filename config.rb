###
# Page options, layouts, aliases and proxies
###

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, tables: true, smartypants: true, html: true

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def markdown(&block)
    raise ArgumentError, "Missing block" unless block_given?
    content = capture_html(&block)
    concat Tilt['markdown'].new { content }.render
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

after_build do |builder|
  `cp CNAME build/CNAME`
end