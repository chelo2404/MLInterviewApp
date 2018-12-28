//
//  InterviewAppTests.swift
//  InterviewAppTests
//
//  Created by Gerardo Marcelo Fernandez on 12/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import XCTest
@testable import InterviewApp

class InterviewAppTests: XCTestCase {

    /**
     Test the method to convert the format of a date string in Utils class.
    */
    func testUtilsDateConversion() {
        let testDate = "2038-10-04T04:00:00.000Z"
        let expectedDate = "Mon, Oct 4, \'38"
        let dateConverted = Utils.convertDateFormatFor(value: testDate, from: Utils.fullDateFormat, to: Utils.dayMonthYearFormat)
        
        // Check the converted date has the proper format
        XCTAssertEqual(expectedDate, dateConverted, "The date conversion does not conform the expected format")
    }

    /**
     Test the conversion of a JSON object to a DetailsDTO object.
     */
    func testDetailsDTOConversion() {
        let resultItem = [
            "id": "MLA752196065",
            "title": "Convertidor Smart Android Tv  Box Netflix Youtube Ultra Hd 4k",
            "price": 2699,
            "currency_id": "ARS",
            "buying_mode": "buy_it_now",
            "stop_time": "2038-10-04T04:00:00.000Z",
            "condition": "new",
            "thumbnail": "http://mla-s2-p.mlstatic.com/952600-MLA28329383236_102018-I.jpg",
            "accepts_mercadopago": true,
            "reviews": [
                "rating_average": 3.8,
                "total": 4
            ]
        ] as [String : Any]
        
        let detailsDTO = DetailsDTO.DTOFromJSON(jsonObject: resultItem)
        
        XCTAssertEqual(resultItem["title"] as! String, detailsDTO.title, "Title must match")
        XCTAssertEqual(resultItem["accepts_mercadopago"] as! Bool, detailsDTO.mercadoPago, "Payment method must match")
        XCTAssertEqual(resultItem["thumbnail"] as! String, detailsDTO.thumbnail, "Thumbnail url must match")
        
        let reviews = resultItem["reviews"] as! Dictionary<String, Any>
        let rating = reviews["rating_average"] as! Double
        XCTAssertEqual(rating, detailsDTO.rating, "Rating must match")
    }
    
    /**
     Test the conversion of a JSON object to a DetailsDTO object with an item with empty reviews.
     */
    func testDetailsDTOConversionWithEmptyReview() {
        let resultItem = [
            "id": "MLA752196065",
            "title": "Convertidor Smart Android Tv  Box Netflix Youtube Ultra Hd 4k",
            "price": 2699,
            "currency_id": "ARS",
            "buying_mode": "buy_it_now",
            "stop_time": "2038-10-04T04:00:00.000Z",
            "condition": "new",
            "thumbnail": "http://mla-s2-p.mlstatic.com/952600-MLA28329383236_102018-I.jpg",
            "accepts_mercadopago": true,
            "reviews": [
            ]
        ] as [String : Any]
        
        let detailsDTO = DetailsDTO.DTOFromJSON(jsonObject: resultItem)
        
        XCTAssertEqual(0.0, detailsDTO.rating, "Rating must be zero")
    }

}
