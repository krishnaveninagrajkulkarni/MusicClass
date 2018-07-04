//
//  RaagDetailsViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 21/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework

class RaagDetailsViewController: UITableViewController {
    var titleName = ["JaanKari", "Taal", "Saptak", "Sargam Geet"]
    var raagDetails =  [NewRaagDetails]()
    var storeFetchedData = [String]()  //Empty Array
    let colour = UIColor.flatSkyBlue
    
    var selectedName: String? {
        didSet {
            readRowFromDB()
           // displayTestData()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .none
    
    }

    override func viewWillAppear(_ animated: Bool) {
        //This 'title' is the default title of the view
        title = selectedName
        //coloring the navigation bar into skyblue
        navigationController?.navigationBar.barTintColor = colour
        
        //tintcolor applies to items in the NavigationBar
        navigationController?.navigationBar.tintColor = ContrastColorOf(colour, returnFlat: true)
        
        //coloring the navigation bar 'back' title
       // navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: ContrastColorOf(colour, returnFlat: true)]
        
    
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   storeFetchedData.count
    }
 
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "custCell", for: indexPath) as! CustomViewCell
        
        //cell.textLabel?.text =  storeFetchedData[indexPath.row]
        cell.descriptionLabel.text = storeFetchedData[indexPath.row]
        cell.titleLabel.text = titleName[indexPath.row]
        
        
        if let colourShade = FlatSkyBlue().darken(byPercentage:CGFloat(indexPath.row)/CGFloat(storeFetchedData.count))
        {
            cell.backgroundColor = colourShade
            cell.descriptionLabel.textColor = ContrastColorOf(colourShade, returnFlat: true)
            cell.titleLabel.textColor = ContrastColorOf(colourShade, returnFlat: true)
            //cell.textLabel?.textColor = ContrastColorOf(colourShade, returnFlat: true)
        }
         return cell
    }
    //Fetching a Row from DB
    func readRowFromDB(){
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

    func  displayTestData(){
        for number in storeFetchedData {
            print("%%%%%%%%%%%%%%%%%%%%%%%")
            print(number)
            
        }
    }
}


