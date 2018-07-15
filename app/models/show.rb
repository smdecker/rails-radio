class Show < ApplicationRecord
	has_many :episodes

	has_attached_file :avatar, styles: { large: "400x300#", medium: "300x225#", thumb: "172x120#" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	extend FriendlyId
  friendly_id :title, use: :slugged

	def should_generate_new_friendly_id?
	 title_changed?
	end

	validates_presence_of :title, :description, :location
end
