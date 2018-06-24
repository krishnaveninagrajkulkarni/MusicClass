//
//  RaagsTableViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 21/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData

class RaagsTableViewController: UITableViewController {
    
    //Creating an empty array of class Raags
    var raagNames = [Raags]()           
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        readTheDataFromDB()
    }

   
    // MARK:- Tableview DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raagNames.count
    }
    
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raagCells", for: indexPath)
        cell.textLabel?.text = raagNames[indexPath.row].raagName
        return cell
    }
    
    //Mark:- TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            context.delete(raagNames[indexPath.row])
            saveRaags()                                              //Delete the data from DB only when save Context is called
            
            raagNames.remove(at: indexPath.row)                     //Delete the data from Array "raagNames"
            tableView.deleteRows(at: [indexPath], with: .fade)      //Delete the cell from Tableview
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // performSegue(withIdentifier: "goToRaagDetails", sender: self)
    }
/*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC =  segue.destination as! RaagDetailsViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedRaag = raagNames[indexpath.row].raagName
        }
    }*/
    
    //Mark:- Add Button Method
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFieldData = UITextField()
        let alert = UIAlertController(title: "Add New Raag", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            //Add code once Add is Pressed
            let newRaag = Raags(context: self.context)
            newRaag.raagName = textFieldData.text!
            self.raagNames.append(newRaag)                          //adding newRaag to Global Array "raagNames"
            self.saveRaags()
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            //Write code for TextField
            alertTextField.placeholder = "Create a New Raag"
            textFieldData = alertTextField
        }
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
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
    func readTheDataFromDB()
    {
        let request : NSFetchRequest<Raags> = Raags.fetchRequest()
        
        do{
            raagNames = try context.fetch(request)
            
        }catch {
            print("Cannot Load Data \(error)")
        }
    }
    
    func deleteDataFromDB()
    {
        
    }

}
