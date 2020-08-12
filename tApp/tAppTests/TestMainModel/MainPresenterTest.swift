//
//  MainPresenterTest.swift
//  tAppTests
//
//  Created by macOS developer on 21.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import XCTest
@testable import tApp

class MockView: MainViewProtocol{
    func success() {
    }
    
    func failure(error: Error) {
    }
    
    
}

class MockNetWorkService: NetworkServiceProtocol{
    var data : Data!
    init(){}
    convenience init(data: Data?){
        self.init()
        self.data = data
    }
    
    func getJsonData(completion: @escaping (Result<JsonData?, Error>) -> Void) {
        if let data = data{
            
            let json = try? JSONDecoder().decode(JsonData.self, from: data)
            completion(.success(json))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    
}

class MainPresenterTest: XCTestCase {
    var variants: Selectors?
    var picture: Data?
    var jsonData: JsonData?
    var view: MockView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    
    override func tearDown() {
        view = nil
        presenter = nil
        networkService = nil
    }
    
    func readJSONFromFile(fileName: String) -> Data?
    {
        var data: Data?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
            } catch {
            }
        }
        return data
    }
    
    func testGetJsonSuccess(){
        let data = readJSONFromFile(fileName: "testJson")
        view = MockView()
        networkService = MockNetWorkService(data: data)
        presenter = MainPresenter(view: view, networkService: networkService)
        networkService.getJsonData { result in
            switch result{
            case .success(let data):
                self.jsonData = data
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertNotEqual(jsonData?.data.count, 0)
    }
    
}







