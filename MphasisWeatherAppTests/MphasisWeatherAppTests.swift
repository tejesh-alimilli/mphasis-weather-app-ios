//
//  MphasisWeatherAppTests.swift
//  MphasisWeatherAppTests
//
//  Created by user267483 on 8/22/24.
//

import XCTest
@testable import MphasisWeatherApp

final class MphasisWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGeoCodingServiceWithInvalidApiKey() async throws {
        // save invalid API key to allow service to fail
        AppState.shared.apiKey = "123456"
        let cityInfo = await WebService.shared.getGeoCodingInfo(cityName: "Old Bridge")
        XCTAssertNil(cityInfo)
    }

    func testGeoCodingServiceWithApiKey() async throws {
        // hardcoding api key to allow testing of service
        // can use the same hardocing in the app and remove the screen to input api key from user, but too late for the change
        let keyArr = [53, 52, 53, 55, 49, 49, 48, 101, 98, 99, 57, 49, 49, 102, 50, 56, 52, 55, 98, 51, 99, 54, 51, 100, 101, 97, 52, 98, 97, 53, 100, 53]
        var key = ""
        for k in keyArr {
            let s = Character(UnicodeScalar(k)!)
            key.append(s)
        }
        AppState.shared.apiKey = key
        let cityInfo = await WebService.shared.getGeoCodingInfo(cityName: "Old Bridge")
        XCTAssertNotNil(cityInfo)
        XCTAssertNotNil(cityInfo?.name)
    }
}
