class Competition < ApplicationRecord

	has_many :matches, dependent: :destroy
	validates :nome, presence: true

	def ordenacao_asc
		'ASC'
	end
	def ordenacao_desc
		'DESC'
	end


end
