//
//  Environments.swift
//  CoreNetwork
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

public enum NetworkEnvironment {
    case develop
    case production
}

public enum APIVersion: String {
    case v1
}

public var networkEnvironment: NetworkEnvironment = {
    switch AppMode.mode {
    case .production:
        NetworkEnvironment.production
    case .staging:
        NetworkEnvironment.develop
    }
}()

extension NetworkEnvironment {
    
    public var url: URL { self.url(.v1) }
    
    public func url(_ version: APIVersion) -> URL {
        baseURL.appendingPathComponents("/\(version.rawValue)")
    }

    private var baseURL: URL {
        switch self {
        case .production: return .production
        case .develop: return .develop
        case .local: return .local
        }
    }
}

// MARK: -

private extension URL {
    static let production = URL(string: "https://api.lyncil.com")!
    static let develop = URL(string: "https://api.lyncil.com/dev")!
    static let local = URL(string: "http://localhost:8080/dev")!
}
