//
//  NutritionixServiceError.swift
//  
//
//  Created by matt naples on 7/24/23.
//

import Foundation

///errors in the client, not by Nutritionix's server.
public enum NutritionixServiceError: Error{
    case invalidURL
    case APIError(NutritionixAPIError)
    case couldNotGetStatusCode
}
