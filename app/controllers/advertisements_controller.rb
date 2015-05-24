class AdvertisementsController < ApplicationController
	def index
		@ads = Advertisement.all
	end

	def show
		@ad = Advertisement.find(params[:id])
	end

	def new
		@ad = Advertisement.new
	end

	def create
		@ad = Advertisement.new(ad_params)
		set_ad_picture
		if @ad.save 
			flash[:success] = "sucess post your advertisement!!"
			redirect_to root_url
		else
			build_flash_error_messages
			render :new
		end
	end

	private

	def ad_params
		params.require(:advertisement).permit(:picture_key, :title, :description)
	end

	def set_ad_picture
		@picture = Picture.find_by_unique_key(@ad.picture_key) 
		if is_picture? && @picture.not_processed?
			@ad.picture = @picture 
		else
			@ad.picture = nil
		end
	end

	def build_flash_error_messages
		@ad.errors.messages.each do |k,v|
			flash.now[k] = "#{k} "+v[0]
		end
	end

end
