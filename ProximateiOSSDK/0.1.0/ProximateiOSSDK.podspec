#
# Be sure to run `pod lib lint ProximateiOSSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'ProximateiOSSDK'
s.version          = '0.1.0'
s.summary          = 'Integrate ProximateiOSSDK with your merchant or bank app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
ProximateiOSSDK is developed to integrate Proximate app features with your own app. Simply register your app's bundle identifier on Proximate's portal, get the api key. Integrate the api key in your app having ProximateiOSSDK pods and you are ready to use Proximate features in your own app.
DESC


s.homepage         = 'https://proximate.ae'
# s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'noorulain.ali' => 'noorulain.ali@avanzasolutions.com' }
s.source           = { :git => 'https://gitlab.com/proximate/sdk.ios.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/ProximateApp'

s.ios.deployment_target = '8.0'

s.source_files     = 'ProximateiOSSDK/ProximateiOSSDK/Classes/**/*.{swift,h,m}'

s.resource_bundles = {
'ProximateiOSSDK' => ['ProximateiOSSDK/ProximateiOSSDK/Assets/*']
}

s.public_header_files = 'ProximateiOSSDK/ProximateiOSSDK/Classes/**/*.h'

s.frameworks = 'UIKit', 'MapKit'
s.dependency 'OCMapper', '~> 2.1'

end
