//
//  createBook.swift
//  RealmPractice
//
//  Created by Jonathan Kopp on 5/6/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class createBook: UIViewController, UITextFieldDelegate
{
    
    var titleLabel = UITextField()
    var authorLabel = UITextField()
    var year = UITextField()
    var realm = try! Realm()
    let store = BookStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        store.realm = realm
        
        view.backgroundColor = .white
        titleLabel.frame = CGRect(x: 20, y: 50, width: self.view.bounds.width - 40, height: 50)
        titleLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        titleLabel.layer.cornerRadius = 20
        titleLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.layer.cornerRadius = 2
        titleLabel.returnKeyType = .done
        titleLabel.delegate = self
        titleLabel.placeholder = "TITLE"
        self.view.addSubview(titleLabel)
        
        authorLabel.frame = CGRect(x: 20, y: 110, width: self.view.bounds.width - 40, height: 50)
        authorLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        authorLabel.layer.cornerRadius = 20
        authorLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        authorLabel.layer.cornerRadius = 2
        authorLabel.returnKeyType = .done
        authorLabel.delegate = self
        authorLabel.placeholder = "AUTHOR"
        self.view.addSubview(authorLabel)
        
        year.frame = CGRect(x: 20, y: 180, width: self.view.bounds.width - 40, height: 50)
        year.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        year.layer.cornerRadius = 20
        year.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        year.layer.cornerRadius = 2
        year.returnKeyType = .done
        year.delegate = self
        year.placeholder = "YEAR"
        self.view.addSubview(year)
        
        
        let b = UIButton(frame: CGRect(x: self.view.bounds.width / 2 - 30, y: year.frame.maxY + 20, width: 60, height: 25))
        b.setTitle("ADD", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.addTarget(self, action: #selector(addBook), for: .touchUpInside)
        self.view.addSubview(b)
    }
    
    
    @objc func addBook()
    {
        let titleT = titleLabel.text!
        let authorT = authorLabel.text!
        let yearT = year.text!
        print(titleT + " " + authorT + " " + yearT)
        let book = Book()
        book.title = titleT
        book.author = authorT
        book.year = Int(yearT)!
        try! realm.write {
            realm.add(book)
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
