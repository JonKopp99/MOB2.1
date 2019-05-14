//
//  ViewController.swift
//  keyChainExample
//
//  Created by Jonathan Kopp on 4/10/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController, UITextFieldDelegate{
    var textField = UITextField()
    var label2 = UILabel()
    var b2 = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textField.frame = CGRect(x: 10, y: 100, width: self.view.bounds.width - 20, height: 50)
        textField.textColor = .black
        textField.placeholder = "Enter your message here!"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textField.layer.borderWidth = 1.5
        self.view.addSubview(textField)
        
        let b = UIButton()
        b.frame = CGRect(x: self.view.bounds.width / 2 - 75, y: textField.frame.maxY + 25, width: 150, height: 50)
        b.setTitle("Save", for: .normal)
        b.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        b.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        self.view.addSubview(b)
        
        b2.frame = CGRect(x: 10, y: b.frame.maxY, width: self.view.bounds.width - 10, height: 50)
        b2.setTitle("Press to Sync to iCloud", for: .normal)
        b2.setTitleColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), for: .normal)
        
        b2.addTarget(self, action: #selector(syncPressed), for: .touchUpInside)
        self.view.addSubview(b2)
        
        let label = UILabel()
         label.frame = CGRect(x: 10, y: b2.frame.maxY, width: self.view.bounds.width - 20, height: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "The current message is:"
        self.view.addSubview(label)
        
        label2.frame = CGRect(x: 10, y: label.frame.maxY, width: self.view.bounds.width - 20, height: 50)
        label2.textColor = .black
        label2.textAlignment = .center
        label2.text = getMessage()
        label2.numberOfLines = 0
        self.view.addSubview(label2)
        
        let b3 = UIButton()
        b3.frame = CGRect(x: self.view.bounds.width / 2 - 75, y: label2.frame.maxY, width: 150, height: 50)
        b3.setTitle("Delete", for: .normal)
        b3.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .normal)
        b3.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        self.view.addSubview(b3)
        
    }

    @objc func savePressed()
    {
        print(textField.text!)
        let keychain = KeychainSwift()
        keychain.set(textField.text!, forKey: "message")
        label2.text = textField.text
        
        
    }
    @objc func syncPressed()
    {
        if(b2.titleLabel?.text == "Saved to iCloud")
        {
            b2.setTitle("Press to Sync to iCloud", for: .normal)
            b2.setTitleColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), for: .normal)
            return
        }else{
            b2.setTitle("Saved to iCloud", for: .normal)
            b2.setTitleColor(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), for: .normal)
        }
        let keychain = KeychainSwift()
        keychain.accessGroup = "com.JonathanKopp.keyChainExample.KeychainGroup" // Use your own access goup
        if let msg = keychain.get("message")
        {
            keychain.set(msg, forKey: "message")
        }
        
    }
    @objc func deletePressed()
    {
       let keychain = KeychainSwift()
       keychain.delete("message")
       //keychain.get("message")
       label2.text = "..."
    }
    func getMessage()->String
    {
        let keychain = KeychainSwift()
        if let msg = keychain.get("message")
        {
            return msg
        }
        return "..."
    }
}

