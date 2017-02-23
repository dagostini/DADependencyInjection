//
//  NetworkConnectable.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol NetworkingProvider {
    func restCall(urlString: String, onCompleted: ((Data?) -> ())?)
}
