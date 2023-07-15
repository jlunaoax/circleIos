//
//  ProductListView.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 17/06/23.
//

import SwiftUI

struct ProductListView: View {
    
    @State var products: [Product] = []
    
    var body: some View {
        List {
            ForEach(0..<products.count, id: \.self) { index in
                NavigationLink {ProductDetailView(product: products[index])} label: {
                    ProductRowView(product: products[index])
                }
            }
        }
        .navigationTitle(Text("Products"))
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            Task {
                do {
                    let wrapped = try await HTTPClient.load()
                    products = wrapped.items
                } catch {
                    print (error)
                }
            }
        }
        
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
