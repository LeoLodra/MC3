//
//  ContentView.swift
//  MC3
//
//  Created by Leonardo Marhan on 13/08/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to SwiftUI")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("Home")
        }
}


#Preview {
    ContentView()
}
