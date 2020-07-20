# Animations

Various SwiftUI animations.

## Features

### Animating Views

```
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            // self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
            )
        )
    }
    .onAppear {
    self.animationAmount = 2
    }
    
}
```

### Animating Bindings

```
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            
            Spacer()
            
            Button("Scale") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}
```

### Non-View Code in Body

If there are non-View elements within the body property, the View element has to be returned so Swift understands which part is the view that is being sent back:

```
var body: some View {
    print(animationAmount)

    return VStack {
    // some code
   }
}
```

### Explicit Animations

```
struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}
```

### Controlling The Animation Stack

```
struct ContentView: View {
    @State private var animationValue = false
    
    var body: some View {
        Button("Tap Me") {
            self.animationValue.toggle()
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(animationValue ? Color.black : Color.yellow)
        .foregroundColor(animationValue ? .white : .black)
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        .clipShape(RoundedRectangle(cornerRadius: animationValue ? 60 : 0, style: .circular))
        .animation(.default)
    }
}
```

### Gesture Animation

```
@State private var dragAmount = CGSize.zero

var body: some View {
    LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        self.dragAmount = .zero
                    }
            }
    )
}

```


```
let letters = Array("Hello")
@State private var enabled = false
@State private var dragAmount = CGSize.zero

var body: some View {
    HStack(spacing: 0) {
        ForEach(0..<letters.count) { num in
            Text(String(self.letters[num]))
                .padding(5)
                .font(.title)
                .frame(width: 50, height: 80, alignment: .center)
                .background(self.enabled ? Color.blue : Color.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(self.dragAmount)
                .animation(Animation.default.delay(Double(num) / 20))
        }
    }
    .gesture(
        DragGesture()
            .onChanged { self.dragAmount = $0.translation }
            .onEnded { _ in
                self.dragAmount = .zero
                self.enabled.toggle()
        }
    )
}
```
