class Tag < ActiveRecord::Base
	is_impressionable :counter_cache => true, :unique => [:session_hash]
	self.per_page = 10
	
	has_many :taggings, :dependent => :destroy
	has_many :articles, through: :taggings

	extend FriendlyId
    friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

    def slug_candidates
		slugger = rand(1..100)
		[
			[:name],
			[:name, slugger]
		]
	end

	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end

	def to_s
		name
	end

end
