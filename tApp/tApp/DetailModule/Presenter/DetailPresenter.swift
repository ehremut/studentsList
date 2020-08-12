//
//  DetailBuilder.swift
//  tApp
//
//  Created by macOS developer on 09.08.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol DetailViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, students: [Student]?)
    var students : [Student]? {get set}
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var students : [Student]?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, students: [Student]?) {
        self.view = view
        self.networkService = networkService
        self.students = students
        self.view?.success()
    }
}
