//
//  Data.swift
//  MyApp2
//
//  Created by 보경 on 2023/08/25.
//

import Foundation

class Data {
    static let shared = Data()

    private init() {}
    
    var array1: [String] = ["밥 주기", "물 주기", "똥간 치워주기"]
    var todoData: [String:[String]] = [:]
    
}
