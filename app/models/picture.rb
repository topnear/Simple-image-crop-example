class Picture < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	mount_uploader :image,  ImageUploader

	ALLOW_IMAGE_TYPE = [ "image/jpeg", "image/png", "image/gif" ]
	MAX_FILE_SIZE = 1.0
	
	attr_accessor :crop_x, :crop_y

	validate :validate_image_geometry, if: :is_image?
	
	belongs_to :advertisement

	def set_unique_key
		self.unique_key = genetate_unique_key
	end

	def to_jq_upload
		[{ url: edit_ad_pic_path(id) }].to_json
	end

	def validate_image_geometry
		errors.add(:geometry_error, "Your image should be 800x400 px minimum!") unless is_correct_geometry_image?
	end

	def build_error_messages
		error_message = errors.messages.dup
		error_message.each do |k,v|
			error_message[k] = v[0]
		end
		[error_message].to_json
	end

	def not_processed?
		!is_processed
	end

	def is_valid_crop_x?
		!crop_x.nil?
	end

	def crop
		image.recreate_versions!
	end

	private

	def is_image?
		ALLOW_IMAGE_TYPE.include? image.content_type 
	end

	def genetate_unique_key
		loop  do
			key = SecureRandom.urlsafe_base64
			break key unless self.class.exists?(unique_key: key)	
		end
	end

	def is_correct_geometry_image?
		tmp_image = MiniMagick::Image.open(image.path)
		puts "#{tmp_image[:width] } #{tmp_image[:height] }"
		tmp_image[:width] > 800 && tmp_image[:height] > 400
	end

end
