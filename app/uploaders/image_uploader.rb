# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :normal, if: :need_crop? do
    process :crop
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  private

  def need_crop?(new_file)
    model.is_valid_crop_x?
  end

  def crop
    manipulate! do |img|
      x = model.crop_x.to_i
      y = model.crop_y.to_i
      size = "800x400"
      offset = "+#{x}+#{y}"
      img.crop("#{size}#{offset}")
      img
    end
  end

end
