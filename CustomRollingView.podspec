#
#  Be sure to run `pod spec lint CustomRollingView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "CustomRollingView"
  s.version      = "0.0.1"
  s.summary      = "An CustomRollingView."
  s.description  = <<-DESC
                  This is An CustomRollingView
                   DESC
  s.homepage     = "https://github.com/zzzlll444/AutoRollingView"
  s.license      = "MIT"
  s.author       = { "bo" => "2697768525@qq.com" }
  s.platform     = :ios,"7.0"
  s.source       = { :git => "https://github.com/zzzlll444/AutoRollingView.git", :tag => "0.0.1" }
  s.source_files  = "CustomRollingView", "CustomRollingView/**/*.{h,m}"
  s.requires_arc = true
end
