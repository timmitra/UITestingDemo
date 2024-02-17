//
//  User.swift
//  UITestingDemo
//
//  Created by Tim Mitra on 2024-02-16.
//

import Foundation
import Combine

class User: ObservableObject {
  @Published var isLoggedIn = false
  @Published var username = ""
  @Published var password = ""
  
  func login() -> Bool {
    guard username == "test" && password == "pass" else {
      return false
    }
    
    password = ""
    isLoggedIn = true
    return true
  }
}
