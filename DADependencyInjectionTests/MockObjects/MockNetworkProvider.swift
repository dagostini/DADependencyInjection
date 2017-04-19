//
//  MockNetworkProvider.swift
//  DADependencyInjection
//
//  Created by Dejan on 19/04/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation
@testable import DADependencyInjection

class MockNetworkProvider {
    
    fileprivate let dataProvider: TestDataProvider
    
    init(withDataProvider dataProvider: TestDataProvider) {
        self.dataProvider = dataProvider
    }
}

// MARK: NetworkingProvider
extension MockNetworkProvider: NetworkingProvider {
    func restCall(urlString: String, onCompleted: ((Data?) -> ())?) {
        onCompleted?(self.dataProvider.dataRepresentation)
    }
}
