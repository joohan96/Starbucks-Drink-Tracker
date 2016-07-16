//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Joohan Oh on 2016-02-13.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit
import XCTest

class StarbucksDrinkTrackerTests: XCTestCase {
    // MARK: StarbucksDrinkTracker Tests
    
    // Tests to confirm that the Drink initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        // Success case.
        let potentialItem = Drink(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        
        // Failure cases.
        let noName = Drink(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Drink(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
    
}
