//
//  RawServerResponse.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import Foundation

struct JsonData: Decodable {
    let data: [Datas]
    let view: [String]
}

struct Datas: Decodable {
    enum ElementCodingKeys: String,CodingKey{
        case name
        case data
    }
    
    let name: String
    let data: Element?
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: ElementCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        if let name = try container.decodeIfPresent(String.self, forKey: .name){
            switch name {
            case "hz":
                data = try container.decode(Text.self, forKey: .data)
            case "picture":
                data = try container.decode(Picture.self, forKey: .data)
            case "selector":
                data = try container.decode(Selectors.self, forKey: .data)
            default:
                fatalError("Unknown element \(name)")
            }
        } else {
            data = nil
        }
    }
}

protocol Element: Decodable { }

struct Text: Element {
    let text: String
}

struct Picture: Element {
    let url: URL
    let text: String
}

struct Selectors: Element{
    let selectedId: Int
    let variants: [Variant]
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
