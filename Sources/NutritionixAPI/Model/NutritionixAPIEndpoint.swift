//
//  NutritionixAPIEndpoint.swift
//  
//
//  Created by matt naples on 7/24/23.
//

import Foundation
public enum NutritionixAPIEndpoint{
    ///  Populate any search interface, including autocomplete, with common foods and branded foods from Nutritionix.  This searches our [entire database](https://www.nutritionix.com/database) of 600K+ foods.  Once a user selects the food from the autocomplete interface, make a [separate API](https://docs.google.com/document/d/1_q-K-ObMTZvO0qUEAxROrN3bwMujwAN25sLHwJzliK0/edit#heading=h.67fe77ikk6il) request to look up the nutrients of the food.
    case instantSearch
    
    ///Get detailed nutrient breakdown of any natural language text.  Can also be used in [combination](https://docs.google.com/document/d/1_q-K-ObMTZvO0qUEAxROrN3bwMujwAN25sLHwJzliK0/edit#heading=h.67fe77ikk6il) with the `instantSearch` endpoint to provide nutrition information for common foods.
    case naturalLanguage
    
    /// Look up the nutrition information for any branded food item by the `nix_item_id`  (from /search/instant endpoint) or `upc` scanned from a branded grocery product.
    case searchItem
    
    /// this will return  `URLComponents` where the scheme, host, and path are specified. It will be up to the you the caller to provide query items.
    var path: String{
        switch self {
        case .instantSearch:
            return "/v2/search/instant"
        case .naturalLanguage:
            return "/v2/natural/nutrients"
        case .searchItem:
            return "/v2/search/item"
        }
    }
    var urlComponents: URLComponents{
        var urlComponents = componentBase
        urlComponents.path = self.path
        return urlComponents
    }
    private var componentBase: URLComponents{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trackapi.nutritionix.com"
        return components
    }
    
    func urlRequest(for queryItems: [URLQueryItem], appId: String, appKey: String, userId: String, body: [String: AnyHashable]? = nil ) throws ->  URLRequest{
        var components = self.urlComponents
        components.queryItems = queryItems
        guard let url = components.url else{
            throw NutritionixServiceError.invalidURL
        }
        var request = URLRequest(url: url)
        var httpMethod: String
        switch self {
        case .instantSearch:
            httpMethod = "GET"
        case .naturalLanguage:
            httpMethod = "POST"
        case .searchItem:
            httpMethod = "GET"
        }
        request.httpMethod = httpMethod
        if let body = body{
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(appId, forHTTPHeaderField: "x-app-id")
        request.setValue(appKey, forHTTPHeaderField: "x-app-key")
        request.setValue(userId, forHTTPHeaderField: "x-remote-user-id")
        return request
    }
}
