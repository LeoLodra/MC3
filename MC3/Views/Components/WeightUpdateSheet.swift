//
//  WeightUpdateSheet.swift
//  MC3
//
//  Created by mg0 on 21/08/24.
//

import SwiftUI

struct WeightUpdateSheet: View {
    @State var value: Float = 0
    @State private var config:WeightWheelPicker.Config = .init(count: 100) // 100kg
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Update Weight")
            HStack {
                    Text("Input date")
                    Spacer()
                    DatePicker("", selection: .constant(Date()), displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
            }
            .padding(.vertical)
            VStack (spacing: 0) {
                HStack (alignment: .lastTextBaseline, spacing: 5) {
                    Text(verbatim: "\(value)")
                        .font(.largeTitle.bold())
                        .contentTransition(.numericText(value: Double(value)))
                        .animation(.snappy, value: value)
                    Text("kg")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                }
                WeightWheelPicker(config: config, value: $value)
            }
            Button(action: {
                // Action to save
                let newWeight = value
                #warning("Create log weight here")
                print("\(Date()) : \(newWeight)")
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blueprimary)
                    .foregroundColor(.white)
                    .cornerRadius(500)
            }
        }
        .padding()
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
