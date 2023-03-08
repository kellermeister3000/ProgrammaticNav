//
//  ContentView.swift
//  ProgrammaticNav
//
//  Created by Philip Keller on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    
    var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                 .init(name: "Playstation", imageName: "xbox.logo", color: .indigo),
                                 .init(name: "PC", imageName: "xbox.logo", color: .pink),
                                 .init(name: "Mobile", imageName: "xbox.logo", color: .mint)]
    
    var games: [Game] = [.init(name: "Minecraft", rating: "99"),
                         .init(name: "God of War", rating: "98"),
                         .init(name: "Fortnite", rating: "92"),
                         .init(name: "Madden 2023", rating: "88")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                
                Section("Games") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink(value: game) {
                            /*@START_MENU_TOKEN@*/Text(game.name)/*@END_MENU_TOKEN@*/
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game) {
                                    /*@START_MENU_TOKEN@*/Text(game.name)/*@END_MENU_TOKEN@*/
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack{
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())
                    
                    Button("Recommended Game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go To Another Platform") {
                        path.append(platforms.randomElement()!)
                    }
                    
                    Button("Go Home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}
