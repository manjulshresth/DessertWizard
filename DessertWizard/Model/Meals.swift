//
//  Meals.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import Foundation

// MARK: - Welcome
struct Meals: Decodable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
