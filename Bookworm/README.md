# Bookworm

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Bookworm/README_assets/1.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Bookworm/README_assets/2.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Bookworm/README_assets/3.png" width="400">

## Features

### Binding

```
struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.5), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct ContentView: View {
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }        
    }
}
```

### Environment

The way SwiftUI make an object in an ancestor view accessible to all the nested views inside is very similar to the Modern Context API or Redux of React. when we place an object into the environment for a view, it becomes accessible to that view and any views that can call it an ancestor. So, if we have View A that contains inside it View B, anything in the environment for View A will also be in the environment for View B. Taking this a step further, if View A happens to be a NavigationView, any views that are pushed onto the navigation stack have that NavigationView as their ancestor so they share the same environment.
([Source](https://www.hackingwithswift.com/books/ios-swiftui/creating-books-with-core-data))

### Passing Arguments to the Preview

#### Passing a Managed Object from Core Data

```
import CoreData

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}

```

Creating a managed object context involves telling the system what concurrency type we want to use. This is another way of saying “which thread do you plan to access your data using?” For our example, using the main queue – that’s the one the app was launched using – is perfectly fine.

([Source](https://www.hackingwithswift.com/books/ios-swiftui/showing-book-details))

#### Passing a Binding State

```
struct RatingView: View {
    @Binding var rating: Int
    // the body code
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
```

