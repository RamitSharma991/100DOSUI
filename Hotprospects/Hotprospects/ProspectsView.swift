//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Ramit Sharma on 31/05/24.
//

import SwiftUI
import SwiftData

struct ProspectsView: View {
    enum FilterType {
    case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        }
    }
    
    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "Ramit Sharma", emailAddress: "ramitsharma991@gmail.com", isContacted: false)
                        modelContext.insert(prospect)
                            
                    }
                }
        }
    }
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}
