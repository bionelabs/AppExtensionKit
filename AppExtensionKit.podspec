Pod::Spec.new do |spec|

  spec.name         = "AppExtensionKit"
  spec.version      = "0.0.2"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/onebuffer/AppExtensionKit"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Cao Phuoc Thanh" => "caophuocthanh@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/onebuffer/AppExtensionKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "AppExtensionKit/**/*.{h,m,swift}"

end

