//
//  MealRecipe.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import Foundation

// MARK: - Welcome
struct MealsRecipes: Decodable {
    let meals: [MealRecipe]
}

struct MealRecipe: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strDrinkAlternate : String?
    let strImageSource : String?
    let strCreativeCommonsConfirmed : String?
    let dateModified: Date?
    let ingredients : [Ingredient]?
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strSource
        case strDrinkAlternate
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
        case strMeasure1,strMeasure2,strMeasure3,strMeasure4,strMeasure5,strMeasure6,strMeasure7,strMeasure8,strMeasure9,
             strMeasure10,strMeasure11,strMeasure12,strMeasure13,strMeasure14,strMeasure15,strMeasure16,strMeasure17,strMeasure18,strMeasure19,strMeasure20
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        self.strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        self.strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        self.strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(Date.self, forKey: .dateModified)
        
        var ingredients: [Ingredient] = []
        
        for i in 1...20 {
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
            
            if let measure = try? container.decodeIfPresent(String.self, forKey: measureKey),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: ingredientKey),
               !measure.isEmpty, !ingredient.isEmpty {
                
                // Check if the ingredient already exists in the array
                if !ingredients.contains(where: { $0.ingredient.lowercased() == ingredient.lowercased()}) {
                    let ingredientItem = Ingredient(ingredient: ingredient, measure: measure)
                    ingredients.append(ingredientItem)
                }
                
            }
        }
        self.ingredients = ingredients
    }
}

struct Ingredient : Decodable, Identifiable {
    var id = UUID()
    let ingredient : String
    let measure: String
}
