//
//  MovieItem.swift
//  DADependencyInjection
//
//  Created by Dejan on 21/02/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//

import Foundation

protocol MovieItem {
    var id: Int { get }
    var title: String { get }
    var movieDescription: String { get }
    var averageVote: Double { get }
}
