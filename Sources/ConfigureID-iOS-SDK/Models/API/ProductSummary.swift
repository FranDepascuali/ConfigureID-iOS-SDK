//
//  ProductSummary.swift
//  
//
//  Created by Francisco D. on 25/04/2022.
//

import Foundation

public struct ProductSummary: Codable {

    /// The globally unique id of the product.
    let id: Int
        
    /// The name of the product.
    let name: String
    
    /// External id of the product.
    let vendorId: String
    
    /// The identifier for the locale used by default. This is the locale that will be used when no locale is sent via query parameters.
    let defaultLocale: String
    
    /// The list of all available locales for the product.
    let locales: [String]
    
    /// The list of associated product facets.
    let facets: [Facet]
    
}
