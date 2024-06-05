//
//  EditView.swift
//  Hotprospects
//
//  Created by Ramit Sharma on 06/06/24.
//

import SwiftUI

struct EditView: View {
    @Binding var name: String
    @Binding var emailAddress: String
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .textContentType(.name)
                .font(.title3)
            
            TextField("Email Address", text: $emailAddress)
                .textContentType(.emailAddress)
                .font(.title3)
        }
        .navigationTitle("Edit Info")
    }
}

struct PreviewProviderHelper: View {
    @State private var name: String = "Anonymous"
    @State private var emailAddress: String = "your@yoursite.com"
    
    var body: some View {
        NavigationStack {
            EditView(name: $name, emailAddress: $emailAddress)
        }
    }
}

#Preview {
    PreviewProviderHelper()
}


