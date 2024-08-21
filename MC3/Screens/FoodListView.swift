//
//  FoodListView.swift
//  MC3
//
//  Created by Jovanna Melissa on 18/08/24.
//

import SwiftUI

struct FoodListView: View {
    
    @State private var foods:[Food] = []
    @State private var foodLogSheetShowing = false
    @State private var date = Date()
    @State private var foodLogQty = 0
    @StateObject private var vm = FoodLogViewModel()
    @State private var searchQuery = ""
    @State private var filteredFoods: [Food] = []
    
    var body: some View {
        
        NavigationView{
            VStack{
                HStack {
                    TextField("Search Menu", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    
                    Button(action: {
                        foodLogSheetShowing = true
                    }) {
                        ZStack{
                            Image("Chef Hat 1")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 16)
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 15, height: 15)
                                .foregroundStyle(.blueprimary)
                                .offset(x: 4, y: -5)
                            Text("\(vm.tempFoodLog.count)")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .font(.caption2)
                                .offset(x: 4, y: -5)
                        }
                        
                    }
                }
                ScrollView{
                    VStack(spacing: -16){
                        ForEach(filteredFoods){food in
                            FoodCardViewComponent(food: food, vm: vm)
                        }
                    }
                }
            }
        }
//        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Menu")
        .onChange(of: searchQuery) { newValue in
            filterFoods()
        }
        .onAppear(perform: loadFoods)
        .sheet(isPresented: $foodLogSheetShowing){
            FoodLogSheetComponentView(vm: vm, foodLogShowingSheet: $foodLogSheetShowing)
                .presentationDragIndicator(.visible)
        }
    }
    
    private func loadFoods() {
        foods = JSONLoader.loadFoods()
        filteredFoods = foods
    }
    
    private func filterFoods() {
        if searchQuery.isEmpty {
            filteredFoods = foods
        } else {
            filteredFoods = foods.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }
}

//#Preview {
//    FoodListView()
//}
