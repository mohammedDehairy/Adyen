# Adyen

## Archicture:
* MVVM is used for the Venus exploration scene, with PlacesViewModel, PlaceStore as Model, and PlacesViewController as the view.
* If there were other scenes in the app, I would have used a "Coordinator" object to be responsible for the navigation between scenes, and it would be responsible only for creating the first viewModel (in this case the PlacesViewModel), and then when navigating the viewModel in charge at that moment create the next viewModel and call the coordinator to do the navigation.
* The app in general makes heavy use of protocol oriented architecture, which made it so much easier to test almost every component in the app (you'll notice the code coverage is around 80%).
## Technical Choises
* You'll notice there are no UI end-to-end tests, UI viewController's are tested in the unit test target instead, taking advantage of the fact that the app code and unit test code live in the same process, so its easier to mock the view's/viewController's dependencies namely the viewModel, and test different scenarios in a more controlled manner.
* The app layouting is done with very simple one-line frame calculations instead of Autolayout, because layouting was very simple to use Autolayout IMO.
* Error handling is merely showing some human friendly message to the user and degrading the user experience and assertionFailure() calles in develop builds, but in a real production app i would send any critical unexpected errors to some kind of monitoring platform like NewRelic, Crashlytics, or simply Google Analytics, and this monitoring platform would be nice to have some kind of alerting system for Critical errors that happen in production.
* Choose not do much commenting of the code to save time spent on the assignment and in the hope that the code is simple enough to understand with no convoluted logic that needs documenting, but this is definitly room for improvement and choosing not to do much commenting was just a matter of trade off.
* iOS 12.0 is used as the minimum deployment target since iOS 12 adoption rate is 85% on all devices and only 9% for iOS 11 and 6% for the rest according to Apple.
https://developer.apple.com/support/app-store/
## App UX choices
* In the assignment pdf it mentioned to give the user the ability to adjust the search radius and location, so i couldn't think of a better UX than a map view and the venus are loaded according to the map visible region, so the user control the search center and region by simply scrolling/pinching the map view.
* It would have been better to use a combination a map view to control the search region and a list to show the current venus, and maybe also the ability of the user to bookmark some venus, and maybe to navigate to them using in-app functionality or other apps like apple/google maps.
## Dependencies 
* NotificationBannerSwift Pod is used to show a nice user friendly notification banner when for example there is no internet connection or some unexpected server error.
