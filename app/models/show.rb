class Show < ApplicationRecord
	has_many :episodes

	has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	extend FriendlyId
  friendly_id :title, use: :slugged

	def should_generate_new_friendly_id?
	 title_changed?
	end
end
