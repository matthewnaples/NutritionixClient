//
//  InstantSearchEndpoint.swift
//  HealthJournal
//
//  Created by matt naples on 5/29/22.
//

import Foundation

public struct InstantSearchEndpointResponse: Codable{
    public let common: [CommonFood]?
    public let branded: [BrandedFood]?
}

extension InstantSearchEndpointResponse{
    public static func getSearchForApple() -> InstantSearchEndpointResponse{
        let filePath = Bundle.main.path(forResource: "AppleSearch", ofType: "json")!
        let fileUrl  = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(InstantSearchEndpointResponse.self, from: data)
    }
    
}

public struct CommonFood: Codable{
   public let claims: [String]?
   public let foodName: String
   public let locale: String?
   public let photo: FoodItemThumbnail?
   public let servingQuantity: Double
   public var servingUnit: String
   public let commonType: Int?
   public let tagId: String
   public let tagName: String
   public var fullNutrients: [FullNutrient]?
   public let quantityInGrams: Double?
    
    public init(claims: [String]?, foodName: String, locale: String?, photo: FoodItemThumbnail?, servingQuantity: Double, servingUnit: String, commonType: Int?, tagId: String, tagName: String, fullNutrients: [FullNutrient]?, quantityInGrams: Double?){
        self.claims = claims
        self.foodName = foodName
        self.locale = locale
        self.photo = photo
        self.servingQuantity = servingQuantity
        self.servingUnit = servingUnit
        self.commonType = commonType
        self.tagId = tagId
        self.tagName = tagName
        self.fullNutrients = fullNutrients
        self.quantityInGrams = quantityInGrams
    }
    
    
    enum CodingKeys: String, CodingKey{
        case claims = "claims"
        case commonType = "common_type"
        case foodName = "food_name"
        case locale = "locale"
        case photo = "photo"
        case servingQuantity = "serving_qty"
        case quantityInGrams = "serving_weight_grams"
        case servingUnit = "serving_unit"
        case tagId = "tag_id"
        case tagName = "tag_name"
        case fullNutrients = "full_nutrients"
    }
    
}

public struct BrandedFood: Codable{
    public let brandName: String
    public let foodName: String
    public let brandNameItemName: String
    public let brandType: Int
    public let nfCalories: Double
    public let nixBrandId: String
    public let nixItemId: String
    public let servingQuantity: Double
    public var servingUnit: String
    public let claims: [String]?
    public var fullNutrients: [FullNutrient]?
    public let photo: FoodItemPhoto
    public let region: Int
    public let servingWeightGrams: Double?
    enum CodingKeys: String, CodingKey{
        case brandName = "brand_name"
        case foodName = "food_name"
        case brandNameItemName = "brand_name_item_name"
        case brandType = "brand_type"
        case nfCalories = "nf_calories"
        case nixBrandId = "nix_brand_id"
        case nixItemId = "nix_item_id"
        case servingQuantity = "serving_qty"
        case servingUnit = "serving_unit"
        case servingWeightGrams = "serving_weight_grams"
        case claims
        case region
        case photo
        case fullNutrients = "full_nutrients"
    }
}
