//
//  ViewController.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 12/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK - UISearchBarDelegate methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let search = text.trimmingCharacters(in: .whitespaces)
            
            self.searchText = search
            
            self.performSegue(withIdentifier: "showResults", sender: nil)
        }
    }
    
    // MARK - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultsViewController = segue.destination as! ResultsViewController
        resultsViewController.textFromSearchView = self.searchText
    }
}

