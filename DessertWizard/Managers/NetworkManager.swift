//
//  NetworkManager.swift
//  DessertWizard
//
//  Created by Manjul Shrestha on 6/17/24.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let baseURL = "https://themealdb.com/"
    
    private let cache = NSCache<NSString, UIImage>()
    
    
    // MARK: Function to get list of Desserts
    func getDessertList() async throws -> [Meal] {
        let stringURL = baseURL + "api/json/v1/1/filter.php?c=Dessert"
        
        guard let url = URL(string : stringURL) else { throw DWError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw DWError.invalidConnectionError }
        
        if response.statusCode != 200 { throw DWError.invalidResponse }
        
        do{
            let decodedReponse = try JSONDecoder().decode(Meals.self, from: data)
            let sortedArray = decodedReponse.meals.sorted(by: { $0.strMeal < $1.strMeal } )
            return sortedArray
        }
        catch {
            throw DWError.invalidData
        }
    }
    
    // MARK: Function to get recipe for dessert from Meal ID
    func getDessertRecipe(forMealID mealID: String) async throws -> MealRecipe {
        let stringURL = baseURL + "api/json/v1/1/lookup.php?i=\(mealID)"
        
        guard let url = URL(string : stringURL) else { throw DWError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else { throw DWError.invalidConnectionError }
        
        if response.statusCode != 200 { throw DWError.invalidResponse }
        
        do{
            let decodedReponse = try JSONDecoder().decode(MealsRecipes.self, from: data)
            if let recipe = decodedReponse.meals.first{
                return recipe
            }
            else{
                throw DWError.invalidData
            }
        }
        catch {
            throw DWError.invalidData
        }
    }
    
    
    // MARK: Function to get thumbnail
    // WE are not worried about showing error here
    func downloadImage(fromUrlString : String) async -> UIImage? {
        let cacheKey = NSString(string: fromUrlString)
        if let img = cache.object(forKey: cacheKey){
            return img
        }
        guard let thumbURL = URL(string : fromUrlString) else { return nil }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: thumbURL)
            guard let img = UIImage(data: data) else { return nil }
            cache.setObject(img, forKey: cacheKey)
            return img
        }
        catch{
            return nil
        }
        
        
    }
}
