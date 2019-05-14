//
//  ViewController.swift
//  plants
//
//  Created by Adriana González Martínez on 4/21/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var managedContext: NSManagedObjectContext!
    var mainPlant : Plant?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var dates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Water log"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
        let plantSpecies = "Cactus"
        let plantSearch: NSFetchRequest<Plant> = Plant.fetchRequest()
        plantSearch.predicate = NSPredicate(format: "%K == %@", #keyPath(Plant.species), plantSpecies)
        
        do {
            let results = try managedContext.fetch(plantSearch)
            if results.count > 0 {
                // cactus found
                mainPlant = results.first
            } else {
                // not found, create cactus
                mainPlant = Plant(context: managedContext)
                mainPlant?.species = plantSpecies
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
        }
    }

    @IBAction func addLog(_ sender: Any) {
        dates.append(Date())
        let waterDate = WaterDate(context: managedContext)
        waterDate.date = NSDate()
        
        //add it to the Plant's dates set
        
        if let plant = mainPlant, let dates = plant.waterDates?.mutableCopy() as? NSMutableOrderedSet {
            dates.add(waterDate)
            plant.waterDates = dates
        }
        
        //save the managed object context
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = mainPlant?.waterDates?.count
        {
            return count
        }
        return 0

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if(indexPath.row < (mainPlant?.waterDates?.count)!)
            {
                let obj = mainPlant?.waterDates?[indexPath.row] as! NSManagedObject
                managedContext.delete(obj)
                mainPlant?.waterDates?.removeObject(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = mainPlant?.waterDates![indexPath.row] as! WaterDate
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dateFormatter.string(from: date.date! as Date)

        
        return cell
    }
    
}

