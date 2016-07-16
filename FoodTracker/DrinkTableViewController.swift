//
//  DrinkTableViewController.swift
//  StarbucksDrinkTracker
//
//  Created by Joohan Oh on 2016-03-01.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit

class DrinkTableViewController: UITableViewController {

    // MARK: Properties
    
    var drinks = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise load sample data.
        if let savedDrinks = loadDrinks() {
            drinks += savedDrinks
        }
        else {
            // Load the sample data.
            loadSampleDrinks()
        }
    }
    
    func loadSampleDrinks() {
        let photo1 = UIImage(named: "drink1")!
        let drink1 = Drink(name: "Iced Coffee with Milk", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "drink2")!
        let drink2 = Drink(name: "Iced Coffee", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "drink3")!
        let drink3 = Drink(name: "Cool Lime Starbucks Refreshers", photo: photo3, rating: 3)!
        
        drinks += [drink1, drink2, drink3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DrinkTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DrinkTableViewCell
        
        // Fetches the appropriate drink for the data source layout.
        let drink = drinks[indexPath.row]

        cell.nameLabel.text = drink.name
        cell.photoImageView.image = drink.photo
        cell.ratingControl.rating = drink.rating

        return cell
    }
    
    @IBAction func unwindToDrinkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? DrinkViewController, drink = sourceViewController.drink {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing drink.
                drinks[selectedIndexPath.row] = drink
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                // Add a new drink.
                let newIndexPath = NSIndexPath(forRow: drinks.count, inSection: 0)
                drinks.append(drink)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the drinks.
            saveDrinks()
        }
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            drinks.removeAtIndex(indexPath.row)
            saveDrinks()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */


    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let drinkDetailViewController = segue.destinationViewController as! DrinkViewController
            
            // Get the cell that generated this segue.
            if let selectedDrinkCell = sender as? DrinkTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedDrinkCell)!
                let selectedDrink = drinks[indexPath.row]
                drinkDetailViewController.drink = selectedDrink
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new drink.")
        }
    }
    
    // MARK: NSCoding
    func saveDrinks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(drinks, toFile: Drink.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save drinks...")
        }
}
    func loadDrinks() -> [Drink]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Drink.ArchiveURL.path!) as? [Drink]
    }
}


