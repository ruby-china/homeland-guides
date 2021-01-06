###
# Page options, layouts, aliases and proxies
###

activate :i18n, langs: %i[en zh-CN], mount_at_root: :en

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true,
               gh_blockcode: true,
               tables: true,
               # 避免 Ruby 的变量 foo_bar_dar 被认为下划线
               no_intra_emphasis: true,
               underline: true,
               disable_indented_code_blocks: true,
               autolink: true,
               html: true

# Per-page layout changes:
#
# With no layout
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

page "/docs/*", layout: "docs"

configure :development do
  activate :livereload
end

activate :directory_indexes

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def markdown(&block)
    raise ArgumentError, "Missing block" unless block_given?

    content = capture_html(&block)
    puts content
    concat Tilt["markdown"].new { content }.render
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

after_build do |_builder|
  `cp CNAME build/CNAME`
end
