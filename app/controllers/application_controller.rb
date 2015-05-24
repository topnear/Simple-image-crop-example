class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

  	private

  	def  is_picture?
  		!@picture.nil?
  	end
end
