# Guess-the-Flag-Game-SwiftUI

An iOS app built in SwiftUI to guess which country a flag belongs to. It demonstrates the use case of VStack, HStack, ZStack, LinearGradient, Alert, and States.

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/Guess-the-Flag-Game-SwiftUI/blob/master/README_assets/2.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/Guess-the-Flag-Game-SwiftUI/blob/master/README_assets/3.png" width="400">


## Features

### Gradients

<img src="https://github.com/igibliss00/Guess-the-Flag-Game-SwiftUI/blob/master/README_assets/1.png" width="400">

```
VStack {
    LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom)
    RadialGradient(gradient: Gradient(colors: [.yellow, .green]), center: .center, startRadius: 20, endRadius: 200)
    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
}
.edgesIgnoringSafeArea(.all)
```

### Alert

Unlike regular Swift, Alert in SwiftUI is shown depending on the state.  This is in accordance with the principle that view is a function of a state.

```
@State private var showingAlert = false

var body: some View {
    Button("Show Alert") {
        self.showingAlert = true
    }
    .alert(isPresented: $showingAlert) { () -> Alert in
        Alert(title: Text("Hello"), message: Text("This is detail"), dismissButton: .default(Text("OK")))
    }
}
```
