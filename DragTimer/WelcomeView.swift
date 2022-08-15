//
//  WelcomeView.swift
//  DragTimer
//
//  Created by Jan Andrzejewski on 15/08/2022.
//

import SwiftUI
import UserNotifications

struct WelcomeView: View {
    let function: Void
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to DragTimer!")
                    .font(.largeTitle)
                
                Text("How to navigate: \n - drag the box to increase the timer \n - double tap the box to reset the timer")
                    .font(.title3)
                Spacer()
                NavigationLink {
                   Text("h")
                } label: {
                    Text("Find out more about this app")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(.blue)
                        .cornerRadius(15.0)
                }
                Spacer()
                Spacer()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(function: ())
    }
}
