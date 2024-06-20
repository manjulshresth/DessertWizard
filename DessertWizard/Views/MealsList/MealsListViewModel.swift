//
//  MealsListViewModel.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

@MainActor final class MealsListViewModel : ObservableObject{
    @Published var meals : [Meal] = []
    @Published var isLoading : Bool = true
    
    //Error handling
    @Published var alertContent : AlertContent?
    @Published var showError : Bool = false
    
    func getMeals(){
        isLoading = true
        Task{
            do {
                meals = try await NetworkManager.shared.getDessertList()
                isLoading = false
            }
            catch{
                if let error = error as? DWError {
                    switch error{
                    case .invalidURL:
                        alertContent = DWAlert.invalidURLContent
                    case .invalidResponse:
                        alertContent = DWAlert.invalidResponseContent
                    case .invalidData:
                        alertContent = DWAlert.invalidDataContent
                    case .invalidConnectionError:
                        alertContent = DWAlert.invalidConnectionErrorContent
                    }
                }
                else{
                    alertContent = AlertContent(title: "Error", message: error.localizedDescription, buttonTitle: "OK")
                }
                isLoading = false
                showError = true
            }
        }
    }
}
