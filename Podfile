# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def sharedPods
    pod 'Alamofire', '~> 4.7.0'
    pod 'SwiftyJSON', '~> 4.0.0'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'RxAlamofire'
    pod 'AlamofireNetworkActivityIndicator', '~> 2.2'
    pod 'Charts'
end

target 'StockPortfolioAppTests' do
    inhibit_all_warnings!
    use_frameworks!
    sharedPods
end

target 'StockPortfolioApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  inhibit_all_warnings!
  use_frameworks!
  sharedPods

end
