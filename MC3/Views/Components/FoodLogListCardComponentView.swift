//
//  FoodLogListCardComponentView.swift
//  MC3
//
//  Created by Jovanna Melissa on 21/08/24.
//

import SwiftUI

struct FoodLogListCardComponentView: View {
    @State private var foodStatusColor:Color = .greensuccess
    @State private var foodStatusString:String = ""
    var food:foodIntakePortion
    @ObservedObject var vm:FoodLogViewModel
//    @Binding private var foodPortion:Int
    @Environment(\.managedObjectContext) private var viewContext
//    @Binding var foodLogDate:Date
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(.bluebg)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "circle.fill")
                            .font(.caption)
                        Text(foodStatusString)
                        Spacer()
                    }
                    .foregroundStyle(foodStatusColor)
                    
                    Text(food.food.title)
                        .fontWeight(.bold)
                        .font(.headline)
                    
                    Text("\(food.food.calories * food.portion) kcal | \(food.portion) serving")
                        .font(.subheadline)
                        .foregroundStyle(.darkgraytext)
                }
                
                Button(action: {
                    if let index = vm.tempFoodLog.firstIndex(where: { $0.id == food.id }) {
                        vm.tempFoodLog.remove(at: index)
                    }
                }, label: {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.blueprimary)
                        .font(.largeTitle)
                })
            }
            .padding()
        }
        .padding()
        .frame(minHeight: 100, maxHeight: 150)
        .onAppear(perform: {
            determineStatusColor(foodStatus: food.food.edibleStatus.rawValue)
        })
    }
}

extension FoodLogListCardComponentView{
    func determineStatusColor(foodStatus: String){
        if food.food.edibleStatus.rawValue == "safe"{
            foodStatusColor = .greensuccess
            foodStatusString = "Safe"
        } else if food.food.edibleStatus.rawValue == "caution"{
            foodStatusColor = .orangewarning
            foodStatusString = "Limited Consumption"
        } else {
            foodStatusColor = .redwarning
            foodStatusString = "Prohibited"
        }
    }
    
//    func fetchFoodIntake(for foodId: Int64) {
//        let fetchRequest = FoodIntake.fetchRequest()
//        
//        // Create predicates for filtering by date and foodId
////        let datePredicate = NSPredicate(format: "intakeAt == %@", foodLogDate as NSDate)
////        let foodIdPredicate = NSPredicate(format: "foodId == %d", foodId)
//        
//        // Combine the predicates
////        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [datePredicate, foodIdPredicate])
//         
//        fetchRequest.predicate = NSPredicate(format: "intakeAt == %@", foodLogDate as NSDate)
//        
//        do {
//            let results = try viewContext.fetch(fetchRequest)
//            print("hellooo")
//            
//            // Assuming you want the first match (if multiple results exist for the same date and foodId)
//            if let foodIntake = results.last {
//                print("masuk food intake")
//                print(foodIntake.intakeAmount)
//                print("tanggal skrg: \(Date())")
//                print("tanggal: \(foodIntake.intakeAt ?? Date())")
//                foodPortion = Int(foodIntake.intakeAmount)
//                
//                print(foodPortion)
//            } else {
//                print("bolonggg")
//            }
//        } catch {
//            print("Failed to fetch food intake: \(error.localizedDescription)")
//        }
//        
////        return nil  // Return nil if no match is found
//    }
}

//#Preview {
//    FoodLogListCardComponentView()
//}
