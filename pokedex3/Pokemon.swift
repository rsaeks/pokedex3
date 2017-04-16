//
//  Pokemon.swift
//  pokedex3
//
//  Created by Randy Saeks on 4/16/17.
//  Copyright © 2017 Randy Saeks. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _id: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int! {
        return _id
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._id = id
    }
}
