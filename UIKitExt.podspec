Pod::Spec.new do |s|
  s.name         = "UIKitExt"
  s.version      = "1.0.0"
  s.summary      = "Extension and Enhancement of UIKit"

  s.homepage     = "https://github.com/cuzv/UIKitExt.git"
  s.license      = "MIT"
  s.author       = { "Shaw" => "cuzval@gmail.com" }
  s.platform     = :ios, "11.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/cuzv/SlidingPhoto.git",
:tag => s.version.to_s }
  s.source_files = "Sources/*.{h,swift}"
  s.frameworks   = 'Foundation', 'UIKit'
  s.swift_versions = '5'
end
