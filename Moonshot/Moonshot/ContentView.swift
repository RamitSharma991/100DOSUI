//
//  ContentView.swift
//  Moonshot
//
//  Created by Ramit sharma on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var isGridDisplayMode = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if isGridDisplayMode {
                        gridView
                    } else {
                        listView
                    }
                }
                
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("MoonShot")
            .toolbar {
                Button(action: {
                    isGridDisplayMode.toggle()
                }) {
                    Image(systemName: isGridDisplayMode ? "square.grid.2x2" : "list.bullet")
                        .tint(.gray)
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
    var gridView: some View {
        
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    gridDisplay(mission: mission)
                    
                }
            }
        }
    }
    
    var listView: some View {
        
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                listDisplay(mission: mission)
            }
        }
    }
    
    
    func gridDisplay(mission: Mission) -> some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.title3.bold())
                    .foregroundStyle(.white.opacity(0.8))
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        }
    }
    func listDisplay(mission: Mission) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding()
            }
            
            VStack() {
                Text(mission.displayName)
                    .font(.title3.bold())
                    .foregroundStyle(.white.opacity(0.8))
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(.lightBackground)
        .clipShape(.rect(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        }
    }
}

#Preview {
    ContentView()
}
