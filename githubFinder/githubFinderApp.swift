//
//  GitHub_SearchApp.swift
//  GitHub_Search
//
//  Created by Alessandro H de Jesus & Gyuyoung Lee on 2021-11-23.
//

import SwiftUI

@main
struct GitHub_SearchApp: App {
    // MARK: Property
    var globalUserData = UserData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Add a property to tne environment
                .environmentObject(globalUserData)
        }
    }
}
