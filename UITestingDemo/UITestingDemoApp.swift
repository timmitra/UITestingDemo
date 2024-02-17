//
//  UITestingDemoApp.swift
//  UITestingDemo
//
//  Created by Tim Mitra on 2024-02-16.
//

import SwiftUI

@main
struct UITestingDemoApp: App {
  var user = User() // make User available globally
  
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(user) // pass user to views environment
        }
    }
}
