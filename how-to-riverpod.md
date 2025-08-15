

## RIVERPOD FOR STATE MANAGEMENT
### See https://codewithandrea.com/articles/flutter-state-management-riverpod/ for more in depth analysis as Riverpod documentation is lacking.

### IMPORTANT CONCEPT:
Because the widgets build method is called EVERYTIME state changes,
DO NOT PUT DATA FETCHES INSIDE THE BUILD OR ANY LIFECYCLE METHODS AS THEY WILL CAUSE THE 
NETWORK REQUEST TO BE FIRED OVER AND OVER! CREATING MEMORY LEAKS, STACK OVERFLOWS, AND 
PRETTY MUCH ANYTHING THAT CAN CRASH AN APP.

INSTEAD:
1. INITIALIZE THE DATA OUTSIDE OF BUILD METHODS
2. OR TRIGGER THEM BY A USER EVENT SUCH AS ONPRESSED.   


#### CORE CONCEPTS:
*Declare and initialize providers OUTSIDE OF BUILD METHOD.
*Listen/Read/Watch INSIDE BUILD METHOD
*WIDGETREF OBJECT*
- ref.watch : Use INSIDE build method
- ref.read : initstate or other lifecycle methods.
- Create model class(data structure to parse JSON responses into. See InventoryItem.dart)
- Create Provider class
- Wrap entire app in ProviderScope widget
- Make class extend Consumer

### WIDGETS THAT CONSUME PROVIDER DATA
#### Consumer and ConsumerWidget
- MOST COMMON USE CASE. 
- **Replacement for StatelessWidget**
A WIDGET NEEDS TO BE NOTIFIED WHEN A STATE IS UPDATED.
- **Consumer is used to wrap widgets inside the build tree in the case that **THAT WIDGET IS THE ONLY ONE THAT NEEDS TO UPDATE**

#### ConsumerState and ConsumerStatefulWidget

*TYPES OF PROVIDERS AND THE WIDGETS THAT USE THEM*

#### Provider
- Accessing DEPENDENCIES THAT DON'T CHANGE SUCH AS REPOSITORIES
- Declare provider:
final dateFormatterProvider = Provider<DateFormat>((ref) {
  return DateFormat.MMMEd();
});
- Widget uses Provider by 
1. EXTENDING ConsumerWidget
2. PASSING IN Ref Object to Build method
3. Using ref.watch(dateFormatterProvider) (From declaration above)

### FutureProvider
- Used to store data from API calls(separate service/repo)
*STEPS*
- Create api or repository logic to get data from API or DB respectively
- Create   

### StreamProvider


### NotifierProvider


### AsyncNotifierProvider



#### DO'S AND DONT'S OF RIVERPOD
https://riverpod.dev/docs/essentials/do_dont#avoid-using-providers-for-ephemeral-state

##### AVOID using providers for Ephemeral state.
##### USE FLUTTER HOOKS INSTEAD
USE FOR shared business state.
DO NOT USE FOR:
- The currently selected item.
- Form state/ Because leaving and re-entering the form should typically reset the form state. This includes pressing the back button during a multi-page forms.
Animations.
- Generally everything that Flutter deals with a "controller" (e.g. TextEditingController)

##### DON'T perform side effects during the initialization of a provider
- DON'T:
final submitProvider = FutureProvider((ref) async {
  final formState = ref.watch(formState);

  // Bad: Providers should not be used for "write" operations.
  return http.post('https://my-api.com', body: formState.toJson());
});

CONSIDER

There is no "one-size fits all" solution to this problem.
If your initialization logic depends on factors external to the provider, often the correct place to put such logic is in the onPressed method of a button triggering navigation:

ElevatedButton(
  onPressed: () {
    ref.read(provider).init();
    Navigator.of(context).push(...);
  },
  child: Text('Navigate'),
)

##### AVOID using providers for Ephemeral state.
Providers are designed to be for shared business state. They are not meant to be used for Ephemeral state, such as for:

- The currently selected item.
- Form state/ Because leaving and re-entering the form should typically reset the form state. This includes pressing the back button during a multi-page forms.
Animations.
- Generally everything that Flutter deals with a "controller" (e.g. TextEditingController)
If you are looking for a way to handle local widget state, consider using flutter_hooks instead.

- One reason why this is discouraged is that such state is often scoped to a route.
Failing to do so could break your app's back button, due to a new page overriding the state of a previous page.

DON'T perform side effects during the initialization of a provider
Providers should generally be used to represent a "read" operation. You should not use them for "write" operations, such as submitting a form.

DON'T:

final submitProvider = FutureProvider((ref) async {
  final formState = ref.watch(formState);

  // Bad: Providers should not be used for "write" operations.
  return http.post('https://my-api.com', body: formState.toJson());
});

PREFER ref.watch/read/listen (and similar APIs) with statically known providers
Riverpod strongly recommends enabling lint rules (via riverpod_lint).
But for lints to be effective, your code should be written in a way that is statically analysable.

Failing to do so could make it harder to spot bugs or cause false positives with lints.

Do:

final provider = Provider((ref) => 42);

// OK because the provider is known statically
ref.watch(provider);

Don't PASS IN PROVIDERS! INITIALIZE AHEAD:

class Example extends ConsumerWidget {
  Example({required this.provider});
  final Provider<int> provider;

  @override
  Widget build(context, ref) {
    // Bad because static analysis cannot know what `provider` is
    ref.watch(provider);
  }
}

- AVOID dynamically creating providers
Providers should exclusively be top-level final variables.

- PREFER ref.watch/read/listen (and similar APIs) with statically known providers
- i.e. DON'T PASS IN PROVIDERS AS DEPENDENCY INJECTION.
- Create AND INITIALIZE PROVIDERS

##### Freezed
dart run build_runner watch (watch for dynamic reruns)
