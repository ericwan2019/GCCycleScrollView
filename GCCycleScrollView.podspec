Pod::Spec.new do |s|
  s.name             = "GCCycleScrollView"
  s.version          = "0.1.0"
  s.summary          = "GCCycleScrollView used for cycle scroll."
  s.description      = "Can be used for cycle scroll of Ads, the images can be local or URL images."

  s.homepage         = "https://github.com/wheying/GCCycleScrollView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "wheying" => "1396855545@qq.com" }
  s.source           = { :git => "https://github.com/wheying/GCCycleScrollView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'GCCycleScrollView' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/GCCycleScrollView.h'
  s.frameworks = 'UIKit'
  #s.dependency 'AFNetworking', '~> 2.3'
end
