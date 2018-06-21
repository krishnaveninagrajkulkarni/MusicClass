//
//  RaagDetailsViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 21/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData

class RaagDetailsViewController: UITableViewController {
    
    var raagDetails = [RaagDetails]()
    var sectionTitles = ["Saptak", "Sargam Geet", "Tal", "Jaankari"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionTitles.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return raagDetails.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "raagDetailsCell", for: indexPath)
        cell.textLabel?.text = "Hello this is Details Screen"
        return cell
    }
    

}
