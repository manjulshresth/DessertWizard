//
//  ContentView.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

struct MealsListView: View {
    @StateObject var viewModel = MealsListViewModel()
    
    let columns = [GridItem(.adaptive(minimum: 240), spacing: 20)]
    
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.meals, id: \.idMeal) { meal in
                            NavigationLink {
                                MealDetail(meal: meal)
                            } label: {
                                MealsGridCell(meal: meal)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 20)
                }
                .navigationTitle("Desserts")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            if(viewModel.isLoading){
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
            if viewModel.showError{
                if let alertContent = viewModel.alertContent {
                    DWAlertView(title: alertContent.title, message: alertContent.message, btnTitle: alertContent.buttonTitle) {
                        viewModel.showError = false
                    }
                }
            }
        }
        .task {
            viewModel.getMeals()
        }
    }
}

#Preview {
    MealsListView()
}
