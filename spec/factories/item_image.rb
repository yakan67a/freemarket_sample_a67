FactoryBot.define do
  
  factory :item_image do
    image_URL { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
  end
end