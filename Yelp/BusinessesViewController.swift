//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{

    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business]!
    var searchController: UISearchController!
    var filteredData: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        filteredData = businesses
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }

/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
    }
*/
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if filteredData != nil{
             return self.filteredData!.count
        }
        else{
            if let business1 = businesses {
                return business1.count
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
//        if filteredData != nil {
//            cell.business = self.filteredData[indexPath.row]
//        }
//            
//        else {
//            cell.business = businesses[indexPath.row]
//        }
        cell.business = self.filteredData[indexPath.row]
        return cell
    }
    
    
//    func searchBar(SearchBar: UISearchBar, textDidChange searchText: String){
//        filteredData = searchText.isEmpty ? businesses : businesses.filter({(dataString: String) -> Bool in
//        return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            filteredData = businesses
        }
        else {
            filteredData = businesses.filter({(dataItem: Business) -> Bool in
                if dataItem.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
            tableView.reloadData()
        }
    }
    
    
    func searchBarTextBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        if let searchText = searchController.searchBar.text{
            filteredData = searchText.isEmpty ? businesses : businesses.filter({(dataString: Business) -> Bool in
                return dataString.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
            tableView.reloadData()
        }
    }
//
//    func updateSearchResultsForSearchController(searchController: UISearchController){
//        self.filteredData.removeAll()(keepCapacity: false)
//        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
//        let array = (self.businesses as Business).filteredArraysUsingPredicate(searchPredicate)
//        self.filteredData = array as! [String]
//        self.tableView.reloadData()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
