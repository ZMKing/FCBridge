#
# Be sure to run `pod lib lint FCBridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
  #开源库的名字
  s.name             = 'FCBridge'
  #开源库当期版本
  s.version          = '0.0.6'
  #开源库概述（打开GitHub能看到的描述）
  s.summary          = 'A short description of FCBridge.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
#开源库描述 （这个描述会被用来生成开源库的标签和提高被搜到，必需写在中间一行，只要在中间一行，不需要考虑缩进）
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  #可以是开源库的GitHub地址，也可以是你自己的网址等
  s.homepage         = 'https://github.com/ZMKing/FCBridge'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  
  #我这里是参靠网上的一种写法，不会报警告，也可以直接 s.license = 'MIT'
  s.license          = 'MIT'
  #开源库作者
  s.author           = { '' => '' }
  s.source           = { :git => 'https://github.com/ZMKing/FCBridge.git', :tag => s.version }

  #开源库支持的平台（暂时没考虑tvOS、OSX等）
  s.platform     = :ios
  
  s.ios.deployment_target = '8.0'

  s.source_files = "FCBridge/**/*.{h,m}"
#  s.resource = 'FCBridge/*.bundle'
  
   s.resource_bundles = {
     'FCBridge' => ['FCBridge/Classes/*.bundle']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  # 是否支持arc
  s.requires_arc = true
end
