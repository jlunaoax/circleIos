//
//  SecondViewController.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 02/05/23.
//

import UIKit
import CoreData

protocol CreateCompanyDelegate: AnyObject {
    func createCompanyController(_ createCompanyController: CreateCompanyController, didCreateCompany company: Company)
    
    func createCompanyController(_ createCompanyController: CreateCompanyController, didEditCompany company: Company)
    
}

class CreateCompanyController: UIViewController {

    weak var delegate: CreateCompanyDelegate?
    
    @IBOutlet weak var btnAttachImage: UIButton!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var lblFactoryYear: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var lblFounder: UILabel!
    
    @IBOutlet weak var txtFounder: UITextField!
    
    @IBOutlet weak var txtFoundationYear: UITextField!
    
    var company: Company?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = company != nil ? "Edit company" : "Create company"
        
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
            // btnAttachImage.isHidden = false
            return
        }
        
        // btnAttachImage.isHidden = true
        //guard let nombreLbl = nombre else { return }
        //companyImageView.image = UIImage(named: company.image)
        txtCompanyName.text = company.name
        if let founded = company.founded {
            datePicker.date = founded
        }
        if let imageData = company.imageData {
            companyImageView.image = UIImage(data: imageData)
        } else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        }
        
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = UIColor.black.cgColor
        companyImageView.layer.borderWidth = 2
        //txtFoundationYear.text = "\(company.foundationYear)"
        //txtFounder.text = company.founder
        
    }
    
   
    private func didTapSave() {
        
        company != nil ?
        performEditCompany()
        :
        performCreateCompany()
        
      /*  guard let name = txtCompanyName.text,
              let founder = txtFounder.text,
              let yearFoundationString = txtFoundationYear.text,
              let yearFoundationInt = Int(yearFoundationString) else { return }
        let companyCreated = Company(name: name,
                                     foundationYear: yearFoundationInt,
                                     founder: founder,
                                     image: "")*/
    }
    
    private func performCreateCompany() {
        let context = CoreDataManager.shared.context
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(txtCompanyName.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        if let image = companyImageView.image {
            let imageData = image.jpegData(compressionQuality: 0.8)
            company.setValue(imageData, forKey: "imageData")
        }
        do {
            try context.save()
            dismiss(animated: true) {[weak self] in
                guard let self = self else { return }
                self.delegate?.createCompanyController(self, didCreateCompany: company as! Company)
            }
        } catch {
            print("Failed to save company \(error)")
        }
    }
    
    private func performEditCompany() {
        let context = CoreDataManager.shared.context
        company?.name = txtCompanyName.text
        company?.founded = datePicker.date
        
        if let image = companyImageView.image {
            let imageData = image.jpegData(compressionQuality: 0.8)
            company?.imageData = imageData
        }
        
        do {
            try context.save()
                dismiss(animated: true) {[weak self] in
                    guard let self = self else { return }
                    self.delegate?.createCompanyController(self, didEditCompany: company!)
                }
        } catch {
            print("Failed to edit company \(error)")
        }
        
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
