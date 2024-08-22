//
//  WeightUpdateSheet.swift
//  MC3
//
//  Created by mg0 on 21/08/24.
//

import SwiftUI

struct WeightUpdateSheet: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State var value: Float = 0
    @State private var config: WeightWheelPicker.Config = .init(count: 200) // 200kg max
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Update Weight")
            HStack {
                    Text("Input date")
                    Spacer()
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
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
            Button(action: saveWeightLog) {
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
    private func saveWeightLog() {
        let newWeight = value
        print("\(selectedDate) : \(newWeight)")
        let newWeightLog = WeightLog(context: viewContext)
        newWeightLog.weight = Float(newWeight)
        newWeightLog.logDate = selectedDate
        newWeightLog.id = UUID()
        
        do {
            try viewContext.save()
            print("Weight log saved successfully")
            dismiss()
        } catch {
            print("Failed to save weight log: \(error.localizedDescription)")
        }
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
