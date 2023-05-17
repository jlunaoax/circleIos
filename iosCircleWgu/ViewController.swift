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
    @IBOutlet weak var btnViewResults: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnDecrementar.isEnabled = false;
        btnViewResults.isEnabled = false;
        showMessage(value: value);
    }

    @IBAction func btnIncrement(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        value = value + 1;
        validateCounter();
        showMessage(value: value);
    }
    
    @IBAction func btnDecrement(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if (value > 0) {
            value = value - 1;
        }
        validateCounter();
        showMessage(value: value);
    }
    
    func showMessage(value: Int) {
        myLabel.text="Current value = \(value)";
    }
    
    @IBAction func btnGoToNextView(_ sender: Any) {
        goToNextView()
    }
    
    func validateCounter() {
        if (value == 0 ) {
            btnDecrementar.isEnabled = false;
        } else
        {
            btnDecrementar.isEnabled = true;
        }
        if (value >= 10) {
            btnViewResults.isEnabled = true;
        } else
        {
            btnViewResults.isEnabled = false;
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? CreateCompanyController else { return }
        
        controller.contador = value
    }*/
    
    private func goToNextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(identifier: "CreateCompanyController") as? CreateCompanyController else { return }
        //controller.valueText = "\(value)"
        navigationController?.pushViewController(controller, animated: true)
    }
}

