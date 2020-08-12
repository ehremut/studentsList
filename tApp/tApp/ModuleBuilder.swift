//
//  ModuleBuilder.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    static func createMainModule() -> UIViewController
    static func createDetailModule(students: [Student]?) -> UIViewController

}

class ModelBuilder: BuilderProtocol{
    
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view , networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailModule(students: [Student]?) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view as DetailViewProtocol, networkService: networkService, students: students)
        view.presenter = presenter
        return view
    }
    
    
}
