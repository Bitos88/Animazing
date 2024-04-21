//
//  AnimazingApp.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import SwiftUI

@main
struct AnimazingApp: App {
    @StateObject var vm = AnimeListVM()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(vm)
                .preferredColorScheme(.dark)
        }
    }
}
