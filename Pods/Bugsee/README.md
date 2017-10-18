# Bugsee


Bugsee is a mobile SDK that adds crucial information to your bug and crash reports. Bugsee reports include video of user actions, network traffic, console logs and many other important traces from your app. Now you know what exactly led to the unexpected behavior.

Sign up for a service at [https://www.bugsee.com](https://www.bugsee.com). 

## Installation

```bash
pod 'Bugsee'
```

Run the following commands to install the Pod:

```bash
pod install
pod update Bugsee # This is important, install command does not guarantee you will get latest version
```

Import Bugsee header file in your app delegate or the file you intend to initialize the framework from

**Objective-C**
```objective-c
@import Bugsee;
```

**Swift**
```swift
import Bugsee
```

## Initialization

Locate your app delegate and initialize the framework in your *application:didFinishLaunchingWithOptions* method:

**Objective-C**
```objective-c
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ...other initialization code

    [Bugsee launchWithToken:@"your_app_token"];

    return YES;
}
```

**Swift**
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...other initialization code

    Bugsee.launch(token:"your_app_token")

    return true
}
```

## Configuration

### Launching with options

Bugsee behavior is very customizable, if default configuration is not satisfying your needs you can launch the SDK with additional parameters passed as a dictionary.

**Objective-C**
```objective-c
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ...other initialization code

    NSDictionary * options = @{
           BugseeMaxRecordingTimeKey   : @60,  
           BugseeShakeToReportKey      : BugseeTrue,
           BugseeScreenshotToReportKey : BugseeTrue,
           BugseeCrashReportKey        : BugseeTrue
    };

    [Bugsee launchWithToken:@"your_app_token" andOptions:options];

    return YES;
}
```

**Swift**
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // ...other initialization code

    let options : [String: Any] =
        [ BugseeMaxRecordingTimeKey   : 60,
          BugseeShakeToReportKey      : false,
          BugseeScreenshotToReportKey : true,
          BugseeCrashReportKey        : true ]

    Bugsee.launch(token: "your_app_token", options: options)

    return true
}
```

### Available Options
|Key|Default value|Notes
|---|---|---|
|BugseeMaxRecordingTimeKey|@60|Maximum recording duration|
|BugseeShakeToReportKey|NO|Shake gesture to trigger report|
|BugseeScreenshotToReportKey|YES|Screenshot key to trigger report|
|BugseeCrashReportKey|YES|Catch and report application crashes (\*\*)|

\* Frame rate depends on a lot of factors including the overall load of the system, we are doing our best not to interfere with the performance of the application hence the frame rate of the video can not be guaranteed, this only sets the upper boundary (i.e its not going to be higher than 15 fps)

\*\* IOS allows only one crash detector to be active at a time, if you insist on using an alternative solution for handling crashes, you might want to use this option and disable Bugsee from taking over.

### Setting reporters email

When you already have your users identified within your app, you might want to add their email automatically attached to the bug report. Bugsee provides API's for setting, getting and clearing the email.

**Objective-C**
```objective-c
    // setting email
    [Bugsee setEmail:@"name@example.com"]

    // getting email, nil will be returned if email was never set
    NSString *email = [Bugsee getEmail];

    // clearing email
    [Bugsee clearEmail];
```

**Swift**
```swift
    // setting email
    Bugsee.setEmail("name@example.com")

    // getting email, nil will be returned if email was never set
    var email = Bugsee.getEmail();

    // clearing email
    Bugsee.clearEmail();
```
## Manual invocation

### Report view

In addition to detection of shake gesture or screenshot issue report view can be triggered programmatically:

**Objective-C**
```objective-c
[Bugsee showReportController];

// or pre-fill some fields, user will be able to modify them
[Bugsee showReportControllerWithSummary:@"Some problem"
          description:@""
          severity:BugseeSeverityMedium];
```

**Swift**
```swift
// To stop video recording use   
Bugsee.showReportController()

// or pre-fill some fields, user will be able to modify them
Bugsee.showReportController(summary: "Some problem",
    description: "",
    severity: BugseeSeverityMedium)
```

### Issue create

You can build your own custom UI for collecting summary, description and severity from a user and use the following call to send it to Bugsee
to upload.
Note: You should not use it for reporting errors automatically from within code, use [Non-fatal errors](#non-fatal-errors) for this instead.

**Objective-C**
```objective-c
[Bugsee uploadWithSummary:@"Upload from code"
        description:@"Some description"
        severity:BugseeSeverityMedium];
```

**Swift**
```swift
Bugsee.upload(summary: "Upload from code",
        description: "Some description",
        severity: BugseeSeverityMedium)
```

### Non-fatal errors

It is possible to report non-fatal errors from code. These reports will get combined similar to crashes,
and you will be provided with statistics and a break down by unique devices, IOS versions, etc.

**Objective-C**
```objective-c
[Bugsee logError:[NSError errorWithDomain:@"com.example.errors.ServerIsDown"
							code:10234 userInfo:@{
								@"key1":@"value1",
								@"key2": @"value2"}]];
```

**Swift**
```swift
Bugsee.logError(NSError(domain: "com.example.errors.ServerIsDown",
						code: 10234,
						userInfo: ["key1": "value1", "key2": "value2"]))
```


### Asserts

You can also let Bugsee validate asserts and auto create isssues and upload them once the assert fails.

```objective-c
BUGSEE_ASSERT(balance > 0, @"Balance is wrong")
```


## User events

User events can be attached to the report, events are identified by a string and can have an optional dictionary of parameters that will be stored and passed along with the report.

**Objective-C**
```objective-c
	// Without any additional parameters
    [Bugsee registerEvent:@"payment_processed"];

    // ...our with additional custom parameters
    [Bugsee registerEvent:@"payment_processed"
               withParams:@{
                	@"amount": @125,
                	@"currency": 'USD'
    	         }];
```

**Swift**
```swift
    // Without any additional parameters
    Bugsee.event("payment_processed")

    // ...our with additional custom parameters
    Bugsee.event("payment_processed",
      params:["amount": 125, "currency": "USD"])
```

## User traces

User traces can be attached to the report, this may be useful when you want to trace how a specific variable or state changes over time right before the problem happens.

There are two ways available to trace a property, manually setting a value or automatically setting an observer on a property of an object.

**Objective-C**
```objective-c
    // Manually set value of @15 to property named "credit_balance"
    // any time it changes
    [Bugsee traceKey:@"credit_balance" withVaue:@15];  
```

**Swift**
```swift
    // Manually set value of @15 to property named "credit_balance"
    // any time it changes
    Bugsee.trace(key:"credit_balance", value:15)
```


Bugsee can be further customized and allows adding your own traces, events, logs etc., for a complete SDK documentation covering additional options and API's visit [https://docs.bugsee.com/](https://docs.bugsee.com/)
