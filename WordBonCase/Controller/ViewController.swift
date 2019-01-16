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
    var lines : [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadComplete(_:)), name: Notification.Name(rawValue: "downloadComplete"), object: nil)
        downloadTextFile(url: url)
    }
    
    @objc func downloadComplete(_ notification: Notification) {
         lines = textToDisplay.components(separatedBy: "\n")
        print(lines.count)
        self.performSegue(withIdentifier: "search", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "search") {
            let vc = segue.destination as! SearchViewController
            vc.words = lines
        }
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
                // Will be Changed to make it working async
                NotificationCenter.default.post(name: Notification.Name(rawValue: "downloadComplete"), object: nil)
            }
        }
        task.resume()
    }
}

