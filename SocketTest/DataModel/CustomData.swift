//
//  CustomData.swift
//  SocketTest
//
//  Created by Alessandro Pace on 25/10/2020.
//

import Foundation
import SocketIO

struct CustomData : SocketData {
   let author: String
   let text: String

   func socketRepresentation() -> SocketData {
       return ["author": author, "text": text]
   }
}
