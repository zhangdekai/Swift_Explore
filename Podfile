# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'


post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'  # Or a higher version
      end
    end
  end
end

target 'RXSwift_Explore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RXSwift_Explore
  
  pod 'Alamofire', '~> 5.10.2'
  pod 'RxSwift', '~> 6.9.0'
  pod 'RxCocoa', '~> 6.9.0'
  pod 'SnapKit', '~> 5.7.1'
  
  pod 'DeviceKit', '~> 4.2.1'
#  pod 'CHIPageControl/Jaloro'
  # 数据库使用
#  pod 'WCDB.swift', '~> 1.0.8.2'

  pod 'SwiftMessages' # messages show
  pod 'IHProgressHUD' # loading
  
end
