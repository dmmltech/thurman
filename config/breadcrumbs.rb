crumb :root do
  link "Home", root_path
end

crumb :articles do
  link "Articles", articles_path
end

crumb :article do |article|
  link article.title, article_path(article)
  parent :articles
end


crumb :pages do
  link "Pages", pages_path
end

crumb :page do |page|
  link page.title, page_path(page)
  parent :pages
end

crumb :tags do
  link "Tags", tags_path
end

crumb :tag do |tag|
  link tag.name, tag_path(tag)
  parent :tags
end

crumb :categories do
  link "Categories", categories_path
end

crumb :category do |category|
  link category.name, category_path(category)
  parent :categories
end



# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).