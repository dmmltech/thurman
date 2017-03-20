module ApplicationHelper

	def gravatar_url(email, size)
		gravatar = Digest::MD5::hexdigest(email).downcase
		return "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
	end

	def auto_suggestions(*)
		seeds = Tagging.includes(:tag).uniq.pluck(:name)
		return seeds
	end

	def homepage_path
		if user_signed_in?
			return user_url(current_user)
		else
			return root_url
		end
	end

	def site_author(page_author = '')
		base_author = "Team Thurman"
		if page_author.empty?
		  base_author
		else
		  "#{page_author} | #{base_author}"
		end
	end

	def site_title(page_title = '')
		base_title = "Thurman"
		if page_title.empty?
		  base_title
		else
		  "#{page_title} | #{base_title}"
		end
	end

	def site_tagline(page_tagline = '')
		base_tagline = "The Developer's Publishing Platform"
		if page_tagline.empty?
			base_tagline
		else
			"#{page_tagline} | #{base_tagline}"
		end
	end


	def default_description(page_description = '')
		base_description = "Thurman is a article publishing platform named after Wallace Henry Thurman"
		if page_description.empty?
		  base_description
		else
		  "#{page_description} "
		end
	end

	def default_url(page_url = '')
		base_url = request.base_url
		if page_url.empty?
		  base_url
		else
		  "#{page_url} "
		end
	end


	def default_image(page_image = '')
		base_image = asset_url('logo.jpg') 
		if page_image.empty?
		  base_image
		else
		  "#{page_image} "
		end
	end

	def default_twitter(page_twitter = '')
		base_twitter = 'http://twitter.com/' 
		if page_twitter.empty?
		  base_twitter
		else
		  "#{page_twitter} "
		end
	end

	def default_facebook(page_facebook = '')
		base_facebook = 'http://facebook.com/' 
		if page_facebook.empty?
		  base_facebook
		else
		  "#{page_facebook} "
		end
	end

	def default_linkedin(page_linkedin = '')
		base_linkedin = 'http://linkedin.com/' 
		if page_linkedin.empty?
		  base_linkedin
		else
		  "#{page_linkedin} "
		end
	end

	def default_instagram(page_instagram = '')
		base_instagram = 'http://instagram.com/' 
		if page_instagram.empty?
		  base_instagram
		else
		  "#{page_instagram} "
		end
	end

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end

	def current_path
		request.env['PATH_INFO']
	end

	def css_class_active_for link_path
		link_path == current_path ? "active" : "inactive"
	end

end
