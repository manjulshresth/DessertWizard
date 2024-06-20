//
//  MealsGridCell.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import SwiftUI

struct MealsGridCell: View {
    
    var meal : Meal
    
    var body: some View {
        ZStack{
            MealThumbImage(urlString: meal.strMealThumb)
                .overlay {
                    VStack {
                        Spacer()
                        Text(meal.strMeal)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .minimumScaleFactor(0.7)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .background(.black.opacity(0.38))
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MealsGridCell(meal: Meal(strMeal: "My Favorite Dessert is here", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", idMeal: "123"))
}
