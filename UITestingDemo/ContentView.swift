//
//  ContentView.swift
//  UITestingDemo
//
//  Created by Tim Mitra on 2024-02-16.
//

import SwiftUI

struct ContentView: View {
  @State private var showLogin = false
  @EnvironmentObject private var user: User
  
  var body: some View {
    VStack {
      Text(!user.isLoggedIn ? "Welcome!" : "Welcome \(user.username)!")
        .font(.title)
      
      Spacer().frame(height: 20)
      
      Button(action: {
        if !user.isLoggedIn {
        showLogin = true
        } else {
          user.logout()
        }
      }, label: {
        Text(!user.isLoggedIn ? "Login" : "Logout")
      }).accessibilityIdentifier("loginButton")
    }
    .sheet(isPresented: $showLogin) {
            LoginView()
        }
  }
}

#Preview {
  ContentView()
}
