//
//  NutritionixAPI.swift
//
//
//  Created by matt naples on 7/24/23.
//

import Foundation
public class NutritionixAPI{
    
    public init(appKey: String, appId: String, userId: String){
        self.appKey = appKey
        self.appId = appId
        self.userId = userId
    }
    
    var appKey: String
    var appId: String
    var userId: String
    public func getFoodByBarcode(upc: String, includeHealthLabelClaims: Bool = true) async throws -> ItemEndpointResponse{
        let queryItems = [
            URLQueryItem(name: "upc", value: upc),
            URLQueryItem(name: "claims", value: includeHealthLabelClaims ? "true" : "false")
        ]
        
        let request = try NutritionixAPIEndpoint.searchItem.urlRequest(for: queryItems, appId: self.appId, appKey: self.appKey, userId: userId)
       
        let data = try await execute(request: request)
        let jsonString = String(data: data, encoding: .utf8)
        print("json string!")
        print(jsonString)
//        let responseJson = try! JSONSerialization.jsonObject(with: data)
//         print(responseJson)
        do{
        let response = try JSONDecoder().decode(ItemEndpointResponse.self, from: data)
            return response
        }
        catch{
            print(error)
            throw error
        }

    }
    
    public func getFoodByNixId(nixId: String, includeHealthLabelClaims: Bool = true)async throws -> ItemEndpointResponse{
        let queryItems = [
            URLQueryItem(name: "nix_item_id", value: nixId),
            URLQueryItem(name: "claims", value: includeHealthLabelClaims ? "true" : "false")
        ]
        
        let request = try NutritionixAPIEndpoint.searchItem.urlRequest(for: queryItems, appId: self.appId, appKey: self.appKey, userId: userId)
        
        let data = try await execute(request: request)
                let jsonString = String(data: data, encoding: .utf8)
                print("json string!")
                print(jsonString)
//        let responseJson = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed)
//        print(responseJson)
        let response = try JSONDecoder().decode(ItemEndpointResponse.self, from: data)
         
        return response
    }
    
    public func getFoodsByInstantSearch(query: String,  foodTypes: [FoodItemTypes] = [.branded, .common],
                                        includeNutrientDetails: Bool = false,
                                        includeHealthLabelClaims: Bool = true) async throws -> InstantSearchEndpointResponse{
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "branded", value: foodTypes.contains(.branded) ? "true" : "false"),
            URLQueryItem(name: "common", value: foodTypes.contains(.common) ? "true" : "false"),
            URLQueryItem(name: "detailed", value: includeNutrientDetails ? "true" : "false"),
            URLQueryItem(name: "claims", value: includeHealthLabelClaims ? "true" : "false")
        ]
        let request = try NutritionixAPIEndpoint.instantSearch.urlRequest(for: queryItems, appId: self.appId, appKey: self.appKey, userId: userId)
        do{
        let data = try await execute(request: request)
            let jsonString = String(data: data, encoding: .utf8)
//            print("json string!")
            print("calling get foods by instant search with query \(query)")
//            print(jsonString)

//        let responseJson = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed) as! [String: Any]
        let response = try JSONDecoder().decode(InstantSearchEndpointResponse.self, from: data)
//        let jsonString = String(data: data, encoding: .utf8)
//        print("json string!")
//        print(jsonString)
        return response
    }
//        catch let err as URLError{
//            if err.errorCode == NSURLErrorCancelled {
//                return InstantSearchEndpointResponse(common: nil, branded: nil)
//            } else{
//                throw err
//            }
//        }
        catch {
            print("error in search query")
            print(error)
            print(type(of: error))
            print(error.localizedDescription)
            throw error
        }
//        let data = try await execute(request: request)
//        let responseJson = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed) as! [String: Any]
//        return responseJson
    }
    public func getFoodsWithNaturalLanguage(query: String) async throws -> NaturalLanguageEndpointResponse{
        let body: [String: AnyHashable] = [
             "query": query,
        ]
        let request = try NutritionixAPIEndpoint.naturalLanguage.urlRequest(for: [], appId: appId, appKey: appKey, userId: userId, body: body)
        let data = try await execute(request: request)
        let jsonString = String(data: data, encoding: .utf8)
        let responseJson = try! JSONSerialization.jsonObject(with: data , options: .fragmentsAllowed) as! [String: Any]
        print (responseJson)
        print(jsonString!)
        return try JSONDecoder().decode(NaturalLanguageEndpointResponse.self, from: data)
    }
    
    private func execute(request: URLRequest) async throws -> Data{
        var response: (Data, URLResponse)
        if #available(iOS 15.0, *) {
            response = try await URLSession.shared.data(for: request, delegate: nil)
        }
        else{
            response = try await URLSession.shared.data(for: request)
        }
        guard let urlResponse = response.1 as? HTTPURLResponse else{
            throw NutritionixServiceError.couldNotGetStatusCode
        }
        if let error = NutritionixAPIError.getInstanceByStatusCode(urlResponse.statusCode){
            print(urlResponse.url as Any)
            throw error
        }
        print(urlResponse.url as Any)

        return response.0
        

    }
   
}
