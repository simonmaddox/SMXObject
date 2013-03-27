Pod::Spec.new do |s|
  s.name         = "SMXObject"
  s.version      = "0.0.1"
  s.summary      = "NSObject subclass for doing interesting things."
  s.homepage     = "https://github.com/simonmaddox/SMXObject"
  s.license      = 'MIT'
  s.author       = { "Simon Maddox" => "simon@simonmaddox.com" }
  s.source       = { :git => "https://github.com/simonmaddox/SMXObject.git", :commit => "dc64871792e0beaefc09b9d28e9bdf24d7287490" }
  s.platform     = :ios, '5.0'
  s.source_files = 'SMXObject/SMXObject.{h,m}'
end
