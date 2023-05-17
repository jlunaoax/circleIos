//
//  SecondViewController.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 02/05/23.
//

import UIKit

protocol CreateCompanyDelegate: AnyObject {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company)
}

class CreateCompanyController: UIViewController {

    weak var delegate: CreateCompanyDelegate?
    
    @IBOutlet weak var btnAttachImage: UIButton!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var lblFactoryYear: UILabel!
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var lblFounder: UILabel!
    
    @IBOutlet weak var txtFounder: UITextField!
    
    @IBOutlet weak var txtFoundationYear: UITextField!
    
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title="Create company"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save,
                                                            primaryAction: UIAction.init(handler: { [weak self] _ in
            guard let self = self else { return }
            self.didTapSave()
        }))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let company = company else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
            btnAttachImage.isHidden = false
            return
        }
        
        btnAttachImage.isHidden = true
        //guard let nombreLbl = nombre else { return }
        companyImageView.image = UIImage(named: company.image)
        txtCompanyName.text = company.name
        txtFoundationYear.text = "\(company.foundationYear)"
        txtFounder.text = company.founder
        
    }
    
   
    private func didTapSave() {
        guard let name = txtCompanyName.text,
              let founder = txtFounder.text,
              let yearFoundationString = txtFoundationYear.text,
              let yearFoundationInt = Int(yearFoundationString) else { return }
        let companyCreated = Company(name: name,
                                     foundationYear: yearFoundationInt,
                                     founder: founder,
                                     image: "")
        delegate?.createCompanyController(self, didCreateCompany: companyCreated)
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapSelectImage(_ sender: Any) {
        let alertContrller = UIAlertController(title: "Choose a photo", message: "Select a picture from library or camera", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) {[weak self] _ in
            guard let self = self else { return }
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            self.present(imagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertContrller.addAction(libraryAction)
        alertContrller.addAction(cancelAction)
        
        present(alertContrller, animated: true)
    }
    

}

extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        companyImageView.image = image
        dismiss(animated: true)
    }
}
