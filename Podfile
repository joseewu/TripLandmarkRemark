platform :ios, '10.0'
use_frameworks!
def main_sources
#define your pod resources
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'FBSDKLoginKit'
end
def test_sources
#define your pod resources for unit test
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'FBSDKLoginKit'
end
target 'Trip Landmark Remark' do
main_sources

  target 'Trip Landmark RemarkTests' do
    inherit! :search_paths
    test_sources
  end

  target 'Trip Landmark RemarkUITests' do
    inherit! :search_paths
    test_sources
  end

end
