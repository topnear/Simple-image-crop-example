class Advertisement < ActiveRecord::Base
	attr_accessor :picture_key
	validates :title, :description, :picture, presence: true
	validates :description, length: {maximum: 400}
	validates :title, length: {maximum: 20}
	has_one :picture, dependent: :destroy, foreign_key: "ad_id"	
	after_save :set_picture_state

	private

	def set_picture_state
		picture.is_processed = true
		picture.save
	end

end
