//
//  ContentView.swift
//  Drawing
//
//  Created by jc on 2020-07-22.
//  Copyright © 2020 J. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [30], dashPhase: 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
