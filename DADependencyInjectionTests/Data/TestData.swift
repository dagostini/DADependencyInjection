//
//  TestData.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/04/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol TestDataProvider {
    init(withFileName fileName: String)
    var dataRepresentation: Data? { get }
    var jsonRepresentation: Any? { get }
}

class TestData {
    
    fileprivate let fileName: NSString
    
    required init(withFileName fileName: String) {
        self.fileName = fileName as NSString
    }
}

// MARK: TestDataSource
extension TestData: TestDataProvider {
    public var dataRepresentation: Data? {
        get {
            let testBundle = Bundle(for: type(of: self))
            let filePath = testBundle.path(forResource: fileName.deletingPathExtension, ofType: fileName.pathExtension)
            
            if let path = filePath {
                let result = FileManager.default.contents(atPath: path)
                return result
            }
            
            return nil
        }
    }
    
    public var jsonRepresentation: Any? {
        get {
            guard
                let data = dataRepresentation,
                let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                    return nil
            }
            
            return jsonObject
        }
    }
}
