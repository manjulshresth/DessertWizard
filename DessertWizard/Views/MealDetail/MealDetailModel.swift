//
//  MealDetailModel.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

@MainActor final class MealDetailModel : ObservableObject{
    @Published var recepie : MealRecipe?
    @Published var isLoading : Bool = true
    
    //Error handling
    @Published var alertContent : AlertContent?
    @Published var showError : Bool = false
    
    let columns : [GridItem] = [GridItem(.flexible(), spacing: 0)]
    
    func getRecipe(forMealID mealID: String) async{
        isLoading = true
            do {
                recepie = try await NetworkManager.shared.getDessertRecipe(forMealID: mealID)
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
