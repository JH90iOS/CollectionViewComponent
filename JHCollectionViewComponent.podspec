#
#  Be sure to run `pod spec lint JHCollectionViewComponent.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "JHCollectionViewComponent"
  spec.version      = "0.0.1"
  spec.summary      = "UICollectionView组件化库"

  spec.description  = <<-DESC
                      利用React-Native和Weex中组件的思想，将UICollectionView布局的页面进行组件化，解决复杂页面的扩展性和可维护性问题
                   DESC

  spec.homepage     = "https://github.com/JH90iOS/CollectionViewComponent"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = "jinhua"

  spec.social_media_url   = "https://github.com/JH90iOS"

  spec.platform     = :ios

  spec.source       = { :git => "https://github.com/JH90iOS/CollectionViewComponent.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes"
  spec.public_header_files = "Classes/*.h"

  spec.frameworks = "Foundation", "UIKit"

  spec.dependency "IGListKit"
end
