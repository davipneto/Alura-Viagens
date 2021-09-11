//
//  User.swift
//  Alura Viagems Swift
//
//  Created by Curitiba01 on 10/09/21.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var avatarURL: String
    
//    init(json: [String: Any]) {
//        id = json["id"] as? Int
//        firstName = json["first_name"] as? String
//        lastName = json["last_name"] as? String
//        email = json["email"] as? String
//        avatarURL = json["avatar"] as? String
//    }
    
    init(json: JSON) {
        id = json["id"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        email = json["email"].stringValue
        avatarURL = json["avatar"].stringValue
    }
}
