//
//  Message.swift
//  SocketTest
//
//  Created by Alessandro Pace on 24/10/2020.
//

import Foundation

class Message: Mappable {
    var author: String? = ""
    var text: String? = ""
    
    init(message: String, user: String) {
        self.author = user
        self.text = message
    }
}
