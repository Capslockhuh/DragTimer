//
//  ContentView.swift
//  DragTimer
//
//  Created by Jan Andrzejewski on 15/08/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var timerValue = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var showingWelcomeView = false
    @State private var notificationPermission = false
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(colors: [.blue, .mint], center: .top, startRadius: 200, endRadius: 400)
                    .ignoresSafeArea()
                
                ZStack {
                    Circle()
                        .scale(0.5)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: "circle.fill")
                        .foregroundColor(.white)
                    
                    Text("Set timer for \(Int(timerValue)) seconds")
                        .padding(5)
                        .font(.title)
                        .background(.blue)
                        //.opacity(0.85)
                        .cornerRadius(15.0)
                        .padding(10)
                        .offset(dragAmount)
                        .animation(.default, value: dragAmount)
                        .onTapGesture(count: 2) {
                            timerValue = 0
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 280)
                .background(.thinMaterial)
            }
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation
                        print(dragAmount)
                        timerValue += 0.5
                        }
                    .onEnded { _ in
                        dragAmount = .zero
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            timer.connect()
                            scheduleNotification()
                        }
                    }
            )
        }
        .onAppear() {
            showingWelcomeView = true
        }
        
        .sheet(isPresented: $showingWelcomeView) {
            WelcomeView(function: askForNotificationPermission())
        }
        
        .onReceive(timer) { time in
            if timerValue > 0 {
                timerValue -= 1
            }
        }
    }
    
    func askForNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Permission accepted")
                notificationPermission = true
            } else if let error = error {
                print(error.localizedDescription)
                notificationPermission = false
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Your timer for \(Int(timerValue)) seconds"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timerValue, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
