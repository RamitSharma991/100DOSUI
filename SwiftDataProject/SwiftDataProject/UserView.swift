//
//  UserView.swift
//  SwiftDataProject
//
//  Created by Ramit Sharma on 06/05/24.
//

import SwiftUI
import SwiftData

struct UserView: View {
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }
}

#Preview {
    UserView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
