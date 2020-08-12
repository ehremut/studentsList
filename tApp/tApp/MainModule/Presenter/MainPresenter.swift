//
//  MainPresenter.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - Protocol

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}


protocol MainPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getJsonData()
    var arrayOfStudents : [Student] {get set}
    var json: JSON? {get set}
    var education : Type! {get set}
    var formOfEducation : Type! {get set}
    var institutions : Type! {get set}
    var listForm : Type! {get set}
    var payment : Type! {get set}
    // func getEducation()
    func getFormOfEdu(edu: String)
    func getPayment(edu: String, form: String)
    func getInstitutions(edu: String, form: String, payment: String)
    func getListForm(edu: String, form: String, payment: String, instit: String)
    func getStudents(post: [Int : String])
}
struct Type{
    var count: Int
    var list: [String]
}

struct Student{
    let name : String
    let score : String
    let sum : String
}

// MARK: - Class
class MainPresenter: MainPresenterProtocol{
    var arrayOfStudents = [Student]()
    
    var education: Type!
    var formOfEducation: Type!
    var institutions: Type!
    var listForm: Type!
    var payment: Type!
    var json: JSON?
    
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol){
        self.view = view
        self.networkService = networkService
        getJsonData()
        self.education = Type(count: 0, list: ["None"])
        self.formOfEducation = Type(count: 0, list: ["None"])
        self.institutions = Type(count: 0, list: ["None"])
        self.listForm = Type(count: 0, list: ["None"])
        self.payment = Type(count: 0, list: ["None"])
    }
    
    
    func getArray(dic: [String : JSON]) -> [String] {
        var list = [String]()
        for (key, _) in dic{
            list += [key]
        }
        return list.sorted(){$0<$1}
    }
    
    
    func getJsonData() {
        networkService.getJsonData { [weak self] result  in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.json = data
                    let dic = self.json?.dictionary
                    if dic != nil{
                        self.education = Type(count: dic!.count, list: self.getArray(dic: dic!))
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    
    func getStudents(post: [Int : String]) {
        self.arrayOfStudents.removeAll()
        var bestArray = [Student]()
        guard let a = post[1] else {return}
        guard let b = post[2] else {return}
        guard let c = post[3] else {return}
        guard let d = post[4] else {return}
        guard let e = post[5] else {return}
        guard let array = self.json?[a][b][c][d][e].arrayValue else {return}
        
        for i in array {
            if Int(i["score"].string!) == nil{
                self.arrayOfStudents.append(Student(name: i["name"].string ?? "", score: "БЭ", sum: "БЭ"))
            } else {
            let stdt = Student(name: i["name"].string ?? "", score: i["score"].string ?? "0", sum: i["sum_score"].string ?? "0")
            bestArray.append(stdt)
            }
        }
        bestArray.sort{Int($0.score)! > Int($1.score)!}
        bestArray.sort{Int($0.sum)! > Int($1.sum)!}
        self.arrayOfStudents += bestArray
    }
    
    
    
    func getFormOfEdu(edu: String){
        let dic = self.json?[edu].dictionary
        if dic != nil{
            self.formOfEducation = Type(count: dic!.count, list: self.getArray(dic: dic!))
        }
    }
    
    func getPayment(edu: String, form: String) {
        let dic = self.json?[edu][form].dictionary
        if dic != nil{
            self.payment = Type(count: dic!.count, list: self.getArray(dic: dic!))
        }
    }
    
    func getInstitutions(edu: String, form: String, payment: String) {
        let dic = self.json?[edu][form][payment].dictionary
        if dic != nil{
            self.institutions = Type(count: dic!.count, list: self.getArray(dic: dic!))
        }
    }
    
    func getListForm(edu: String, form: String, payment: String, instit: String){
        let dic = self.json?[edu][form][payment][instit].dictionary
        if dic != nil{
            self.listForm = Type(count: dic!.count, list: self.getArray(dic: dic!))
        }
    }
    
    
}

