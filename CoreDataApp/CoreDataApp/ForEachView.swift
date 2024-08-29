//
//  ForEachView.swift
//  CoreDataApp
//
//  Created by Ramit Sharma on 22/08/24.
//

import SwiftUI


struct Student: Hashable {
    let name: String
}

struct ForEachView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermoine Granger")]
    
    var body: some View {
        List(students, id: \.self ) { student in
            Text(student.name)
        }
    }
}

#Preview {
    ForEachView()
}
