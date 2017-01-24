class Page < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  resourcify
  # before_save :ensure_one_root
  is_impressionable :counter_cache => true, :unique => [:session_hash]
  self.per_page = 10
  
  belongs_to :parent, class_name: "Page"
  has_many :children, class_name: "Page", foreign_key: :parent_id

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

  # def self.root
  #   self.top_level.first
  # end

  # def self.make_root(other)
  #   self.transaction do
  #     old_root = self.root
  #     old_root.update_column(:parent_id, other.id)
  #     other.update_column(:parent_id, nil)
  #   end
  # end

  # def has_parent?
  #   self.parent.present?
  # end

  # def is_root?
  #   self.parent.nil?
  # end

  # def make_root
  #   self.class.make_root(self)
  # end

  # private

  # def ensure_one_root
  #   return false if self == self.class.root
  #   self.parent = self.class.root if parent_id.nil?
  # end

end
