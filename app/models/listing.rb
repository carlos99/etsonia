class Listing < ActiveRecord::Base
	
	belongs_to :user
	has_many :orders
	has_many :comments
	belongs_to :category

	has_attached_file :image, :styles => { :medium => "200x", :thumb => "100x100>" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

	validates :name, :description, :price, presence: true
	validates :price, numericality: { greater_than: 0}
	validates_attachment_presence :image

	def self.search(search)
		if search
			where(["lower(name) LIKE ?","%#{search}%"])
		end
		all
	end
end
