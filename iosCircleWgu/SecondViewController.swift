//
//  SecondViewController.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 02/05/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var myLblResults: UILabel!
    var contador: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let counter = contador else {fatalError("Contador es nulo")}
        myLblResults.text = "Results: \(counter)"
        // Do any additional setup after loading the view.
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
