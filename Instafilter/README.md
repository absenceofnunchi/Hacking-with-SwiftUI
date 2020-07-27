# Instafilter

## Features

### State’s Property Observer

```
struct ContentView: View {
   @State private var blurAmount: CGFloat = 0 {
       didSet {
           print("New value is \(blurAmount)")
       }
   }

    var body: some View {
        VStack {
            Text("Blur example")
            .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
        }
    }
}
```

The above code code doesn’t print anything through the property observer because the State property wrapper, which is essentially a State struct, sets the value with a nonmutating method.  A nonmuating set doesn’t reconstruct the struct, thereby not triggering the property observer.

Following shows the nonmutating set method within the State struct:
```
public var wrappedValue: Value { get nonmutating set }
```

Using a custom binding solution to get around this property observer issue:

```
struct ContentView: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}
```

### Bridging UIKit

#### UIViewControllerRepresentable

Wraps UIKit’s view controllers and turns them into SwiftUI’s view.  Requires two methods to conform to the protocol:

```
struct ImagePicker: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
```

#### Coordinators

Coordinators in SwiftUI is what delegate is in UIKit, particularly for view controllers. Delegates are objects that respond to events that occur elsewhere. For example, UIKit lets us attach a delegate object to its text field view, and that delegate will be notified when the user types anything, when they press return, and so on. This meant that UIKit developers could modify the way their text field behaved without having to create a custom text field type of their own.

1. Create a coordinator class, nested inside the UIViewControllerRepresentable struct:

```
class Coordinator {
}
```

2. Create a method called makeCoordinator():

```
func makeCoordinator() -> Coordinator {
    Coordinator()
}
```

What we’ve done so far is create an ImagePicker struct that knows how to create a UIImagePickerController, and now we just told ImagePicker that it should have a coordinator to handle communication from that UIImagePickerController. SwiftUI calls this coordinator automatically when an instance of ImagePicker is created. Even better, SwiftUI automatically associated the coordinator it created with our ImagePicker struct, which means when it calls makeUIViewController() and updateUIViewController() it will automatically pass that coordinator object to us.

3.  Tell the UIImagePickerController that when something happens it should tell our coordinator. This takes just one line of code in makeUIViewController(), so add this directly before the return picker line:

```
picker.delegate = context.coordinator
```

This means any time something happens inside the image picker controller – i.e., when the user selects an image – it will report that action to our coordinator.

4. Modify the Coordinator class with a class and protocols:

```
class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```

These achieve the following.

- It makes the class inherit from NSObject, which is the parent class for almost everything in UIKit. NSObject allows Objective-C to ask the object what functionality it supports at runtime, which means the image picker can say things like “hey, the user selected an image, what do you want to do?”
- It makes the class conform to the UIImagePickerControllerDelegate protocol, which is what adds functionality for detecting when the user selects an image. (NSObject lets Objective-C check for the functionality; this protocol is what actually provides it.)
- It makes the class conform to the UINavigationControllerDelegate protocol, which lets us detect when the user moves between screens in the image picker.


#### Conditional View

The following code gets an error saying “Closure containing control flow statement cannot be used with function builder ViewBuilder”:

```
ZStack {
    Rectangle()
        .fill(Color.secondary)
    
    if let image = image {
        image?
            .resizable()
            .scaledToFit()
    } else {
        Text("Tap to select a picture")
            .foregroundColor(.white)
            .font(.headline)
    }
}
```

The reason stated from [Hacking with Swift](https://www.hackingwithswift.com/books/ios-swiftui/building-our-basic-ui): 

> What Swift is trying to say is it has support for only a small amount of logic inside SwiftUI layouts – we can use if someCondition, but we can’t use if let, for, while, switch, and so on. 

> What’s actually happening here is that Swift is able to convert if someCondition into a special internal view type called ConditionalContent: it stores the condition and the true and false views, and can check it at runtime. However, if let creates a constant, and switch can have any number of cases, so neither can be used.

Can be fixed with the following code:

```
ZStack {
    Rectangle()
        .fill(Color.secondary)
    
    if image != nil {
        image?
            .resizable()
            .scaledToFit()
    } else {
        Text("Tap to select a picture")
            .foregroundColor(.white)
            .font(.headline)
    }
}
```
