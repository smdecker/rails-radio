class Show < ApplicationRecord
	has_many :episodes

	extend FriendlyId
  friendly_id :title, use: :slugged
end
