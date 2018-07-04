//
//  RaagsTableViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 21/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData
import ChameleonFramework


class RaagsTableViewController: UITableViewController, sendDataToRaagTable {
    
    //Creating an empty array
    var raagNames = [NewRaagDetails]()
    var localRaagName = [String]()
   
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This removes the separator lines from TableView, this is done as we have added random colors to each cell using chameleon framework, so to make to more clean, we remove the default separators.
        tableView.separatorStyle = .none
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        readTheDataFromNewRaagDetailsTable()
    }
    
    //Mark - Protocol Conformation by defining the Delegate Method
    func delegateMethodOfNewRaag(data: String){
        /* let newRaag = NewRaagDetails(context: context)
        newRaag.raagName = data
        raagNames.append(newRaag)*/
      
        localRaagName.append(data)
        print("Added New RaagName on Table Screen")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let color = UIColor.flatSkyBlue
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.tintColor = ContrastColorOf(color, returnFlat: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToNewRaag" {
            let destinationVC = segue.destination as! NewRaagViewController
            destinationVC.sendDataDelegate = self
            
        }else if segue.identifier == "goToRaagDetails" {
            let destinationVC = segue.destination as! RaagDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedName = localRaagName[indexPath.row]
            }
        }
    }
    // MARK:- Tableview DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localRaagName.count
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raagCells", for: indexPath)
        let colour = UIColor.randomFlat
        cell.backgroundColor = colour                      //randomflat is taken from chameleonFrameWork
        cell.textLabel?.text = localRaagName[indexPath.row]
        cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
        return cell
    }
    
    //Mark:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            context.delete(raagNames[indexPath.row])                    //Delete the data from DB
            raagNames.remove(at: indexPath.row)
            saveRaags()
            
            localRaagName.remove(at: indexPath.row)                     //Delete the data from Array "localRaagName"
            tableView.deleteRows(at: [indexPath], with: .fade)          //Delete the cell from Tableview
        }
    }
    
    //Mark - Save the Data in DB Table - Raags
    func saveRaags()
    {
        do{
            try context.save()
        }catch{
            print("Error while saving!! \(error)")
        }
    }
    
    //Fetching the entire column from DB
    func readTheDataFromNewRaagDetailsTable()
    {
        let request : NSFetchRequest<NewRaagDetails> = NewRaagDetails.fetchRequest()
        
        do{
            let dataRead = try context.fetch(request)
            //Append in raagNames Array only all RaagNames fetcted from NewRaagDetails DB
            for task in dataRead{
                localRaagName.append(task.raagName!)
            }
            raagNames = dataRead
        }catch {
            print("Cannot Load Data \(error)")
        }
    }
    
}
