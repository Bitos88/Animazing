//
//  AnimesListCell.swift
//  Animazing
//
//  Created by Alberto Alegre Bravo on 22/4/23.
//

import SwiftUI

struct AnimesListCell: View {
    let anime:AnimeModel
    let animeStatus: AnimeStatus
    @EnvironmentObject var vm:AnimeListVM
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: URL(string: anime.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 105)
                } placeholder: {
                    Image(systemName: "popcorn.fill")
                        .resizable()
                        .frame(width: 105, height: 100)
                }
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.pink)
                    .frame(width: 30)
                    .padding(7)
                    .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 35, height: 35)
                        )
                    .opacity(anime.isViewed ? 1 : 0)
                    
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(anime.title)
                    .lineLimit(2)
                    .font(.title3)
                    .bold()
                Text("Episodes: \(anime.episodes)")
                    .font(.callout)
                HStack {
                    Text("Rate:")
                        .bold()
                    repeatingImage(count: Int(Double(anime.rateStar) ?? 0.0))
                }
                Spacer()
                HStack {
                    Text(anime.type.rawValue)
                        .foregroundColor(.white)
                        .font(.caption)
                        .padding(5)
                        .background {
                            Color.black
                        }
                        .cornerRadius(10)
                    Text(anime.status.correctFormat())
                            .foregroundColor(.white)
                            .font(.caption)
                            .padding(5)
                            .background {
                                switch animeStatus {
                                case .finalizado:
                                    Color.green
                                case .enEmision:
                                    Color.orange
                                case .proximamente:
                                    Color.cyan
                                case .unknown:
                                    Color.clear
                                }
                            }
                        .cornerRadius(10)
                }
                        
                    HStack {
                        Text("Mark As Viewed")
                            .onTapGesture {
                                vm.toggleViewed(anim: anime)
                            }
                            .foregroundColor(.blue)
                            .padding(.vertical, 2)
                    }
            }
        }
        .frame(maxHeight: 150)
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

struct AnimesListCell_Previews: PreviewProvider {
    static var previews: some View {
        AnimesListCell(anime: .test, animeStatus: .finalizado)
            .environmentObject(AnimeListVM.preview)
            .preferredColorScheme(.dark)
    }
}
