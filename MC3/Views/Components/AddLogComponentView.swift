//
//  AddLogComponentView.swift
//  MC3
//
//  Created by Leonardo Marhan on 20/08/24.
//

import SwiftUI

struct AddLogComponentView: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        ZStack {
            if isExpanded {
                VStack(spacing: 30) {
                    HStack {
                        Spacer()
                        VStack (alignment: .center) {
                            Button(action: {
                            }) {
                                Image(systemName: "fork.knife.circle.fill")
                                    .font(.system(size: 72))
                                    .foregroundColor(.blueprimary)
                            }
                            Text("Food")
                                .font(.custom("Lato-Bold", size: 18))
                            Text("Intake")
                                .font(.custom("Lato-Bold", size: 18))
                        }
                        .frame(width: 72)
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                            }) {
                                Image(systemName: "person.bust.circle.fill")
                                    .font(.system(size: 72))
                                    .foregroundColor(.blueprimary)
                            }
                            Text("Weight")
                                .font(.custom("Lato-Bold", size: 18))
                            Text("Progress")
                                .font(.custom("Lato-Bold", size: 18))
                        }
                        .frame(width: 72)
                        Spacer()
                    }
                    
                    
                    VStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                isExpanded.toggle()
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 72))
                                .foregroundColor(.blueprimary)
                                .rotationEffect(Angle(degrees: isExpanded ? 45 : 0))
                        }
                        Text("Add Log")
                            .font(.custom("Lato-Bold", size: 18))
                    }
                }
            } else {
                VStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 72))
                            .foregroundColor(.blueprimary)
                    }
                    Text("Add Log")
                        .font(.custom("Lato-Bold", size: 18))
                }
                
            }
        }
//        .animation(.interactiveSpring, value: isExpanded)
        .transition(.move(edge: .top))
    }
}

