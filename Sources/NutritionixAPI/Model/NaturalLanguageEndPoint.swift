//
//  NaturalLanguageEndPoint.swift
//  HealthJournal
//
//  Created by matt naples on 5/29/22.
//\

import Foundation
public struct NaturalLanguageEndpointResponse: Decodable{
    public var foods: [NaturalLanguageEndpointFood]
}

//extension NaturalLanguageEndpointResponse{
//    public static func getThreeLargeEggs() -> NaturalLanguageEndpointResponse{
//        let filePath = Bundle.main.path(forResource: "ThreeLargeEggs", ofType: "json")!
//        let fileUrl  = URL(fileURLWithPath: filePath)
//        let data = try! Data(contentsOf: fileUrl)
//        return try! JSONDecoder().decode(NaturalLanguageEndpointResponse.self, from: data)
//    }
//    
//    public static func get100gEggs() -> NaturalLanguageEndpointResponse{
//        readJson(fileName: "OneHundredGramsEggs", as: NaturalLanguageEndpointResponse.self)
//        
//    }
//    public static func get100gEggsMealItem() -> MealItem{
//        let eggResponse = get100gEggs()
//        let mapper = NutritionixMapperImplementation()
//        let eggs100g = mapper.mapItem(eggResponse.foods.first!) as! GeneralLeafMealItem
//        return eggs100g
//    }
//    
//    
//    public static func getMilkResponse() -> NaturalLanguageEndpointResponse{
//        readJson(fileName: "Milk", as: NaturalLanguageEndpointResponse.self)
//    }
//    public static func getMilk() -> MealItem{
//        let response: NaturalLanguageEndpointResponse = NaturalLanguageEndpointResponse.getMilkResponse()
//        return NutritionixMapperImplementation().mapItem(response.foods[0])
//    }
//
//}
public struct NaturalLanguageEndpointFood: Decodable{
    public let altMeasures: [FoodItemMeasure]?
    public let brandName: String?
    public let brickCode: String?
    public let classCode: String?
    public let foodName: String
    public var fullNutrients: [FullNutrient]
    public let mealType: Int
    //let metadata: Not sure what type here..
    //let ndb_no: I don't know if we need this
    
    
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public let calories: Double
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public let totalFat: Double
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var saturatedFat: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var cholesterol: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var sodium: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var totalCarb: Double
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var dietaryFiber: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var sugar: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public let protein: Double
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public let potassium: Double?
    public let nixBrandName: String?
    public let nixBrandId: String?
    public let nixItemName: String?
    public let nixItemId: String?
    public let photo: FoodItemPhoto
    public let quantity: Double
    public var servingUnit: String
    public let servingWeightInGrams: Double
    public let source: Int
    public let upc: String?
//    let tags: [[FoodItemTag]]
    enum CodingKeys : String, CodingKey {
        case foodName = "food_name"
        case brandName = "brand_name"
        case brickCode = "brick_code"
        case classCode = "class_code"
        case mealType = "meal_type"
//        case claims
        case servingWeightInGrams  = "serving_weight_grams"
        case calories = "nf_calories"
        case totalFat = "nf_total_fat"
        case saturatedFat = "nf_saturated_fat"
        case cholesterol = "nf_cholesterol"
        case sodium = "nf_sodium"
        case totalCarb = "nf_total_carbohydrate"
        case dietaryFiber = "nf_dietary_fiber"
        case sugar = "nf_sugars"
        case protein = "nf_protein"
        case potassium = "nf_potassium"
        //        case p = "nf_p"
        case fullNutrients = "full_nutrients"
        case nixBrandName = "nix_brand_name"
        case nixBrandId = "nix_brand_id"
        case nixItemName = "nix_item_name"
        case nixItemId = "nix_item_id"
        //        case metadata
        
        case quantity = "serving_qty"
        case servingUnit = "serving_unit"

        case source
//        case tags
        case altMeasures = "alt_measures"
        case photo
        case upc
        
    }}
