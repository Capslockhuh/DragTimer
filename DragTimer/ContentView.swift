//
//  ContentView.swift
//  DragTimer
//
//  Created by Jan Andrzejewski on 15/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var timerValue = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    var body: some View {
        VStack {
            Text("Set timer for \(Int(timerValue))")
                .padding(5)
                .font(.title)
                .background(.blue)
                .offset(dragAmount)
                .animation(.default, value: dragAmount)
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation
                    print(dragAmount)
                    timerValue += 0.5
                }
                .onEnded { _ in
                    dragAmount = .zero
                }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
