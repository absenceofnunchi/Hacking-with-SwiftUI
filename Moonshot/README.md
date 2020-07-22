# Moonshot

An iOS app that merges two separate JSON files to display them through nested views.

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Moonshot/README_assets/1.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Moonshot/README_assets/2.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Moonshot/README_assets/3.png" width="400">

<img src="https://github.com/igibliss00/Hacking-with-SwiftUI/blob/master/Moonshot/README_assets/4.png" width="400">


## Features

### Aspect Ratio

The aspect ratio’s fit mode is used so commonly:
```
Image(mission.image)
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 44, height: 44)
```

that Swift has scaledToFit() as a replacement:
```
Image(mission.image)
    .resizable()
    .scaledToFit()
    .frame(width: 44, height: 44)
```

### first(where: )

Returns the first element of the sequence that satisfies the given predicate.

```
for member in mission.crew {
    if let match = astronauts.first(where: { $0.id == member.name }) {
        matches.append(CrewMember(role: member.role, astronaut: match))
    } else {
        fatalError("Missing \(member)")
    }
}
```
