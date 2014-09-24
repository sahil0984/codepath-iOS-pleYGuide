//
//  ViewController.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

let yelpConsumerKey    = "gEREXv53UYUbIrok3RlCIQ"
let yelpConsumerSecret = "7dc8e_j0BE0qd7__JA86JP8sq8o"
let yelpToken          = "RkUPpRTVWx-_9KPsoFjkGcoX0FJfosVK"
let yelpTokenSecret    = "AXZV3hvDlceqHxoRVc7ww8FuWS4"


class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterViewControllerDelegate {
    var client: YelpClient!
    
    var mySB  = UISearchBar()

    var filtersObj: Filters = Filters()
    
    var businessDictionaries: [NSDictionary] = []
    
    @IBOutlet weak var businessesTableView: UITableView!
    
    var businessList : [Business] = []
    
    
    var categories = ["Bakeries",
        "Beer, Wine & Spirits",
        "Beverage Store",
        "Breweries",
        "Coffee & Tea",
        "Convenience Stores",
        "Desserts",
        "Farmers Market",
        "Food Delivery Services",
        "Food Trucks",
        "Grocery",
        "Ice Cream & Frozen Yogurt",
        "Juice Bars & Smoothies",
        "Specialty Food"]
    
    var categoriesParamString = ["bakeries",
        "beer_and_wine",
        "beverage_stores",
        "breweries",
        "coffee",
        "convenience",
        "desserts",
        "farmersmarket",
        "fooddeliveryservices",
        "foodtrucks",
        "grocery",
        "icecream",
        "juicebars",
        "gourmet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.businessesTableView.dataSource = self
        self.businessesTableView.delegate = self
        self.businessesTableView.rowHeight = UITableViewAutomaticDimension
        
        //var mySB = UISearchBar(frame: CGRectMake(0, 0, 200,44))
        //var mySB  = UISearchBar()
        mySB.delegate = self
        self.navigationItem.titleView = mySB
        //navigationController?.navigationItem.titleView = mm
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("", sortMode: "", radius: "", isDealsOn: "", categories: "", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println(response)

                self.businessDictionaries = response["businesses"] as [NSDictionary]
            
                self.businessList = Business.fromDictionaryArray(self.businessDictionaries)
            
                //self.businessList = self.businessDictionaries.map({ (business: NSDictionary) -> Business in
                //    Business(dictionary: business)
                //})
            
                self.businessesTableView.reloadData()

            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.55)


    }
    
    override func viewWillAppear(animated: Bool) {
        self.businessesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("businessCell") as BusinessTableViewCell
        
        cell.setBusinessCell(businessList[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        println("search now")
        var searchTerm = self.mySB.text
        println("\(searchTerm)")
        
        client.searchWithTerm(searchTerm, sortMode: "", radius: "", isDealsOn: "", categories: "", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            
            self.businessDictionaries = response["businesses"] as [NSDictionary]
            
            self.businessList = Business.fromDictionaryArray(self.businessDictionaries)
            
            //self.businessList = self.businessDictionaries.map({ (business: NSDictionary) -> Business in
            //    Business(dictionary: business)
            //})
            
            self.businessesTableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
        view.endEditing(true)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var filtersNavigationController = segue.destinationViewController as UINavigationController
        var filterViewController = filtersNavigationController.viewControllers[0] as FiltersViewController
        
        
        

        var categoriesDictionary = [self.categories[0]  : false,
            self.categories[1]  : false,
            self.categories[2]  : false,
            self.categories[3]  : false,
            self.categories[4]  : false,
            self.categories[5]  : false,
            self.categories[6]  : false,
            self.categories[7]  : false,
            self.categories[8]  : false,
            self.categories[9]  : false,
            self.categories[10] : false,
            self.categories[11] : false,
            self.categories[12] : false,
            self.categories[13] : false]
        
        if (self.filtersObj.isbestDeal == nil) {
            //var categoriesDictionary : [String:Bool] = [String:Bool]()
            filterViewController.filtersObj = Filters(isbestDeal: false, radius: 0, sortBy: 0, categoriesDictionary: categoriesDictionary)
            println("new filtersObj")
            println("a \(filtersObj.radius)")
        } else {
            filterViewController.filtersObj = self.filtersObj
            println("old filtersObj")
            println("b \(filtersObj.radius)")
        }
        
        filterViewController.delegate = self
    }

    func searchTermDidChange(filtersObj : Filters) {
        self.filtersObj = filtersObj

        var sortByString = "\(filtersObj.sortBy!)"
        
        var distArray = [0.2, 0.5, 1.0, 5.0]
        var radiusString = "\(distArray[filtersObj.radius!]*1609.34)"
        
        var isDealsOnString: String
        if filtersObj.isbestDeal! {
            isDealsOnString = "true"
        } else {
            isDealsOnString = "false"
        }

        var searchTerm = self.mySB.text
        println("\(searchTerm)")
        
        
        //if (filtersObj.categoriesDictionary[]
        var categoryString = "p+"
        for (var i=0; i<filtersObj.categoriesDictionary?.count; i++ ) {
//            if filtersObj.categoriesDictionary?[categories[i]]! == true {
//                categoryString = categoryString + categoriesParamString[i]
//            }
            
            if let cat = filtersObj.categoriesDictionary {
                if cat[categories[i]] == true {
                    categoryString = categoryString + "+" + categoriesParamString[i]
                }
            }
        }
        categoryString = categoryString.stringByReplacingOccurrencesOfString("p++", withString: "")
        categoryString = categoryString.stringByReplacingOccurrencesOfString("p+", withString: "")
        
        //Yelp client call
        //client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        
        client.searchWithTerm(searchTerm, sortMode: sortByString, radius: radiusString, isDealsOn: isDealsOnString, categories: categoryString, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            
            self.businessDictionaries.removeAll(keepCapacity: true)
            
            self.businessDictionaries = response["businesses"] as [NSDictionary]
            
            self.businessList = Business.fromDictionaryArray(self.businessDictionaries)
            
            self.businessesTableView.reloadData()
            
            println("categories: \(categoryString)")
            println("\(operation)")

            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    
}

