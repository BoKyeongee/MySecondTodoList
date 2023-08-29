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
    
    var todo = ["고양이 빗질하기", "고양이 밥 주기", "책상 정리하기"]
    var todoDone = ["병원 다녀오기"]
    
    var routine = ["30분씩 운동하기", "TIL 작성하기"]
    var routineDone = ["거북목 교정 운동"]
}
