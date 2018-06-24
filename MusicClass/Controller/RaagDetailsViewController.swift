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
    var sectionTitles = ["Saptak", "Sargam Geet", "Taal" ,"Jaankari"]
    
    var sectionData = [["sa re ga ma pa da", "ni sa ma pa da" , "da sdfs rt rt"],["ad sad ddd dd ff gg hh nn", "ee rr tt yy uu", "ww ss xx cc vv bb "],["as sd xc vb nm hj yu"],["Matra-8" , "Tali - 1,3,7", "Khali -5", "Khand - 2,2,2,2"]]
    
   // var sargamData = ["ad sad ddd dd ff gg hh nn", "ee rr tt yy uu", "ww ss xx cc vv bb "]
    //var taalData = ["as sd xc vb nm hj yu"]
    //var jaankariData = ["Matra-8" , "Tali - 1,3,7", "Khali -5", "Khand - 2,2,2,2"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("sectiontitle count= \(sectionTitles.count)")
        return  sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].count
    }
    
    /*
    //This method titleForHeaderInSection displays title of Header in section but uses default/Standard Header style, font
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // print("SectionTitle data = \(sectionTitles[section])")
        
        return sectionTitles[section]
    }*/
    
  //This method viewForHeaderInSection displays customised title for section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "raagNewCell") as! CustomViewCell
        headerCell.backgroundColor = UIColor.cyan
        headerCell.headerLabel.text! = sectionTitles[section]
        return headerCell
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raagDetailsCell", for: indexPath)
        print("indexpath.row= \(indexPath.row)")
        cell.textLabel?.text = sectionData[indexPath.section][indexPath.row]
        return cell
    }
    

}
