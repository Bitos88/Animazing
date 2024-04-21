//
//  MainView.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 6/5/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            AnimesList()
                .tabItem {
                    VStack {
                        Image(systemName: "film")
                        Text("Animes")
                    }
                }
            ViewedAnimesView()
                .tabItem {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("Viewed")
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AnimeListVM.preview)
    }
}
