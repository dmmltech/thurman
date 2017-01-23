base_url = "http://#{request.host_with_port}/"

xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9', 'xmlns:image' => 'http://www.google.com/schemas/sitemap-image/1.1', 'xmlns:video' => 'http://www.google.com/schemas/sitemap-video/1.1' do

  @pages.each do |article|
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end

  @pages.each do |page|
    xml.url do
      xml.loc page_url(page)
      xml.lastmod page.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end

  @categories.each do |category|
    xml.url do
      xml.loc category_url(category)
      xml.lastmod category.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end

  @tags.each do |tag|
    xml.url do
      xml.loc tag_url(tag)
      xml.lastmod tag.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end


end