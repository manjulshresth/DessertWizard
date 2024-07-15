//
//  MealDetail.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

struct MealDetail: View {
    
    @ObservedObject var viewModel = MealDetailModel()
    var meal : Meal
    
    var body: some View {
        
        if (viewModel.recepie == nil){
            ZStack{
                if viewModel.isLoading{
                    ProgressView()
                        .progressViewStyle(.circular)
                        .task {
                            await viewModel.getRecipe(forMealID: meal.idMeal)
                        }
                }
                
                if viewModel.showError{
                    if let alertContent = viewModel.alertContent {
                        DWAlertView(title: alertContent.title, message: alertContent.message, btnTitle: alertContent.buttonTitle) {
                            viewModel.showError = false
                        }
                    }
                }
            }
        } else {
            ScrollView{
                VStack{
                    Text(viewModel.recepie?.strMeal ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    AsyncImage(url: URL(string: viewModel.recepie?.strMealThumb ?? "")) { image in
                        image
                            .resizable()
                        
                    } placeholder: {
                        Image(.dessertPlaceholder)
                            .resizable()
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 340)
                    .clipped()
                    .cornerRadius(12)
                    
                    GroupBox{
                        DisclosureGroup(
                            content:  {
                                VStack (alignment:.leading){
                                    if let ingredients = viewModel.recepie?.ingredients{
                                        ForEach(ingredients) { ingredient in
                                            Text("\(ingredient.ingredient): \(ingredient.measure)")
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            },
                            label: { Text("Ingredients")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 10)
                            }
                        )
                    }
                    
                    GroupBox{
                        DisclosureGroup(
                            content: {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(viewModel.recepie?.strInstructions ?? "")
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                
                            },
                            label: { Text("Instructions")
                                    .font(.title2)
                                    .bold()
                                .padding(.bottom, 10) }
                        )
                    }
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    MealDetail(meal: Meal(strMeal: "Apam balik", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "53025"))
}
