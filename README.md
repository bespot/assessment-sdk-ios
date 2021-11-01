# **Bespot Assessment iOS SDK**
___

BTAssessmentSDK offers indoor location tracking and analytics reporting to 3rd party apps using BLE technology and Machine Learning.

<img width="175" alt="678A162D-06D4-4128-8DD4-739A08DD82D0-removebg-preview" src="https://user-images.githubusercontent.com/15048805/139434128-aaa5c949-803f-4332-a1ae-d409612b8adc.png">

## **Features**
___

- [x] Indoor location (in/out)
- [ ] Indoor area detection
- [ ] Outdoor location
- [ ] Analytics

## **Requirements**
___
- iOS 10.0+
- Xcode 12

## **Installation**
___
### **CocoaPods**
 You can use [CocoaPods](https://cocoapods.org) to install _BTAssessmentSDK_. See steps below:
 1. Add _BTAssessmentSDK_ dependency to your _Podfile_ - using git https git link|version. See sample code hereby:
```
# Minimum supported iOS platform for BTAssessmentSDK
platform :ios, '10.0'
target '[Your app]' do
  # Needed for the project to use frameworks
  user_frameworks!

  # BTAssessmentSDK framework
  pod 'BTAssessmentSDK', :git => 'https://github.com/bespot/assessment-sdk-ios', :tag => '1.0.0'

  # Other Cocoapods libraries/frameworks you may use...

  end
  ```
 2. Run `pod update` for the Cocoapods to download the _BTAssessmentSDK_ dependency.
 3. Run `pod install`
  ## **Usage example**
  ___
  ### **Initialization**
  Do the import:
  ```swift
  import BTAssessmentSDK
```

### **Use the `BTInOutDelegate` delegate to receive InOut updates**
 In your view controller's `viewDidLoad()` method add this:
```swift
BTAssessmentSDK.shared.delegate = self
```
Extend your view controller to implement delegate method:
```swift
extension YourViewController: BTInOutDelegate {

    func didUpdateResult(status: BTStatus) {
        // TODO: Use In-Out status
    }

    func didFailUpdate(error: BTError) {
      // TODO: Inspect possible errors  
    }
}
```
