//
//  business.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import Foundation

class Business {
    var name              : String
    var address           : String?
    var thumbnailImageURL : String?
    var ratingURL         : String?
    var reviewCount       : Int?
    var categories        : [String] = []
    
    init(name: String!, address: String!, thumbnailImageURL: String!, ratingURL: String, reviewCount: Int, categories:[String]!) {
        self.name = name
        self.address = address
        self.thumbnailImageURL = thumbnailImageURL
        self.ratingURL = ratingURL
        self.reviewCount = reviewCount
        self.categories = categories
    }
    
    init() {
        //Empty constructor
        self.name = ""
    }
    
    //From codepath class
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as String
        //address =
        thumbnailImageURL = dictionary["image_url"] as? String
        ratingURL = dictionary["rating_img_url"] as? String
        reviewCount = dictionary["review_count"] as? Int
        //categories =
        
        
        var location = dictionary["location"] as NSDictionary
        var addressParts = dictionary["display_address"] as? [String]
        address = ""
        for part in addressParts! {
            address = address! + part + " "
        }
        
        
        var categoryGroups = dictionary["categories"] as [[String]]
        for (var i=0; i<categoryGroups.count; i++) {
            categories.append(categoryGroups[i][0])
        }

    }
    
    //My implementation
    class func fromDictionaryArray(tt : [NSDictionary])->[Business] {
        
        var businesses :[Business] = []
        
        for (var i=0; i<tt.count; i++) {
            //
            var businessJSONObj = tt[i]
            
            businesses.append(fromJSON(businessJSONObj))
        }
        
        return businesses
    }
    
    class func fromJSON(jsonObj :NSDictionary)->Business {
        var businessObj :Business = Business()
        
        businessObj.name = jsonObj["name"] as String
        var location = jsonObj["location"] as NSDictionary
        var addressParts = location["display_address"] as [String]
        businessObj.address = ""
        for part in addressParts {
            businessObj.address = businessObj.address! + part + " "
        }
        
        businessObj.thumbnailImageURL = jsonObj["image_url"] as? String
        
        businessObj.ratingURL = jsonObj["rating_img_url"] as? String
        
        businessObj.reviewCount = jsonObj["review_count"] as? Int
        
        var categoryGroups = jsonObj["categories"] as [[String]]
        for (var i=0; i<categoryGroups.count; i++) {
            businessObj.categories.append(categoryGroups[i][0])
        }
        
        return businessObj
    }
    
}