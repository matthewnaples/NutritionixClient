import XCTest
@testable import NutritionixAPI

final class NutritionixAPITests: XCTestCase {
    private let nutritionixService = NutritionixAPI(appKey: "hello", appId: "app id", userId: "0")
    //    private let barcodeExample = "0075450243338" //"851045005013"
    private let barcodeExample = "860003223390"
    private let nixIdExample = "513fc9e73fe3ffd40300109f"
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBarcode() async throws {
        do{
            let response = try await nutritionixService.getFoodByBarcode(upc:"857605004007")
            //        let response = try await nutritionixService.getFoodByNixId(nixId: "5da2cff4a253071c701cbe26")
            //        let responseJson = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            //        let response = try! JSONDecoder().decode(ItemEndpointResponse.self, from: data)
            let item = response.foods[0]
            //        print("claims!")
            
            print("response from barcode lookup \(response.foods.count) | \(response.foods[0].fullNutrients?.count) ----")
            print(response.foods[0].fullNutrients)
            print("----")
            let response2 = try await nutritionixService.getFoodByNixId(nixId: item.nixItemId)
            
            print("response from item nixId lookup \(response2.foods.count) \(response2.foods[0].fullNutrients?.count) ----")
            print(response2.foods[0].fullNutrients)
            
            
            //        print(item.claims)
            
            //        print("barcode+++++++++++++++++++")
            //        print(response)
        } catch let error as NutritionixAPIError{
            XCTFail(error.description)
        }
    }
    func testNixId() async throws{
        let response = try await nutritionixService.getFoodByNixId(nixId: "5aec066b001cc2732453450c")
        //        let response = try! JSONDecoder().decode(ItemEndpointResponse.self, from: data)
        //        let responseJson = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        //        print("Nix Id+++++++++++++++++++")
        
        //        print(response)
    }
    
    func testInstantSearch() async throws{
        let instantSearchResponse = try await nutritionixService.getFoodsByInstantSearch(query: "grilled cheese",
                                                                                         foodTypes: [.common],
                                                                                         includeNutrientDetails: false,
                                                                                         includeHealthLabelClaims: true)
        print("InstantSearch+++++++++++++++++++")
        print(instantSearchResponse)
        
    }
    
    func testNaturalLanguage() async throws{
        
        let data = try await nutritionixService.getFoodsWithNaturalLanguage(query: "green bell pepper")
        print(data.foods.first!.fullNutrients)
        
        //        let responseJson = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        print("Natural language+++++++++++++++++++")
        //        print(responseJson)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
