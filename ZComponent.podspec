#
# Be sure to run `pod lib lint ZComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ZComponent"
  s.version          = "0.4.0"
  s.summary          = "ZComponent是一个工具库, 封装好了定义的宏,ViewController基类,和view 扩展"


  s.description      = <<-DESC
                        ZComponent是一个工具库, 封装好了定义的宏,ViewController基类,和view 扩展, 使用该库可以减少开发前期的准备.
                       DESC

  s.homepage         = "https://github.com/zhuayi/ZComponent"
  s.license          = 'MIT'
  s.author           = { "zhuayi" => "2179942@qq.com" }
  s.source           = { :git => "https://github.com/zhuayi/ZComponent.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

#  s.source_files = 'Pod/Classes/**/*'
#  s.resource_bundles = {
#    'ZComponent' => ['Pod/Assets/*.png']
#  }

#################################### ZMacro #####################################################

s.subspec 'ZMacro' do | zmacro |
zmacro.source_files = 'Pod/Classes/ZMacro/**/*'
zmacro.public_header_files = 'Pod/Classes/ZMacro/**/*.h'
end

################################################################################################


#################################### Category ##################################################

s.subspec 'Category' do | category |
category.source_files = 'Pod/Classes/Category/**/*'
category.public_header_files = 'Pod/Classes/Category/**/*.h'
end

################################################################################################


#################################### ZBaseViewController ##################################################

s.subspec 'ZBaseViewController' do | zbaseViewController |
zbaseViewController.source_files = 'Pod/Classes/ZBaseViewController/**/*'
zbaseViewController.public_header_files = 'Pod/Classes/ZBaseViewController/**/*.h'
zbaseViewController.dependency 'ZComponent/ZMacro'
end

################################################################################################


end
