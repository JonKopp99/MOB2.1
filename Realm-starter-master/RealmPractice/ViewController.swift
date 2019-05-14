//
//  ViewController.swift
//  RealmPractice
//
//  Created by Adriana González Martínez on 5/2/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var books = [Book]()
    var tableView = UITableView()
    var realm = try! Realm()
    let store = BookStore()
    var searchBar = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        store.realm = realm
        //TODO: Create a book
        //A Game of Thrones (A Song of Ice and Fire #1)
        //George R. R. Martin"
        //1997
//        let book = Book()
//        book.author = "George R. Martin"
//        book.title = "Game of Thrones"
//        book.year = 1997
        //TODO: Save the book
//        try! realm.write {
//            realm.add(book)
//        }
        
        //TODO: Find the book by title, print the result.
        fetchAllBooks()
    
        searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width * 0.7, height: self.view.bounds.height * 0.1)
        searchBar.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        searchBar.layer.cornerRadius = 20
        searchBar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchBar.layer.cornerRadius = 2
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        self.view.addSubview(searchBar)
        
        tableView.register(bookCell.self, forCellReuseIdentifier: "savedCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: self.view.bounds.height * 0.1, width: self.view.bounds.width, height: self.view.bounds.height - self.view.bounds.height * 0.1)
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        let b = UIButton(frame: CGRect(x: searchBar.frame.maxX + 30, y: searchBar.frame.midY, width: 60, height: 25))
        b.setTitle("ADD", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.addTarget(self, action: #selector(addBook), for: .touchUpInside)
        self.view.addSubview(b)
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchAllBooks()
    }
    @objc func addBook()
    {
        self.present(createBook(), animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBook(title: searchBar.text!)
        textField.resignFirstResponder()
        return true
    }
    func fetchAllBooks()
    {
        self.books = []
        let theBooks = realm.objects(Book.self)
        for i in theBooks{
            let newBook = Book()
            newBook.author = i.author
            newBook.title = i.title
            newBook.year = i.year
            self.books.append(newBook)
        }
        print(theBooks)
        tableView.reloadData()
    }
    
    func searchBook(title: String)
    {
        if(title.isEmpty){
            fetchAllBooks()
            return
        }
        let pred = NSPredicate(format: "title == %@", title)
        let theBooks = realm.objects(Book.self).filter(pred)
        self.books = []
        for i in theBooks{
            let newBook = Book()
            newBook.author = i.author
            newBook.title = i.title
            newBook.year = i.year
            self.books.append(newBook)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Delete from tb and remove from defaults!
        if editingStyle == .delete{
            let book = books[indexPath.row]
            let pred = NSPredicate(format: "title == %@", book.title)
            let results =  realm.objects(Book.self).filter(pred)
            try! realm.write {
                realm.delete(results[0])
            }
            self.books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookCell()
        cell.nameOfSong.text = books[indexPath.row].title
        cell.nameOfArtist.text = books[indexPath.row].author
        cell.difficulty.text = "\(books[indexPath.row].year)"
        return cell
    }

}

