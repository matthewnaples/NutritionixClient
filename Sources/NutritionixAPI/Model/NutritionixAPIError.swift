//
//  NutritionixAPIError.swift
//  
//
//  Created by matt naples on 7/24/23.
//

import Foundation


/// errors that come directly from nutritionix's api response.
public enum NutritionixAPIError: Error, CaseIterable, CustomStringConvertible{
    ///400 - Validation Error, Invalid input parameters, Invalid request
    case invalidInputParameters
    
    /// 401 - Unauthorized, Invalid auth keys, Usage limits exceeded, Missing tokens
    case unauthorized
    
    /// 403 - Forbidden, Disallowed entity
    case forbidden
    
    ///404 - Resource not found
    case resourceNotFound
    
    /// 409 - Resource conflict, Resource already exists
    case resourceAlreadyExists
    
    /// 500 - Base error, internal server error, request failed.
    case internalServerError
    
    var statusCode: Int{
        switch self {
        case .invalidInputParameters:
            return 400
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .resourceNotFound:
            return 404
        case .resourceAlreadyExists:
            return 409
        case .internalServerError:
            return 500
        }
    }
    static func getInstanceByStatusCode(_ code: Int) -> NutritionixAPIError?{
        for responseError in self.allCases{
            if responseError.statusCode == code{
                return responseError
            }
        }
        return nil
    }
    public var description: String{
        switch self {
        case .invalidInputParameters:
            return "Invalid input parameters"
        case .unauthorized:
            return "unauthorized request"
        case .forbidden:
            return "forbidden operation"
        case .resourceNotFound:
            return "resource not found"
        case .resourceAlreadyExists:
            return "resource already exists"
        case .internalServerError:
            return "internal error"
        }
    }
}
