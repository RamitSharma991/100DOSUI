//
//  MeView.swift
//  HotProspects
//
//  Created by Ramit Sharma on 31/05/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title3)
                
                TextField("Name", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title3)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
                NavigationLink(destination: EditView(name: $name, emailAddress: $emailAddress)) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Info")
                        Spacer()
                    }
                    .foregroundColor(.indigo)
                }
                
            }
            .navigationTitle("Your QR Code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = genereateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    func scaledQRCodeImage(_ image: CIImage, to size: CGSize) -> CIImage {
        let scaleX = size.width / image.extent.size.width
        let scaleY = size.height / image.extent.size.height
        return image.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
    
    func genereateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            let scaledImage = scaledQRCodeImage(outputImage, to: CGSize(width: 32, height: 32))
            if let cgImage = context.createCGImage(outputImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
