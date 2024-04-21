//
//  DetailView.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 30/4/23.
//

import SwiftUI

struct DetailView: View {
    let anime: AnimeModel
    let animeStatus: AnimeStatus
    @State private var showSheet = false
    @State var showViewed:Bool
    @EnvironmentObject var vm:AnimeListVM
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: anime.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                            .padding()
                    } placeholder: {
                        Image(systemName: "popcorn.fill")
                            .resizable()
                            .frame(width: 105, height: 100)
                    }
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.pink)
                        .frame(width: 50)
                        .padding(25)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 55, height: 55)
                        )
                        .opacity(anime.isViewed ? 1 : 0)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(anime.title)
                        .font(.title)
                    HStack {
                        Text(anime.type.rawValue)
                            .foregroundColor(.orange)
                            .font(.title3)
                        Text("- " + anime.status.rawValue)
                            .foregroundColor(.white)
                            .font(.title3)
                    }
                    
                    HStack{
                        Text("Rate: ")
                            .font(.title3)
                        repeatingImage(count: Int(Double(anime.rateStar) ?? 0.0))
                    }
                    
                    Button {
                        vm.toggleViewed(anim: anime)
                        showViewed.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("MARK AS VIEWED")
                        }
                        .bold()
                    }
                    Text(anime.description ?? "")
                        .lineLimit(3)
                    
                    Button("Ver descripción entera...") {
                        showSheet.toggle()
                    }
                    .fullScreenCover(isPresented: $showSheet) {
                        DetailFullInfoView(anime: anime, showSheet: $showSheet)
                    }
                    
                    Link(destination: URL(string: anime.animeURL)!) {
                        HStack {
                            Image(systemName: "play")
                            Text("View Anime")
                        }
                        .foregroundColor(.black)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color.orange)
                    }

                    Text("Related Animes:")
                        .font(.title3)
                        .foregroundColor(.orange)
                        .underline()
                        .offset(y: 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid (rows: [GridItem()]){
                        ForEach(vm.showSimilarAnimes(type: anime.type, currentAnime: anime)) { anime in
                            NavigationLink(value: anime) {
                                VStack {
                                    AsyncImage(url: URL(string: anime.image)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                            .frame(width: 150, height: 250)
                                    } placeholder: {
                                        Image(systemName: "popcorn")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 250)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .toolbar {
            ShareLink("Share", item: anime.animeURL)
        }
    }
    
    func repeatingImage(count: Int) -> some View {
        ForEach(1...count, id: \.self) { _ in
            Image("hadouken")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(anime: .test, animeStatus: .finalizado, showViewed: true)
                .environmentObject(AnimeListVM.preview)
                .preferredColorScheme(.dark)
        }
    }
}


struct DetailFullInfoView: View {
    let anime: AnimeModel
    @Binding var showSheet: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(width: 15)
                }
                
                Text(anime.title)
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                Text(anime.description ?? "")
                    .font(.caption)
                Text("Genres:")
                    .underline()
                    .foregroundColor(.orange)
                Text(anime.genres?.withFormmat() ?? "")
                Text("Episodes:")
                    .underline()
                    .foregroundColor(.orange)
                Text("\(anime.episodes)")
                Text("Total votes:")
                    .underline()
                    .foregroundColor(.orange)
                Text("\(anime.votes)")
                Group {
                    Text("Followers:")
                        .underline()
                        .foregroundColor(.orange)
                    Text("\(anime.followers)")
                }
            }
            .padding()
        }
    }
}
