Pod::Spec.new do |s|
  s.name             = "UIKitExt"
  s.version          = "1.0.1"
  s.summary          = "Useful functionally extensions for Apple's UIKit framework."
  s.homepage         = "https://github.com/cuzv/UIKitExt"
  s.license          = "MIT"
  s.author           = { "Shaw" => "cuzval@gmail.com" }
  
  s.platform         = :ios, "12.0"
  
  s.source           = { :git => "https://github.com/cuzv/UIKitExt.git", :tag => "#{s.version}" }
  s.source_files     = "Sources/**/*.swift"
  s.requires_arc     = true
  s.swift_versions   = '5'

  s.resource_bundles = {
    'UIKitExt' => ['Resources/PrivacyInfo.xcprivacy']
  }
end
