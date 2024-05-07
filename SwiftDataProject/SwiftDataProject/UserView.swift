//
//  UserView.swift
//  SwiftDataProject
//
//  Created by Ramit Sharma on 06/05/24.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()
                
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }
    
    func addSample() {
        let user1 = User(name: "Tony Soprano", city: "New Jersey", joinDate: .now)
        let job1 = Job(name: "Organize paper drawer", priority: 3)
        let job2 = Job(name: "Make plans with Christopher", priority: 4)
        
        modelContext.insert(user1)
        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UserView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
