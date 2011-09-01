class TOC
  def initialize(options = {})
    @options = {
        :magic_word => '((TOC))',
        :levels => 2,
        :generate_header_links => false
    }.merge(options)
  end

  def execute(site)
    site.pages.each do |page|
      toc = ""

      if page.is_a?(Awestruct::MarkdownFile)
        toc = parse_markdown_headers(page.raw_page_content)
      elsif page.is_a?(Awestruct::TextileFile)
        toc = parse_textile_headers(page.raw_page_content)
      end

      page.raw_page_content.gsub!(@options[:magic_word], toc)

    end
  end

  def titleable(title)
    title.strip.gsub(/\s/, "_").gsub(/\W/, "_").gsub(/_+$/, '')
  end

  def parse_markdown_headers(content)
    toc = ""
    content.gsub!(/^(\#{1,6})[ ]*(.+?)[ ]*\#*\n+/) do |match|
      number = $1.size
      name = $2.strip
      header = titleable(name)
      toc << "#{' ' * number.to_i * 2}* [" + name + '](#' + header + ")\n" if number.to_i <= @options[:levels]
      @options[:generate_header_links] ? "h#{number}. <a name=\"#{header}\" href=\"##{header}\">#{name}</a>\n" : "<h#{number} id=\"#{header}\">#{name}</h#{number}>\n"
    end

    toc
  end

  def parse_textile_headers(content)
    toc = ""

    content.gsub!(/^\s*h([1-6])\.\s+(.*)/) do |match|
      number = $1
      name = $2
      header = titleable(name)
      toc << '#' * number.to_i + ' "' + name + '":#' + header + "\n" if number.to_i <= @options[:levels]
      @options[:generate_header_links] ? "h#{number}. <a name=\"#{header}\" href=\"##{header}\">#{name}</a>\n" : "<h#{number} id=\"#{header}\">#{name}</h#{number}>\n"
    end

    toc
  end
end
