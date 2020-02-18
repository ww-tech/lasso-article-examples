<h1 align="center"><img src="docs/images/Lasso_Logo.svg" alt="Lasso" /></h1>

Lasso is an iOS application architecture for building discrete, composable and testable compenents both big and small - from single one-off screens, through complex flows, to high-level application structures.

## Intro article sample code

This repository contains the sample code from the introductory articles:

### [Lasso: Introducing a new architectural framework for iOS](https://github.com/ww-tech/lasso/blob/master/docs/Lasso-Introduction-part1.md)

- [LoginScreen.swift](Sources/Screens/LoginScreen.swift) - the meat of the code from the article.  Contains the complete module definition, store, and view controller.
- [LoginService.swift](Sources/Services/LoginService.swift) - contains the service protocol and concrete conforming type used to log users in.
- [LoginScreenTests.swift](Tests/LoginScreenTests.swift) - contains all unit tests of the login screen.  There's much more in here than was discussed in the article - most notably, there is some dependency injection that takes advantage of the Lasso `@Mockable` property wrapper.

#### Next steps
You may have noticed that when the user taps the login button, there is a delay before the store hears back from the service.  During this delay, it is possible that the user could modify the information in the input fields _or_ tap the login button again.  How would you modify the store to prevent these from happening, and what should change in the view controller to accurately reflect this?  Take a look at the login screen implementation in the main Lasso repository for one approach to solving this issue.

### [Lasso: An introduction to Flows](https://github.com/ww-tech/lasso/blob/master/docs/Lasso-FlowsIntro.md)

  - [TutorialFlow.swift](Sources/Flows/TutorialFlow.swift)
  - [TutorialScreen.swift](Sources/Screens/TutorialScreen.swift)



### Xcode project files

The other files in the Xcode project are all in support of providing a small running app to see Lasso in action.

- AppDelegate.swift - every app needs one.  This one just sets some colors and starts the `AppFlow`

-  [AppFlow.swift](Sources/AppFlow.swift) - simple class for controlling the high-level application flow, showing how to `place` the screens and `start` the flow:  
   - Login -> Tutorial -> Content

- ContentScreen.swift - a placeholder for actual app content.

- The `Extensions` group contains some conveniences to pull as much of the common UIKit drudgery away from the important code.



The included Xcode project:

- requires Xcode 11.3
- compiles with Swift 5.1
- uses Swift package manager, to pull in the dependencies:
  - Lasso
  - WWLayout

