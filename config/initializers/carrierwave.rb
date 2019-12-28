# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# 開発か本番かで保存先を分岐
CarrierWave.configure do |config|
  if Rails.env.production? 
  # 本番環境の場合
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: 'ap-northeast-1'
    }
    config.fog_directory  = '64h-merucari' #S3のバケット名
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/64h-merucari'
  else
  # 開発環境のpublic/uploades下に保存
    config.storage :file 
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end  
end