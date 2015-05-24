class PicturesController < ApplicationController
	def create
		build_picture
		if @picture.save
			render json: @picture.to_jq_upload 
		else
			render json: @picture.build_error_messages, status: 422
		end					
	end

	def edit
		@picture = Picture.find(params[:id])
		render "edit", layout: false
	end

	def update
		@picture = Picture.find_by_unique_key(params[:picture][:unique_key]) 
		if  check_crop_value && is_picture? && @picture.not_processed?
			@picture.update(picture_params)
			@picture.crop
		else
			flash[:danger] = "you have something errors..."
			render js: "window.location='#{root_url}'"
		end
	end

	private

	def picture_params
		params.require(:picture).permit(:crop_x, :crop_y)
	end

	def build_picture
		@picture = Picture.new
		@picture.set_unique_key
		@picture.image = params[:files][0]
	end

	# Prevent somebody remove them
	def check_crop_value
		params["picture"].keys.include?("crop_x") && params["picture"].keys.include?("crop_y")
	end

end
