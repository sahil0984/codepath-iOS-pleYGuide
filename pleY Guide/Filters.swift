//
//  Filters.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import Foundation

class Filters {
    
    
    var isbestDeal    : Bool?
    var radius        : Int?
    var sortBy        : Int?
    var categoriesDictionary      : [String:Bool]?
    
    
    init(isbestDeal: Bool!, radius: Int!, sortBy: Int!, categoriesDictionary: [String:Bool]!) {
        self.isbestDeal = isbestDeal
        self.radius = radius
        self.sortBy = sortBy
        self.categoriesDictionary = categoriesDictionary
    }
    
    init() {
        //Empty constructor

    }
}

//Most Popular
//Offering a Deal
//

//Radius
//2 blocks
//6 blocks
//1 mile
//5 miles

//Sort By
//Best Match
//Rating
//Distance

//General Features
//var categories = ["Bakeries",
//    "Beer, Wine & Spirits",
//    "Beverage Store",
//    "Breweries",
//    "Coffee & Tea",
//    "Convenience Stores",
//    "Desserts",
//    "Farmers Market",
//    "Food Delivery Services",
//    "Food Trucks",
//    "Grocery",
//    "Ice Cream & Frozen Yogurt",
//    "Juice Bars & Smoothies",
//    "Specialty Food"]




