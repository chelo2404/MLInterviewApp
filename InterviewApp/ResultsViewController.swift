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
    
    var textFromSearchView = ""
    var apiUrl = "https://api.mercadolibre.com/sites/MLA"
    var searchResults = [Dictionary<String, Any>]()
    var details = DetailsDTO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // getResultsForKeyword(keyword: self.textFromSearchView)
    }
    
    // MARK - Private methods
    
    func getResultsForKeyword(keyword: String) {
        
        let manager = AFHTTPSessionManager()
        
        manager.get(apiUrl + "/search?q=" + keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, parameters: nil, progress:nil, success: { (task: URLSessionDataTask!, responseObject: Any!) in
            var response = responseObject as! [String : Any]
            
            self.searchResults = response["results"] as! [Dictionary<String, Any>]
            
            self.resultsTableView.reloadData()
        }) { (operation, error) in
            // Implement error handling
        }
    }
    
    // MARK - SearchBar methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let search = text.trimmingCharacters(in: .whitespaces)
            
            // self.searchText = search
            
            // self.performSegue(withIdentifier: "showResults", sender: nil)
            getResultsForKeyword(keyword: search)
        }
    }
    
    // MARK - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = tableView.dequeueReusableCell(withIdentifier: "resultDataCell") as! ResultItemTableViewCell
        
        let item = self.searchResults[indexPath.row]
        
        dataCell.titleLabel.text = item["title"] as? String
        
        let price = (item["price"] as? NSNumber)!
        dataCell.priceLabel.text = String(format: "%.2f", price.doubleValue)
        
        dataCell.imageView?.sd_setImage(with: URL(string: item["thumbnail"] as! String), placeholderImage: nil, options: SDWebImageOptions.continueInBackground, progress: nil, completed: { (image, error, imageCacheType, url) in
            dataCell.setNeedsLayout()
        })
        
        return dataCell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.sd_cancelCurrentImageLoad()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.searchResults[indexPath.row]
        
        self.details = DetailsDTO.DTOFromJSON(jsonObject: item)
        
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // MARK - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailViewController = segue.destination as! ProductDetailViewController
        productDetailViewController.details = self.details
    }
}
