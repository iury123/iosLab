//
//  ViewController.swift
//  MyLab
//
//  Created by Iury Miguel on 08/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    private var persons: [Person] = []
    private let cellIdentifier = "myCell"
    private var itemsPerRow: CGFloat = 2
    var timer: Timer?
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 10.0,
                                             bottom: 10.0,
                                             right: 10.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        loadPersons()
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            itemsPerRow = 3
        } else {
            print("Portrait")
            itemsPerRow = 2
        }
        myCollectionView.reloadData()
    }
        
    
    private func loadPersons() {
        persons.append(Person("Iury", 23))
        persons.append(Person("José", 33))
        persons.append(Person("Marcos", 43))
        persons.append(Person("Jeff", 56))
        persons.append(Person("Michael", 17))
        persons.append(Person("Benny", 21))
        persons.append(Person("Iury", 23))
        persons.append(Person("José", 33))
        persons.append(Person("Marcos", 43))
        persons.append(Person("Jeff", 56))
        persons.append(Person("Michael", 17))
        persons.append(Person("Benny", 21))
        persons.append(Person("Iury", 23))
        persons.append(Person("José", 33))
        persons.append(Person("Marcos", 43))
        persons.append(Person("Jeff", 56))
        persons.append(Person("Michael", 17))
        persons.append(Person("Benny", 21))
    }
    
    
    func doAsyncOperation (_ person: Person, completionCallback: @escaping () -> Void) {
        print("Realizando operação assíncrona com \(person.name) cujo id é \(person.id)")
        timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: false, block: {(timer) in
            timer.invalidate()
            print("Finalizando operação assíncrona com \(person.name) cujo id é \(person.id)")
            completionCallback()
        })
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PersonCollectionViewCell
        cell.prepare(person: persons[indexPath.row])
        cell.setOnCardClickListener { person, callback in
            self.doAsyncOperation(person){ callback?() }
        }
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = myCollectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
