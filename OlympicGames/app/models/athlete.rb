class Athlete < ApplicationRecord

	has_many :matches, dependent: :destroy
	validates :nome, presence: true

end
