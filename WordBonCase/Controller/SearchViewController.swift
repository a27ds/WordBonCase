//
//  SearchViewController.swift
//  WordBonCase
//
//  Created by a27 on 2019-01-16.
//  Copyright © 2019 a27. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textViewTest: UITextView!
    var words: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        textViewTest.text = words[1]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
