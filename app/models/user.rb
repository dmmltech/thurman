class User < ActiveRecord::Base
  rolify
  has_many :articles
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
