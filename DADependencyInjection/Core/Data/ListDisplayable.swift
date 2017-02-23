//
//  ListDisplayable.swift
//  DADependencyInjection
//
//  Created by Dejan on 22/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol ListDisplayable {
    var listItemTitle: String { get }
    var listItemSubtitle: String? { get }
}
