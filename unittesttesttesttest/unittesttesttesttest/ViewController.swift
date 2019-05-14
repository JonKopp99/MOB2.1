//
//  ViewController.swift
//  unittesttesttesttest
//
//  Created by Jonathan Kopp on 4/8/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "This is a textfield."
        //print(textField.placeholder!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func vowelsInAString(string: String) -> Int {
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        var numberOfVowels = 0
        for character in string {
            if vowels.contains(character) {
                numberOfVowels +=  1
            }
        }
        return numberOfVowels
    }
    
    func makeTitle(string: String) -> String {
        let words = string.components(separatedBy: " ")
        
        var headline = ""
        for var word in words {
            let firstCharacter = word.remove(at:word.startIndex)
            headline += "\(String(firstCharacter).uppercased())\(word) "
        }
        
        headline.remove(at:headline.endIndex)
        return headline
    }

}

