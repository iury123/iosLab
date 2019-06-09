//
//  PersonCollectionViewCell.swift
//  MyLab
//
//  Created by Iury Miguel on 08/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var cardView: UIView!
    var person: Person?
    private var cardClickListener: ((Person, (() -> Void)?) -> Void)?
    private var hasAlreadyPressed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(checkAction(sender:)))
        cardView.addGestureRecognizer(gesture)
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
    }
    
    func prepare(person: Person) {
        self.person = person
        nameLabel.text = person.name
        ageLabel.text = "\(person.age)"
    }

    @objc private func checkAction(sender : UITapGestureRecognizer) {
        if let person = person, hasAlreadyPressed == false {
            hasAlreadyPressed = true
            indicator.isHidden = false
            indicator.startAnimating()
            cardClickListener?(person) {
                self.indicator.stopAnimating()
                self.hasAlreadyPressed = false
                print("\(person.id) \(person.name) \(person.age)")
            }
        }
    }
    
    func setOnCardClickListener(listener: @escaping (Person, (() -> Void)?) -> Void) {
        cardClickListener = listener
    }
    
    
}
