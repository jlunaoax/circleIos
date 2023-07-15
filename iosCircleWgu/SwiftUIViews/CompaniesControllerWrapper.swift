//
//  CompaniesControllerWrapper.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 14/07/23.
//

import SwiftUI

struct CompaniesControllerWrapper: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let companiesController = CompaniesController(style: .insetGrouped)
        let navigationController = UINavigationController(rootViewController: companiesController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // No code needed
    }
    
}
