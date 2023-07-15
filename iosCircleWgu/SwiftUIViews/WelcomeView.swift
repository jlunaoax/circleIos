//
//  WelcomeView.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 28/06/23.
//

import SwiftUI

struct WelcomeView: View {
    @State var isPresented : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This is the IOS learning Circle project. Please choose one of the options")
                
                NavigationLink {
                    ProductListView()
                } label: {
                    Text("Go to product list")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .padding()
                }
                
                Button {
                    // CompaniesControllerWrapper()
                    isPresented.toggle()
                } label: {
                    Text("Go to company list")
                        .padding()
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle(Text("Welcome"))
            .sheet(isPresented: $isPresented) {
                CompaniesControllerWrapper()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
