//
//  Person.swift
//  MyLab
//
//  Created by Iury Miguel on 08/06/19.
//  Copyright © 2019 Iury Miguel. All rights reserved.
//

import Foundation


class Person {
    
    static var idGenerator = 0
    var id: Int
    var name: String
    var age: UInt8
    
    public init(_ name: String, _ age: UInt8) {
        Person.idGenerator += 1
        id = Person.idGenerator
        self.name = name
        self.age = age
    }
}
