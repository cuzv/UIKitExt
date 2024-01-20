Pod::Spec.new do |spec|
  spec.name             = "UIKitExt"
  spec.version          = "1.0.0"
  spec.summary          = "Useful functionally extensions for Apple's UIKit framework."
  spec.homepage         = "https://github.com/cuzv/UIKitExt"
  spec.license          = "MIT"
  spec.author           = { "Shaw" => "cuzval@gmail.com" }
  spec.platform         = :ios, "12.0"
  spec.source           = { :git => "https://github.com/cuzv/UIKitExt.git", :tag => "#{spec.version}" }
  spec.source_files     = "Sources/**/*.swift"
  spec.requires_arc     = true
  spec.swift_versions   = '5'
end
