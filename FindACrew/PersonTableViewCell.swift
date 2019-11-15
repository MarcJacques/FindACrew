//
//  PersonTableViewCell.swift
//  FindACrew
//
//  Created by Marc Jacques on 11/13/19.
//  Copyright © 2019 Marc Jacques. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews(){
        guard let person = person else { return }
        nameLabel.text = person.name
        genderLabel.text = "Gender: \(person.gender)"
        birthYearLabel.text = "Birth Year: \(person.birthYear)"
    }

}
