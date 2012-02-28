require 'release_helper'
require 'meta_appliance_helper'
require 'toc'
require 'jira'
require 'gsub'

require 'release_sizes'
require 'rss_widget'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new('/blog')
  extension Awestruct::Extensions::Paginator.new(:posts, '/blog/index', :per_page => 5)
  extension Awestruct::Extensions::Indexifier.new
  extension Awestruct::Extensions::Atomizer.new(:posts, '/blog.atom')
  extension Awestruct::Extensions::IntenseDebate.new
  extension ReleaseSizes.new
  extension TOC.new(:levels => 3)

  extension Awestruct::Extensions::Tagger.new(:posts,
                                              '/blog/index',
                                              '/blog/tags',
                                              :per_page=>5)

  extension Awestruct::Extensions::TagCloud.new(:posts,
                                                '/blog/tags/index.html',
                                                :layout=>'one-column')

  transformer Awestruct::Extensions::Gsub.new(
    %r(<!--\s*lang:\s*(\S*?)\s*-->\s*<pre><code>(.*?)</code></pre>),
    '<pre class="brush: \1">\2</pre>')
 
  helper Awestruct::Extensions::GoogleAnalytics
  helper Awestruct::Extensions::Partial
  helper ReleaseHelper
  helper MetaApplianceHelper
  helper RssWidget
  extension Jira.new(:ids => ['BGBUILD'], :layout => 'blog', :since => Time.utc(2011, 12, 12))
end
