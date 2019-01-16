//
//  ViewController.swift
//  WordBonCase
//
//  Created by a27 on 2019-01-16.
//  Copyright © 2019 a27. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let url = URL(string:"http://runeberg.org/words/ss100.txt")!
    var textToDisplay = ""
    
    override func viewWillAppear(_ animated: Bool) {
        downloadTextFile(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func downloadTextFile(url: URL) {
        let task = URLSession.shared.dataTask(with:url) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            else {
                let textFile = String(decoding: data!, as: UTF8.self)
                // Bug: Can't encode to isoLatin1 so no ÅÄÖ right now
                self.textToDisplay = textFile
                print(self.textToDisplay)
            }
        }
        task.resume()
    }
}

