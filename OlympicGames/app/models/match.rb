class Match < ApplicationRecord
	belongs_to :competition
	belongs_to :athlete

	validates :competicao, presence: true
	validates :atleta, presence: true
	validates :value, presence: true
	validates :unidade, presence: true, length:{ maximum:1 }

end