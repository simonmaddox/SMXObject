Pod::Spec.new do |s|
  s.name         = "SMXObject"
  s.version      = "1.2.3"
  s.summary      = "NSObject subclass for doing interesting things."
  s.homepage     = "https://github.com/simonmaddox/SMXObject"
  s.license      = 'MIT'
  s.author       = { "Simon Maddox" => "simon@simonmaddox.com" }
  s.source       = { :git => "https://github.com/simonmaddox/SMXObject.git", :tag => "1.2.3" }
  s.platform     = :ios, '5.0'
  s.source_files = 'SMXObject/SMXObject.{h,m}'
  s.requires_arc = true
end
