//
//  SecondViewController.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 02/05/23.
//

import UIKit
import CoreData

enum CreateCompanyControllerState {
    case add
    case edit
    case detail
}

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
    
    var state:CreateCompanyControllerState = .edit
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        switch state {
        case .add:
            navigationItem.title = "Create company"
            setSaveButton()
        case .edit:
            navigationItem.title = "Edit company"
            setSaveButton()
        case .detail:
            navigationItem.title = "Company"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save,
                                                            primaryAction: UIAction.init(handler: { [weak self] _ in
            guard let self = self else { return }
            self.didTapSave()
        }))
    }
    
    private func setupUI() {
        switch state {
        case .add, .edit:
            btnAttachImage.isHidden = false
        case .detail:
            btnAttachImage.isHidden = true
            // txtCompanyName.isUserInteractionEnabled = false
            
        }
        guard let company = company else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
            // btnAttachImage.isHidden = false
            return
        }
        
        txtCompanyName.text = company.name
        txtFounder.text = company.founder
        if let founded = company.founded {
            datePicker.date = founded
        }
        if let imageData = company.imageData {
            companyImageView.image = UIImage(data: imageData)
            setupImage()
        } else {
            companyImageView.image = UIImage(systemName: "person.crop.circle.dashed")
        }
        
    }
    
    
    private func setupImage() {
        companyImageView.setCircularImageView()
    }
    
   
    private func didTapSave() {
        
        company != nil ?
        performEditCompany()
        :
        performCreateCompany()
        
    }
    
    private func performCreateCompany() {
        let context = CoreDataManager.shared.context
        
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(txtCompanyName.text, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        company.setValue(txtFounder.text, forKey: "founder")
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
        company?.founder = txtFounder.text
        
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
            imagePicker.allowsEditing = true
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
        if let editImage = info[.editedImage] as? UIImage {
            companyImageView.image = editImage
        }
        else if let originalImage = info[.originalImage] as? UIImage {
            companyImageView.image = originalImage
            
        }
        setupImage()
        dismiss(animated: true)
    }
}
