#
# Be sure to run `pod lib lint OTPInputView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OTPInputView'
  s.version          = '0.1.0'
  s.summary          = 'OTP InputView is a simple, Fully customisable OTP code verification view in Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    'OTP-InputView is an awesome pod aimed to make your life easier when dealing with OTP Verification i.e Very common feature in Apps nowadays.'
                       DESC

  s.homepage         = 'https://github.com/abhishek-001/OTPInputView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'abhishek-001' => 'work.abhirathi@gmail.com' }
  s.source           = { :git => 'https://github.com/abhishek-001/OTPInputView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/abhirathi007'

  s.ios.deployment_target = '11.0'

  s.source_files = 'OTPInputView/Classes/**/*'
  s.frameworks = 'UIKit'

  # s.resource_bundles = {
  #   'OTPInputView' => ['OTPInputView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
