//
//  File.swift
//  CoreNetwork
//
//  Created by Pavel Vaitsikhouski on 04.09.24.
//

import Foundation

extension NetworkModifier {
    public static func modifyAcceptLanguageHeader() -> Self {
        return NetworkModifier(modifyRequest: { request in
            request.addHTTPHeaderField(URLRequest.HTTPHeaderField(
                key: "lang",
                value: Locale.current.languageCode ?? "en"
            ))
        })
    }
}
