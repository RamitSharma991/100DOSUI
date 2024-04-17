//
//  CheckoutView.swift
//  Cupcake corner
//
//  Created by Ramit sharma on 16/04/24.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var ShowingError = false
    
    var order: Order
    var body: some View {
        
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You!", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Error", isPresented: $ShowingError) {
            Button("Ok") {}
        } message: {
            Text(errorMessage)
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            errorMessage = "Failed to place Order! Please check your internet connection."
            ShowingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
