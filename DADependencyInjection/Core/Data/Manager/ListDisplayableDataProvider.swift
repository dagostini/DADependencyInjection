//
//  ListDisplayableDataProvider.swift
//  DADependencyInjection
//
//  Created by Dejan on 23/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol ListDisplayableDataProvider {
    func getListItems(onCompleted: (([ListDisplayable]) -> ())?)
}
