//
//  ViewController.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 19/04/23.
//

import UIKit

class ViewController: UIViewController {

    var value = 0;
    
    @IBOutlet weak var btnDecrementar: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnDecrementar.isEnabled = false;
        showMessage(value: value);
    }

    @IBAction func btnIncrement(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        value = value + 1;
        btnDecrementar.isEnabled = true;
        showMessage(value: value);
    }
    
    @IBAction func btnDecrement(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if (value > 0) {
            value = value - 1;
        }
        if (value == 0 ) {
            btnDecrementar.isEnabled = false;
        }
        showMessage(value: value);
    }
    
    func showMessage(value: Int) {
        myLabel.text="Current value = \(value)";
    }
}

