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
    var textFile = ""
    var words : [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(downloadComplete(_:)), name: Notification.Name(rawValue: "downloadComplete"), object: nil)
    }
    
    override func viewDidLoad() {
        downloadData()
    }
    
    func downloadData() {
        let task = URLSession.shared.dataTask(with:url) { (data, response, error) in
            if error != nil {
                print(error!)
            }
            else {
                self.textFile = String(decoding: data!, as: UTF8.self)
                // Bug: Couldn't encode to isoLatin1 so no ÅÄÖ right now
                self.words = self.textFile.components(separatedBy: "\n")
                // I tried alot to make the download async and failed everytime.. I tried with a combination of DispatchQueue and completionHandler but i couldn't get it to wait until everything where downloaded and converted, so I made an Notification to switch VC when it was downloaded.
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "downloadComplete"), object: nil)
                }
            }
        }
        task.resume()
    }
    
    @objc func downloadComplete(_ notification: Notification) {
        self.performSegue(withIdentifier: "search", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "search") {
            let vc = segue.destination as! SearchViewController
            vc.words = words
        }
    }
}
