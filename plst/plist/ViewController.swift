//
//  ViewController.swift
//  penist
//
//  Created by Jonathan Kopp on 4/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
var tableView = UITableView()
    var list = Plist(name: "name")
    var peeps = [people]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(list!.getValuesInPlistFile())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(tableView)
        getValuesToPeople()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peeps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! cell
        cell.nameLabel.text = (peeps[indexPath.row].name + "        " + peeps[indexPath.row].score)
        //cell.scoreLabel.text = peeps[indexPath.row].score
        return cell
    }
    func getValuesToPeople()
    {
        let values = list!.getValuesInPlistFile()

        for (_,value) in values!
        {
            let theValue = value as! [[String: AnyObject]]
            for i in theValue
            {
                let name = i["Name"]!
                let score = i["Score"]!
                self.peeps.append(people(name: name as! String, score: score as! String))
            }
        }
        tableView.reloadData()
    }
}
struct people{
    var name: String
    var score: String
}
struct Plist {
    
    enum PlistError: Error {
        
        case FileNotWritten
        case FileDoesNotExist
    }
    
    let name:String
    
    var sourcePath:String? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }
        return path
    }
    
    var destPath:String? {
        guard sourcePath != nil else { return nil }
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (dir as NSString).appendingPathComponent("\(name).plist")
    }
    
    init?(name:String) {
        
        self.name = name
        
        let fileManager = FileManager.default
        
        guard let source = sourcePath else { return nil }
        guard let destination = destPath else { return nil }
        guard fileManager.fileExists(atPath: source) else { return nil }
        
        if !fileManager.fileExists(atPath: destination) {
            
            do {
                try fileManager.copyItem(atPath: source, toPath: destination)
            } catch let error as NSError {
                print("Unable to copy file. ERROR: \(error.localizedDescription)")
                return nil
            }
        }
    }
    
    
    func getValuesInPlistFile() -> NSDictionary?{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSDictionary(contentsOfFile: destPath!) else { return .none }
            return dict
        } else {
            return nil
        }
    }
    
    func getMutablePlistFile() -> NSMutableDictionary?{
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            guard let dict = NSMutableDictionary(contentsOfFile: destPath!) else { return .none }
            return dict
        } else {
            return nil
        }
    }
    
    func addValuesToPlistFile(dictionary:NSDictionary) throws {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: destPath!) {
            if !dictionary.write(toFile: destPath!, atomically: false) {
                print("File not written successfully")
                throw PlistError.FileNotWritten
            }
        } else {
            throw PlistError.FileDoesNotExist
        }
    }
}
