# config/initializers/carrierwave.rb

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false

  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end

  CarrierWave.configure do |config|  
    config.asset_host = ActionController::Base.asset_host
  end

  end
else
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV["AWS_BUCKET"]
    config.aws_acl    = "public-read"

    config.aws_credentials = {
        access_key_id:     ENV["AWS_ACCESS_KEY"],
        secret_access_key: ENV["AWS_SECRET_KEY"],
        region:            ENV["AWS_REGION"]
    }
  end
end
