# Example Stripe Basic

## Description

- Simple flow for selection of means of payment, banks and fees.

- Alamofire: Alamofire is a Swift library for making HTTP requests. It allows us to perform common tasks such as GET, POST, PUT and DELETE requests with ease and elegance.

- RealmSwift: RealmSwift is a fast and secure object database that allows for efficient storage and retrieval of objects. The version used in this project is 4.4.1.

- ObjectMapper: ObjectMapper is a library for facilitating object transformation in Swift. It allows us to convert objects into a readable and writable format, such as JSON.

- SDWebImage: SDWebImage is a library for asynchronously loading images from the web. It allows us to download images in the background and cache them for a better user experience. The version used in this project is 4.2.2.

- IGListKit: IGListKit is a library for creating lists and collections easily and efficiently in iOS. The library is marked as "TODO: Refactor to native", meaning that in the near future it is intended to be replaced with native iOS functions.

- SnapKit: SnapKit is a library for creating constraints and making autolayout in code easier. The library is marked as "TODO: Use for replace StoryBoard", meaning that in the near future it is intended to replace the use of Storyboards with SnapKit.

- SwiftyBeaver: SwiftyBeaver is a library for keeping a log of events in an iOS application. It allows us to log events and messages in real-time for better debugging and tracking of issues.

## Requirements
- iOS 14.0+
- Xcode 14.0+

## Installation
CocoaPods is available through CocoaPods. To install it, simply add the following line to your Podfile:

``` objective-c
  pod 'Alamofire'
  pod 'RealmSwift', '~> 4.4.1'
  pod 'ObjectMapper'
  
  #images
  pod 'SDWebImage', '~> 4.2.2'
  
  #UTils
  pod 'IGListKit'
  pod 'SnapKit'
  
  #Logs
  pod 'SwiftyBeaver'
```
## Usage
Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Upcoming features 
- Refactor to CoreData 
- Refactor to MVI/MVVM
- Refactor to Api Robust
- Refactor to Codable 
- Refactor to SwiftUI
