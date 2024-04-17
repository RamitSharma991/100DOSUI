//
//  AddressView.swift
//  Cupcake corner
//
//  Created by Ramit sharma on 16/04/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
                    .keyboardType(.numberPad)
            }
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
