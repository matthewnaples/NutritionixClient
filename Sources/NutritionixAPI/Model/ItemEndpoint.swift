//
//  Food.swift
//  HealthJournal
//
//  Created by matt naples on 5/27/22.
//

import Foundation
//import Files
extension ItemEndpointResponse{
    public static func getTortillaExample() -> ItemEndpointResponse{
        let filePath = Bundle.main.path(forResource: "ChipotleBurritoTortilla", ofType: "json")!
        let fileUrl  = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(ItemEndpointResponse.self, from: data)
    }
    public static func getCerealExample() -> ItemEndpointResponse{
        let filePath = Bundle.main.path(forResource: "Cereal", ofType: "json")!
        let fileUrl  = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(ItemEndpointResponse.self, from: data)
    }
    public static func getCelsiusEnergyExample() -> ItemEndpointResponse{
        let filePath = Bundle.main.path(forResource: "CelsiusEnergy", ofType: "json")!
        let fileUrl  = URL(fileURLWithPath: filePath)
        let data = try! Data(contentsOf: fileUrl)
        return try! JSONDecoder().decode(ItemEndpointResponse.self, from: data)
    }
}
//the top level array returned from the item endpoint.
public struct ItemEndpointResponse: Codable, Identifiable{
    public var foods: [Food]
    public var id: String{
        "an id"
    }
}

/// Simply defined as the objects in the item endpoint response's array of foods.
public struct Food: Codable{
    
    public var foodName: String
    public var brandName: String?
    public var quantity: Double
    public var servingUnit: String
    public var quantityInGrams: Double?
    public var ingredients: String?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var calories: Double
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var totalFat: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var saturatedFat: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var cholesterol: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var sodium: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var totalCarb: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var dietaryFiber: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var sugar: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var protein: Double?
    ///as listed on nutrition facts (as opposed to the fda full nutrient statement)
    public var potassium: Double?
    public var nixItemName: String?
    public var nixItemId: String
    public var nixBrandName: String?
    public var nixBrandId: String?
    
    public var source: Int?
    public var claims: [String]?
    
    public var fullNutrients: [FullNutrient]?
    public var tags: [FoodItemTag]?
    //    public var metadata: [String: Any]?
    public var altMeasures: [FoodItemMeasure]?
    public var photo: FoodItemPhoto?
    
    enum CodingKeys : String, CodingKey {
        case foodName = "food_name"
        case brandName = "brand_name"
        case quantity = "serving_qty"
        case claims
        case servingUnit = "serving_unit"
        case quantityInGrams  = "serving_weight_grams"
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
        case source
        case tags
        case altMeasures = "alt_measures"
        case photo
        case ingredients = "nf_ingredient_statement"
    }
}

public struct FoodItemTag: Codable{
   public let foodGroup: Int
   public let item: String
   public let measure: String?
   public let quantity: Double
   public let tagId: String

    enum CodingKeys : String, CodingKey {
        case foodGroup = "food_group"
        case item
        case measure
        case quantity
        case tagId = "tag_id"
    }
}

public enum MassMeasure: CaseIterable{
    case grams, milligrams, ounces, pounds
    var abbreviation: String{
        switch self {
        case .grams:
            return "g"
        case .milligrams:
            return "mg"
        case .ounces:
            return "oz"
        case .pounds:
            return "lb"
        }
    }
    static func getInstanceByAbbreviation(_ abbreviation: String) -> MassMeasure?{
        let formattedArgument = abbreviation.components(separatedBy: .punctuationCharacters).joined().filter{!$0.isWhitespace}.lowercased()
        return MassMeasure.allCases.first(where: {$0.validAbbreviationsformatted.contains( formattedArgument)})
    }
    var validAbbreviationsformatted: [String]{
        var result: [String]
        switch self {
        case .grams:
            result = ["g", "gram", "grams"]
        case .ounces:
            result = ["oz", "wt. oz"]
        default:
            result = [self.abbreviation]
        }
        return result.map{$0.components(separatedBy: .punctuationCharacters).joined().filter{!$0.isWhitespace}.lowercased()}
    }
}

public enum VolumeMeasure: CaseIterable{
    case fluidOunces
    case teaspoons
    case tablespoons
    case quarts
    case cups
    case liters
    case milliliters

    static func getInstanceByAbbreviation(_ abbreviation: String) -> VolumeMeasure?{
        let formattedArgument = abbreviation.components(separatedBy: .punctuationCharacters).joined().filter{!$0.isWhitespace}.lowercased()

        let allCases = VolumeMeasure.allCases
        return allCases.first (where: { measure in
            measure.validNamesFormatted.contains(formattedArgument)
        })

    }
    var formattedAbbreviation: String{
        return self.abbreviation.components(separatedBy: .punctuationCharacters).joined().filter{!$0.isWhitespace}.lowercased()
    }
    var validNamesFormatted: [String]{
        return validNames.map({$0.components(separatedBy: .punctuationCharacters).joined().filter{!$0.isWhitespace}.lowercased()})
    }
    var validNames: [String]{
        switch self {
        case .fluidOunces:
            return ["fluid ounces", "fl oz", "fluid ozunce", "fluid oz", "fl ounce", "fl ounces"]
        case .teaspoons:
            return ["tsp","tsps","teaspoon","teaspoons"]
        case .tablespoons:
            return ["tbsp", "tbsps", "tablespoon", "tablespoons"]
        case .quarts:
            return ["quart", "quarts", "qt", "qts"]
        case .cups:
            return ["cup", "cups"]
        case .liters:
            return ["l", "liter", "liters", "litre", "litres"]
        case .milliliters:
            return ["ml", "milliliter", "milliliters"]
        }
    }
    var abbreviation: String{
        switch self {
        case .fluidOunces:
            return "fl oz"
        case .teaspoons:
            return "tsp"
        case .tablespoons:
            return "tbsp"
        case .quarts:
            return "quart"
        case .cups:
            return "cup"
        case .liters:
            return "L"
        case .milliliters:
            return "mL"
        }
    }

}


public struct FoodItemMeasure: Codable, Hashable{
    
    static let commonWeightMeasures: [MassMeasure: UnitMass] = [.grams: .grams, .milligrams : .milligrams,.ounces: .ounces,  .pounds: .pounds]
    
    static let commonVolumeMeasures: [VolumeMeasure: UnitVolume] = [.milliliters: .milliliters, .fluidOunces:.fluidOunces,
                                                                    .teaspoons: .teaspoons,
                                                                    .tablespoons: .tablespoons,
                                                                    .quarts: .quarts,
                                                                    .cups:.init(symbol: "cup", converter: UnitConverterLinear(coefficient: 0.236588)),
                                                                        .liters:.liters]
    public var unitWeight: Double?{
        guard let servingWeight = self.servingWeight else {return nil}
        
        return servingWeight/quantity
    }
    
    public var measure: String
    public var quantity: Double
    public var seq: Double?

    internal init(measure: String, quantity: Double, seq: Double? = nil, servingWeight: Double? = nil) {
        if let massMeasure = MassMeasure.getInstanceByAbbreviation(measure){
            self.measure = massMeasure.abbreviation
        } else if let volumeMeasure = VolumeMeasure.getInstanceByAbbreviation(measure){
            self.measure = volumeMeasure.abbreviation
        } else{
            self.measure = measure
        }
        self.quantity = quantity
        self.seq = seq
        self.servingWeight = servingWeight
    }
    
    
    
    /// all possible measurements that this FoodItemMeasure can be converted to (including itself)
    public var derivedMeasures: [FoodItemMeasure]{
        let massDerived = self.derivedMassMeasures()
//        FoodItemMeasure.getAllMassMeasures(baseUnit: .grams)
            var volumeDerived: [FoodItemMeasure] = []
        let originalVolumeMeasure = self.volumeUnits != nil ? self : nil
        
        if let firstVolumeUnit = originalVolumeMeasure, let volumeMeasure = firstVolumeUnit.volumeMeasure{
            volumeDerived = FoodItemMeasure.getAllDerivedVolumeMeasures(massOfCurrentUnitInGrams: firstVolumeUnit.servingWeight, volumeInCurrentUnits: firstVolumeUnit.quantity, currentVolumeUnits: volumeMeasure)
            }
            var allDerived = massDerived + volumeDerived
            if !allDerived.contains(where: {$0.measure == self.measure}){
                allDerived.append(self)
            }
            return allDerived
    }
    
    ///the corresponding `UnitVolume` to this `FoodItemMeasure`'s measure string, if this `FoodItemMeasure` is in volume.
    public var volumeUnits : UnitVolume?{
        guard let volumeMeasureInstance = volumeMeasure else {return nil}
        return FoodItemMeasure.commonVolumeMeasures[volumeMeasureInstance]
    }
    public var volumeMeasure: VolumeMeasure?{
        VolumeMeasure.getInstanceByAbbreviation(self.measure)
    }
    ///the corresponding `UnitMass` to this `FoodItemMeasure`'s measure string, if this `FoodItemMeasure` is measured in mass units.
    public var unitMass : UnitMass?{
        guard let massMeasurementInstance = massMeasurement else {return nil}
        return FoodItemMeasure.commonWeightMeasures[massMeasurementInstance]
    }
    
    public var massMeasurement : MassMeasure?{
        if let measure = MassMeasure.getInstanceByAbbreviation(self.measure){
            return measure
        } else if let servingWeightInGrams = self.servingWeight{
            return MassMeasure.getInstanceByAbbreviation("g")
        } else{
            return nil
        }
    }
    
     /**
      This will essentially multiply `self`'s quantity by the scale factor of `self.units`/`newUnits`.
      For example. If `self` has a `quantity` of 2 kg, and we  call `self.quantityIn(newUnit: "g")`, the result will be 2000.
      
      - Parameter newUnit : The units you want to scale to.
      
      - Returns: a new quantity in terms of `newUnit`
      */
    public func quantityIn(newUnit: String) -> Double?{
        guard let otherMeasure = derivedMeasures.first(where: {$0.measure == newUnit}) else{
            return nil
        }
        
        guard let scaleFactor = otherMeasure.scaleFactor(otherMeasure: self) else {return nil}
        return self.quantity * scaleFactor
    }
    public func quantityIn(newUnit: String, validMeasures: [FoodItemMeasure]) -> Double?{
        if quantity == 0 {return 0}
        guard let otherMeasure = validMeasures.first(where: {$0.measure == newUnit}) else{
            return nil
        }
        
        guard let scaleFactor = otherMeasure.scaleFactor(otherMeasure: self) else {return nil}
        return self.quantity * scaleFactor
    }
    public func changedTo(otherMeasure: FoodItemMeasure) -> Double?{
        guard let scaleFactor = scaleFactor(otherMeasure: otherMeasure) else {return nil}
        return self.quantity * scaleFactor
    }
    /// multiplies the quantity and the serving size by `factor`
    public func scaled(by factor: Double) -> FoodItemMeasure{
        let servingWeight = self.servingWeight == nil ? nil : self.servingWeight! * factor
        return FoodItemMeasure(measure: self.measure, quantity: self.quantity * factor, seq: self.seq, servingWeight: servingWeight)
    }
    /// simply returns the conversion factor  of `self`'s units and `otherUnit`. so if `self.measure` is "g" (grams), and `otherMeasure` is "kg", we return 1000g/kg.
    public func scaleFactor(otherMeasure: FoodItemMeasure) -> Double?{
        // the two measures are equivalent and don't have any serving weights
        if self.measure == otherMeasure.measure && self.servingWeight == nil && otherMeasure.servingWeight == nil{
            return 1
        }
        // for other mass measures.
        // if they both have a serving weight -> just return the ratio between their unit weight's
        else if let unitWeight = unitWeight, let otherMeasureUnitWeight = otherMeasure.unitWeight {
            return otherMeasureUnitWeight/unitWeight
        }
        //if self is mass and other is mass -> find conversion factor in the common mass
        else if let massMeasurement = unitMass, let otherMeasureMassMeasurement = otherMeasure.unitMass {
          return  massMeasurement.converter.value(fromBaseUnitValue: 1) / otherMeasureMassMeasurement.converter.value(fromBaseUnitValue: 1)
        }
        //if self is volume and other is volume -> find conversion factor in the common volume
        else if let volumeMeasurement = volumeUnits, let otherMeasureVolumeMeasurement = otherMeasure.volumeUnits {
            
            return volumeMeasurement.converter.value(fromBaseUnitValue: 1) / otherMeasureVolumeMeasurement.converter.value(fromBaseUnitValue: 1)
        }


        // self, other, or both do not match in their king. The remaining combos are
        //(mass, vol), (custom, custom), (mass,custom), (vol,custom), or the reverse of these. None of these are addressable
        else {
            return nil
        }
        
    }
    
    ///returns true if the given unitName corresponds to a derivable unit. For example "fl oz" and  "fl. oz" can be derived to be the fluidOunces UnitVolume
    public func usesServingUnit(_ unitName: String) -> Bool{
        if self.measure.lowercased() == unitName.lowercased(){
            return true
        }
        else if let volumeMeasure = volumeMeasure {
            return VolumeMeasure.getInstanceByAbbreviation(unitName) == volumeMeasure
        }
        else if let massMeasure = self.massMeasurement{
            return MassMeasure.getInstanceByAbbreviation(unitName) == massMeasure
        }
        else {
            return false
        }
    }
    ///the serving weight in grams, if available
    public var servingWeight: Double?

    static func getVolumeMeasure(massOfCurrentUnitInGrams: Double?, volumeInCurrentUnit: Double, currentUnit: VolumeMeasure, desiredUnit: VolumeMeasure) -> FoodItemMeasure?{
        guard let currentVolumeUnit = commonVolumeMeasures[currentUnit] else{return nil}
        guard let desiredVolume  = commonVolumeMeasures[desiredUnit] else {return nil}
        // note these are all metric units for tsp, fl oz, etc. need to check with nix if they use imperial versions of these
        let currentVolumeMeasure = Measurement(value: volumeInCurrentUnit, unit: currentVolumeUnit)
        let desiredVolumeMeasure = currentVolumeMeasure.converted(to: desiredVolume)
        if let massOfCurrentUnitInGrams = massOfCurrentUnitInGrams {
            let gramsPerDesiredUnit = (massOfCurrentUnitInGrams/volumeInCurrentUnit) * (currentVolumeMeasure.value/desiredVolumeMeasure.value)
            return FoodItemMeasure(measure: desiredUnit.abbreviation, quantity: 1, seq: nil, servingWeight: gramsPerDesiredUnit)
        }
        return FoodItemMeasure(measure: desiredUnit.abbreviation, quantity: 1, seq: nil, servingWeight: nil)
    }
    //
    public func derivedMassMeasures() -> [FoodItemMeasure]{
        if let massUnit = self.unitMass{
            return FoodItemMeasure.commonWeightMeasures.map{(commonMassMeasure,commonMeasureUnitMass) -> FoodItemMeasure in
                let measurement = Measurement(value: self.quantity, unit: massUnit)
                let massInGrams = measurement.converted(to: .grams).value
                let massInNewUnit = measurement.converted(to: commonMeasureUnitMass).value
                return FoodItemMeasure(measure: commonMassMeasure.abbreviation, quantity: massInNewUnit, seq: nil, servingWeight: massInGrams)
            }
        } else if let servingWeightInGrams = servingWeight {
            return FoodItemMeasure.commonWeightMeasures.map{(commonMassMeasure,commonMeasureUnitMass) -> FoodItemMeasure in
                let measurement = Measurement(value: servingWeightInGrams, unit: UnitMass.grams)
                let massInGrams = measurement.value
                let massInNewUnit = measurement.converted(to: commonMeasureUnitMass).value
                return FoodItemMeasure(measure: commonMassMeasure.abbreviation, quantity: massInNewUnit, seq: nil, servingWeight: massInGrams)
            }
        }
        return []
    }
    //
    public static func getAllDerivedVolumeMeasures(massOfCurrentUnitInGrams grams: Double?, volumeInCurrentUnits: Double, currentVolumeUnits: VolumeMeasure) -> [FoodItemMeasure]{
        return commonVolumeMeasures.keys.map{getVolumeMeasure(massOfCurrentUnitInGrams: grams, volumeInCurrentUnit: volumeInCurrentUnits, currentUnit: currentVolumeUnits, desiredUnit: $0)}.compactMap{$0}
    }
    public static func getDerivedMassMeasure(amountInGrams: Double, desiredUnit: MassMeasure) -> FoodItemMeasure?{
        guard let desiredMeasure = commonWeightMeasures[desiredUnit] else {return nil}
        let measurement = Measurement(value: amountInGrams, unit: UnitMass.grams)
        let finalMeasurement = measurement.converted(to: desiredMeasure)
        
        return FoodItemMeasure(measure: desiredUnit.abbreviation, quantity: 1, seq: nil, servingWeight: finalMeasurement.value)
    }
    public static func getAllMassMeasures(baseUnit: UnitMass = .grams) -> [FoodItemMeasure]{
        var measures: [FoodItemMeasure] = []
        return commonWeightMeasures.map{(name, unit) in
            let measurement = Measurement(value: 1, unit: unit)
            let gramsPerUnit = measurement.converted(to: baseUnit).value
            return FoodItemMeasure(measure: name.abbreviation, quantity: 1, seq: nil, servingWeight: gramsPerUnit)
        }
//        return commonWeightMeasures.keys.map{getMassMeasure(amountInGrams: 1, desiredUnit: $0)}.compactMap{$0}
    }

    
    enum CodingKeys: String, CodingKey{
        case measure
        case quantity = "qty"
        case seq
        case servingWeight = "serving_weight"
    }
}

//extension Array where Element == FoodItemMeasure{
//    func withInferredUnits() -> Self{
//        //check which weight units are already contained
//        let lowercasedWeightMeasures = FoodItemMeasure.commonWeightMeasures.map{$0.lowercased()}
//        let uncontainedUnits = lowercasedWeightMeasures.filter { unitString in
//            !self.contains { $0.measure == unitString}
//        }
//
//        // for each commonWeight that is not already contained
//        for unit in uncontainedUnits{
//            let someAlreadyExistentMeasure = self.first(where: {measure in lowercasedWeightMeasures.contains(where: {$0 == measure.measure})})!
//
//        }
//            //add that common weight to the result by mapping any of the original weight unit already contained to that which is not contained (if grams present but lb is not, simply instantiate a fooditemmeasure called "lb" with appropriate measure.
//
//        // do the same with volume units
//
//    }
//}

public struct FoodItemPhoto: Codable{
    public var highResUrl: String?
    public var isUserUploaded: Bool?
    public var thumbnail: String?
    
    enum CodingKeys : String, CodingKey {
        case highResUrl = "highres"
        case isUserUploaded = "is_user_uploaded"
        case thumbnail = "thumb"
    }
}
public struct FoodItemThumbnail: Codable{
    public var thumb: String
    enum CodingKeys: String, CodingKey{
        case thumb
    }
}

public struct FullNutrient: Codable, Hashable{
    public init(attributeId: Int, amount: Double) {
        self.attributeId = attributeId
        self.amount = amount
    }
    
    public let attributeId: Int
    public let amount: Double
    
    enum CodingKeys : String, CodingKey {
        case attributeId = "attr_id"
        case amount = "value"
    }
    
}

