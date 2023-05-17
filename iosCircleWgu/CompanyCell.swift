//
//  CompanyCell.swift
//  iosCircleWgu
//
//  Created by Real Jose Javier Del Mar Luna Mendoza on 13/05/23.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var companyImageView: UIImageView!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    func configure (company: Company) {
        companyImageView.image = UIImage(named: company.image)
        companyNameLabel.text = company.name
    }
    
}
