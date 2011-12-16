class Jira
  def initialize(options = {})
    @options = {
        :base_url => 'https://issues.jboss.org',
        :ids => [],
        :layout => 'UNDEFINED',
        :since => nil
    }.merge(options)
  end

  def execute(site)
    return if @options[:ids].empty?

    site.pages.each do |page|
      next if @options[:layout] != page.layout or page.timestamp.nil?

      if page.is_a?(Awestruct::MarkdownFile) and @options[:since].nil? or page.timestamp > @options[:since]
        @options[:ids].each do |id|
          page.raw_page_content.gsub!(/(#{id}-\d+)/, "<a href=\"#{@options[:base_url]}/browse/\\1\">\\1</a>")
        end
      end
    end
  end
end

