### Assignment 5 Grade

#### Model
| Points | Description |
| :--- | :--- |
| 1/1 | Reads data from `Data.plist` 
| 1/1 | Manages data in `DataManager` singleton pattern
| 1/1 | Uses `UserDefaults` for persistent storage

#### Custom Protocol
| Points | Description |
| :--- | :--- |
| 1/1 | Declares `PlacesFavoritesDelegate` protocol
| 1/1 | Defines and uses `delegate` variable in `FavoritesViewController`
| 1/1 | Conforms to protocol in `MapsViewController`
| 1/1 | Implements the `favoritePlace()` function that updates labels and zooms to favorite location
| 1/1 | Data is successfully send back

#### Adaptive Layout
| Points | Description |
| :--- | :--- |
| 1/1 | Map is full screen in all orientations and devices
| 1/1 | HUD view labels and stars are positioned using constraints
| 1/1 | HUD view height and width adjust to size class. Description label fills all vertical height.
| 1/1 | Favorites button vertical height is decreased in landscape.

#### MapViewController
| Points | Description |
| :--- | :--- |
| 1/1 | Initial region is Chicago
| 1/1 | Map view is muted style
| 1/1 | HUD has text labels and star button
| 0.5/1 | Star button toggles favorite state and shows selected/unselected fill
| 1/1 | "Favorites" button at bottom of screen modally presents `FavoritesViewController`

#### Map Annotations
| Points | Description |
| :--- | :--- |
| 1/1 | Annotations come from `Data.plist`
| 1/1 | Create `Place` subclass with `name` and `description` properties
| 1/1 | Create `PlaceMarkerView` custom annotation with _styling_
| 1/1 | Implement `didSelect()` method to receive touch and update the HUD view
| 1/1 | Annotations are places on the map in the correction location

#### FavoritesViewController
| Points | Description |
| :--- | :--- |
| 1/1 | Controller is presented modally
| 1/1 | `UITableView` shows the favorite places (no specific requirement on cell design)
| 1/1 | Contains a `UIButton` near the top of the controller to dismiss
| 1/1 | Table cell tap dismisses the view controller and passes data back using the protocol

#### Best Practices 
| Points | Description |
| :--- | :--- |
| 0.5/1 | Follows Swift and iOS best practices
| 1/1 | Uses separate files for new classes (eg. annotations, views, singletons, etc.)

#### Extra Credit
| Points | Description |
| :--- | :--- |
| 0/2 | Add local notification for when a user enters a region

#### Comments

Nice work with functionality 👍🏻 

-1 open a PR
-0.5 compiler warnings

Your favorites button stays selected if the user favorites a location, then navigates to a different one.

All properties start with a lowercase letter in Swift. Check out your IBOutlets. Which need adjusted?
```
@IBOutlet weak var mapView: MKMapView!
@IBOutlet weak var Name: UILabel!
@IBOutlet weak var Description: UILabel!
@IBOutlet weak var starButton: UIButton!
```

Your `FavoritesViewController` could use some organization. Properties and lifecycle methods should be at the top of your class, followed by delegate methods and whatever else.
```
class ViewController: UIViewController {
  var stringProperty: String
  var integerProperty: Int

  override func viewDidLoad() {
    // do stuff
  }

  func someDelegateMethod() {
    // do stuff
  }

  func someHelperMethod() {
    // do stuff
  }
```

#### Grade
27.5/30
