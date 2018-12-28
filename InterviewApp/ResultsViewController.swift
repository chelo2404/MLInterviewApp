//
//  ResultsViewController.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 12/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    var searchResults = [Dictionary<String, Any>]()
    var details = DetailsDTO()
    
    // MARK: View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private methods
    
    /**
     Performs a GET request to obtain search results based in the keyword introduced by the user.
     
     - Parameter keyword: Search word entered by the user in the search bar.
    */
    func getResultsForKeyword(keyword: String) {
        
        let manager = AFHTTPSessionManager()
        
        // Encode keyword for HTTP request
        let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        // Show loading indicator
        let loadingView = Utils.displayLoadingIndicator(inView: self.resultsTableView)
        
        manager.get(Utils.baseAPIUrl + Utils.searchQuery + encodedKeyword, parameters: nil, progress:nil, success: { (task: URLSessionDataTask!, responseObject: Any!) in
            // Get response as dictionary
            var response = responseObject as! [String : Any]
            
            // Get the list of results from the response
            self.searchResults = response["results"] as! [Dictionary<String, Any>]
            
            // Reload the table view information to show the results
            self.resultsTableView.reloadData()
            
            // Hide loading indicator
            Utils.hideLoadingIndicator(liView: loadingView)
        }) { (operation, error) in
            // Log the error for debugging purposes
            NSLog("An error occurred while performing the search request. %@", error.localizedDescription)
            
            // Hide loading indicator
            Utils.hideLoadingIndicator(liView: loadingView)
            
            // Show a friendly message to the user
            Utils.showErrorAlertWith(message: "There was an error performing the requested search. Please try again in a moment.", inView: self)
        }
    }
    
    
    
    // MARK: UISearchBar Delegate methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            // If a keyword was entered, clean whitespaces
            let search = text.trimmingCharacters(in: .whitespaces)
            
            // Perform the search with the keyword
            getResultsForKeyword(keyword: search)
        }
    }
    
    // MARK: UITableViewDataSource Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "resultDataCell") as! ResultItemTableViewCell
        
        let item = self.searchResults[indexPath.row]
        
        dataCell.titleLabel.text = item[Utils.titleKey] as? String
        
        let price = (item[Utils.priceKey] as? NSNumber)!
        dataCell.priceLabel.text = String(format: "%.2f", price.doubleValue)
        
        dataCell.imageView?.sd_setImage(with: URL(string: item[Utils.thumbnailKey] as! String), placeholderImage: UIImage(named: "loading"), options: SDWebImageOptions.continueInBackground, progress: nil, completed: { (image, error, imageCacheType, url) in
            dataCell.setNeedsLayout()
        })
        
        return dataCell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Workaround to avoid showing wrong image on the table cells while scrolling
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.searchResults[indexPath.row]
        
        // Convert info from JSON to DTO
        self.details = DetailsDTO.DTOFromJSON(jsonObject: item)
        
        // Perform navigation to details screen
        self.performSegue(withIdentifier: Utils.showDetailsNavigation, sender: self)
    }
    
    // MARK: View Controller Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get destination view controller
        let productDetailViewController = segue.destination as! ProductDetailViewController
        
        // Set the info to be shown in the destination view
        productDetailViewController.details = self.details
    }
}
