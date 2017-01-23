class Article < ActiveRecord::Base
	resourcify
	is_impressionable :counter_cache => true
	belongs_to :user
	belongs_to :category
	has_many :comments, as: :commentable
	has_many :taggings
	has_many :tags, through: :taggings

    validates :category, presence: true

    self.per_page = 10

    extend FriendlyId
    friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

    def slug_candidates
		slugger = rand(1..100)
		[
			[:title],
			[:title, slugger]
		]
	end

	def should_generate_new_friendly_id?
		slug.blank? || title_changed?
	end

	def word_count
	   body.split.size
	end

	 def reading_time
	 time =  (word_count / 275.0)
		 if time < 1
		 	return 'Under 1 min read'
		 else
		 	return ((word_count / 275.0).ceil).to_s + ' min read'
		 end
	 end 

	def tag_list
	  tags.join(", ")
	end

	def tag_list=(tags_string)
	  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
	  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
	  self.tags = new_or_found_tags
	end

	def decorated_published_at
		published_at.to_date.to_s(:short)
	end

	def is_draft?
		article.status == 'Draft' ? true : false
	end

	def is_published?
		article.status == 'Publihed' ? true : false
	end

	def is_scheduled?
		self.status == 'Scheduled' ? true : false
	end

	def is_due?
		self.published_at == Date.current 
	end

	def self.scheduled_posts
		where(status: 'Scheduled').where('published_at == ?', Date.current )
	end

	def self.publish_scheduled
		@articles = scheduled_posts
		@articles.each do |article|
			article.status = 'Published'
			article.save
		end
	end

end
