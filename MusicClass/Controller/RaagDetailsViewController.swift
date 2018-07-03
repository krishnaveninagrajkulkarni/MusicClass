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
     var raagDetails =  [NewRaagDetails]()
    var storeFetchedData = [String]()  //Empty Array
    
    
    var selectedName: String? {
        didSet {
            readRowFromDB()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewFecthedData()
    }
/*
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return  sectionTitles.count
    }
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   storeFetchedData.count
    }
    /*
 
  //This method viewForHeaderInSection displays customised title for section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "raagNewCell") as! CustomViewCell
        headerCell.backgroundColor = UIColor.cyan
        headerCell.headerLabel.text! = sectionTitles[section]
        return headerCell
    }
    */
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "raagDetailsCell", for: indexPath) as! CustomViewCell
        // let temporrayData = raagDetails[indexPath.row]
        // cell.textLabel?.text = temporrayData.jaankari! + " " + temporrayData.taal! + " " + temporrayData.saptak!
         // cell.textLabel?.text = storeFetchedData[indexPath.row]
        cell.dataLabel.text = storeFetchedData[indexPath.row]
         return cell
    }
    //Fetching a Row from DB
    func readRowFromDB(){
        print("I am reading from DB")
        let request: NSFetchRequest<NewRaagDetails> = NewRaagDetails.fetchRequest()
        
        let predicate = NSPredicate(format: "raagName==%@ ", selectedName!)
   
        request.predicate = predicate
        do{
            raagDetails = try context.fetch(request)
            
            // prints data from raagDetails
            for task in raagDetails{
                storeFetchedData.append(task.jaankari!)
                storeFetchedData.append(task.taal!)
                storeFetchedData.append(task.saptak!)
                storeFetchedData.append(task.sargamGeet!)
                //storeFetchedData.append(task.raagName!)
               // print("Fetched DAta is \(task.jaankari)")
               // print("Fetched DAta is \(task.taal)")
               // print("Fetched DAta is \(task.saptak)")
            }
        }catch {
            print("Cannot Load Data \(error)")
        }
        tableView.reloadData()
    }

    func addInToLocalArray(){
        
    }
}


