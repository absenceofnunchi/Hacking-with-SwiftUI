# Cupcake Corner

An iOS app in SwiftUI that inputs the cupcake order and an address and sends an HTTP request.

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/CupcakeCorner/README_assets/1.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/CupcakeCorner/README_assets/2.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/CupcakeCorner/README_assets/3.png" width="400">

## Features

### Initializing With Coding Keys

```
class User: ObservableObject, Codable {
    @Published var name = "Kobe"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
}
```

Inside the method we ask our Decoder instance for a container matching all the coding keys we already set in our CodingKey struct by writing decoder.container(keyedBy: CodingKeys.self). This means “this data should have a container where the keys match whatever cases we have in our CodingKeys enum. This is a throwing call, because it’s possible those keys don’t exist. 

Finally, we can read values directly from that container by referencing cases in our enum – container.decode(String.self, forKey: .name). This provides really strong safety in two ways: we’re making it clear we expect to read a string, so if name gets changed to an integer the code will stop compiling; and we’re also using a case in our CodingKeys enum rather than a string, so there’s no chance of typos.

([Source](https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties))


