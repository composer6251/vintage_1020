
### ***************BEST PRACTICES****************

#### RED FLAGS: Loops to build out widgets(Tiles, Lists...etc)
*Option 1* *Preferred*
Separate widget
- Only rebuilds widget that changes. i.e. Favorite Icon from option 2
- Makes testing easier

*Option 2*
Helper method
- Causes entire widget to rebuild(setState). If a user clicks a favorite icon on a list item, image, or other, setState causes the entire widget(all listItems...etc) to rebuild
- Testing must rebuild Favorite Icon AND dependencies

- CLASSES OVER FUNCTIONS
- Classes are more efficient

- Functions only benefit is that they require less code to be written. NO PERFORMANCE BENEFIT.

- USE CONST CONSTRUCTORS WHENEVER POSSIBLE SO THEY AREN'T REBUILT

- CONTEXT NAMING SHOULD BE UNIFORM THROUGHOUT THE APP TO AVOID STALE CONTEXTS

### **************LAYOUT AND SIZING*****************

- ALLOWED SIZING COMES FROM PARENT BY DEFAULT

#### OVERRIDING PARENT SIZING WIDGETS
SizedOverflowBox - contraints come from grandparent(meaning likely overflows)
OverflowBox - 

#### MULTI CHILD LAYOUTS
Row:
Column:
ListView:

##### MULTI CHILD LAYOUT CHILDREN WRAPPERS
Flexible - Wrap a child/children of multi-layout widget and give flex factor (2 = 1/2, 3 = 1/3)
Expanded - Use when children overflow, but SHOULD NOT
ClipRect - Use when children overflow, and SHOULD. 
Wrap - children in row, divided by space, and wrap if row overflows

#### SINGLE CHILD LAYOUT WIDGETS




### ************STATE MANAGEMENT***************

#### WIDGET TYPE CHEAT SHEET
*StatelessWidget:* When widget data WILL NOT CHANGE and UI DOES NOT UPDATE. Simplest case.

*StatefulWidget:* State updates need to be reflected to the user, but does NOT NEED TO BE SAVED PRIOR. 
- Basic Forms without animations

*HookWidget:* REPLACEMENT FOR STATEFUL WIDGET
- Most cases can replace stateful widget

*ConsumerWidget:* Data can change, but it is App state, NOT EPHEMERAL
- Reads data/Updates UI; doesn't change data

*StatefulHookWidget:* Ephemeral State but NEED WIDGET LIFECYCLE METHODS

*ConsumerStatefulWidget:* Both Ephemeral and App state
- Reads data/Updates UI and can change it's own data AND NEEDS LIFECYCLE METHODS

*StatefulHookConsumerWidget:* Very complex widgets, specifically if Async calls are used in widget lifecycle methods.


#### BASIC FLUTTER STATE MANAGEMENT CONCEPTS
Flutter is declarative.
UI = f(application state)
Two types of state:
UI(Local) state: Stateful widgets. Ephemeral - USE SETSTATE!!!
App State: shared across parts of app. User preferences, carts, logins...etc 
USE PROVIDER, RIVERPOD, VALUENOTIFIER & INHERITEDNOTIFIER, INHERITED WIDGET & INHERITED MODEL

Provider
- ChangeNotifier
- ChangeNotifierProvider
- Consumer

ChangeNotifier: Observable. Provides change notifications to listeners/subscribers.

ChangeNotifierProvider: above the widgets that need to access to it.
-  you want to provide more than one class, you can use MultiProvider

Consumer: Declares the widget a consumer.
- Ex: Consumer<MyModel> {
  (model is the ChangeNotifier)
    builder: (context, model, child) {
        return Text(model.textData);
    }
}

Provider.of: Use when widget needs data access but not mutation. i.e. Need to check
but no widget to rebuild. Listen MUST BE SET TO FALSE!!
Provider.of<CartModel>(context, listen: false).removeAll();
### FILE STRUCTURE
lib
├─┬─ ui
│ ├─┬─ core
│ │ ├─┬─ ui
│ │ │ └─── <shared widgets>
│ │ └─── themes
│ └─┬─ <FEATURE NAME>
│   ├─┬─ view_model
│   │ └─── <view_model class>.dart
│   └─┬─ widgets
│     ├── <feature name>_screen.dart
│     └── <other widgets>
├─┬─ domain
│ └─┬─ models
│   └─── <model name>.dart
├─┬─ data
│ ├─┬─ repositories
│ │ └─── <repository class>.dart
│ ├─┬─ services
│ │ └─── <service class>.dart
│ └─┬─ model
│   └─── <api model class>.dart
├─── config
├─── utils
├─── routing
├─── main_staging.dart
├─── main_development.dart
└─── main.dart

// The test folder contains unit and widget tests
test
├─── data
├─── domain
├─── ui
└─── utils

// The testing folder contains mocks other classes need to execute tests
testing
├─── fakes
└─── models
pubspec.yaml - Dependency Management
analysis_options.yaml - Linting
### ARCHITECTURE
<img src="./src/main/resources/FlutterFrameworkArchitecture.png" alt="JVMOverview" width="800"/>

### Widget lifecycle
#### Constructs widget       sets state    builds     updates       rebuilds   releases resources 
####                                                                           though widget may 
####                                                                            be added back
#### WidgetConstructor() -> initState() -> build() -> setState() -> build() -> deactivate()   -> dispose()

### Widget lifecycle methods
createState(): This method is required and creates a State object for the widget. It holds all the mutable state for that widget. 
The State object is associated with the BuildContext by setting the mounted property to true.

initState(): This method is automatically called after the widget is inserted into the tree. 
It is executed only once when the state object is created for the first time. Use this method for initializing variables and subscribing to data sources.

didChangeDependencies(): The framework calls this method immediately after initState(). 
It is also called when an object that the widget depends on changes. Use this method to handle changes in dependencies, but it is rarely needed as the build method is always called after this.

build(): This method is required and is called many times during the lifecycle. 
It is called after didChangeDependencies() and whenever the widget needs to be rebuilt. Update the UI of the widget in this method.

didUpdateWidget(): This method is called when the parent widget changes its configuration 
and requires the widget to rebuild. It receives the old widget as an argument, allowing you to compare it with the new widget. 
Use this method to handle changes in the widget's configuration.

setState(): The setState() method notifies the framework that the internal state of the widget has changed and needs to be updated. 
Whenever you modify the state, use this method to trigger a rebuild of the widget's UI.

deactivate(): This method is called when the widget is removed from the widget tree but can be reinserted before the current frame changes are finished. 
Use this method for any cleanup or pausing ongoing operations.

dispose(): This method is called when the State object is permanently removed from the widget tree. Use this method for cleaning up resources, 
such as data listeners or closing connections.



### LAYOUT AND STYLING TWEEKS:
Use CrossAxisAlignment.stretch to make children of row/column/flex even on the cross axis
<img src="resources/how-to/Column Children Uneven.png">
<img src="resources/how-to/Column Children stretch cross axis.png">