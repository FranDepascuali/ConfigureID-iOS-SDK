//
//  ConfigureID.swift
//  
//
//  Created by Francisco D. on 27/04/2022.
//

import Foundation

public extension ConfigureID {
    
    // TODO: Documentation
    struct Customers {
        
        // TODO: Document
        // TODO: Does this returns an [product summary] or [Product]?
        // TODO: workflow is optional in API.
        public static func fetchProducts(customerId: Int, workflow: String, onSuccess: @escaping ([ProductSummary]) -> (), onError: @escaping (ConfigureIDError) -> ()) {
            do {
                let request = Request.Customer.products(
                    customerId: customerId,
                    // TODO: Check Api key
                    apiKey: try ensureApiKey(),
                    workflow: workflow
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
        
        // TODO: Document
        public static func fetchProductData(customerId: Int, productId: Int, workflow: String, onSuccess: @escaping (Product) -> (), onError: @escaping (ConfigureIDError) -> ()) {
            do {
                
                let request = Request.Customer.productData(
                    customerId: customerId,
                    productId: productId,
                    apiKey: try ensureApiKey(),
                    workflow: workflow
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
        
        // TODO: Document
        public static func findByVendorId(customerId: Int, vendorId: String, workflow: String, onSuccess: @escaping ([Product]) -> (), onError: @escaping (ConfigureIDError) -> ()) {
            
            do {
                let request = Request.Customer.findByVendorId(
                    customerId: customerId,
                    // TODO: Check Api key
                    apiKey: try ensureApiKey(),
                    vendorId: vendorId,
                    workflow: workflow
                )
                
                NetworkService
                    .shared
                    .executeRequest(
                        request: request,
                        onSuccess: onSuccess,
                        onError: onError
                    )
            } catch {
                handleError(error: error, onError: onError)
            }
        }
    }
}
