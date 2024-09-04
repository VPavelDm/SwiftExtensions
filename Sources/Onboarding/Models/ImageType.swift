//
//  File.swift
//  
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

enum ImageType: Sendable, Equatable, Hashable {
    case named(String)
    case remote(URL)
}
