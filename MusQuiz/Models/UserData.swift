//
//  UserData.swift
//  MusQuiz
//
//  Created by Konstantin Gracheff on 04.10.2022.
//

import Foundation

class UserData {
    let login: String
    let password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
