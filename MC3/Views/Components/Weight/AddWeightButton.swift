//
//  AddWeightButton.swift
//  MC3
//
//  Created by mg0 on 22/08/24.
//

import SwiftUI

struct AddWeightButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Update Weight")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blueprimary)
            .foregroundColor(.white)
            .cornerRadius(500)
        }
        .padding(.horizontal)
    }
}

#Preview {
    AddWeightButton(action: {
        let weightUpdateSheet = WeightUpdateSheet(value: 75.3)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let hostingController = UIHostingController(rootView: weightUpdateSheet)
            hostingController.modalPresentationStyle = .pageSheet
            
            if let sheet = hostingController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
            
            window.rootViewController?.present(hostingController, animated: true, completion: nil)
        }
    })
}
