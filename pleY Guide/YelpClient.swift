//
//  YelpClient.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }

    
    
    func searchWithTerm(term: String, sortMode: String, radius: String, isDealsOn: String, categories: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        var parameters = ["location": "San Francisco"]
//        var parameters = ["term": term,
//                          "location": "San Francisco",
//                          "sort": sortMode,
//                          "radius_filter": radius,
//                          "deals_filter": isDealsOn,
//                          "category_filter": categories]
        
        if term != "" {
            parameters.updateValue(term, forKey: "term")
        }
        if sortMode != "" {
            parameters.updateValue(sortMode, forKey: "sort")
        }
        if radius != "" {
            parameters.updateValue(radius, forKey: "radius_filter")
        }
        if isDealsOn != "" && isDealsOn != "false" {
            parameters.updateValue(isDealsOn, forKey: "deals_filter")
        }
        if categories != "" {
            parameters.updateValue(categories, forKey: "category_filter")
        }
        
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
    
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term,
                          "location": "San Francisco"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}

