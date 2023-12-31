//
//  NetworkManagable.swift
//  SideDishApp
//
//  Created by 박진섭 on 2022/04/28.
//

import Alamofire
import Foundation.NSData

protocol NetworkManagable {
    init(sessionManager: Session)
    func request<T: Codable>(endpoint: Endpointable, completion: @escaping ((DataResponse<T?, AFError>) -> Void))
    func requestImage(url: String, completion: @escaping ((DataResponse<Data?, AFError>) -> Void))
}
