//
//  ViewController.swift
//  tableViewJSON
//
//  Created by Jonathan Kopp on 2/7/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var festivals = [Festival]()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        loadJson()
    }
    
    func loadJson()
    {
        let path = Bundle.main.path(forResource: "file", ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let data = try? Data(contentsOf: url, options: .alwaysMapped)
            let decodedFestivals = try? JSONDecoder().decode([Festival].self, from: data!)
            guard let unwrappedFestivals = decodedFestivals else { return }
            self.festivals = unwrappedFestivals
    }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return festivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tb") as! TableViewCell
        cell.label1.text = festivals[indexPath.row].name
        cell.label2.text = festivals[indexPath.row].date
        let artistCount = festivals[indexPath.row].lineup!.count
        cell.label3.text = ("Artists \(String(describing: artistCount))")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    

}

