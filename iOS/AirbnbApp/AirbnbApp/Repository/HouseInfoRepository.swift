//
//  HouseInfoManager.swift
//  AirbnbApp
//
//  Created by 박진섭 on 2022/05/30.
//

import Alamofire
import OSLog

final class HouseInfoRepository {
    
    private var networkManager:NetworkManagable = NetworkManager(sessionManager: .default)
    
    init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
    
    var houseInfoBundle: [HouseInfo] = [
        HouseInfo(name: "킹왕짱 숙소", detail: Detail(rating: 4.45, reviewCount: 121), price: 101231, hostingBy: "김씨", latitude: 37.490765, longitude: 127.033433),
        HouseInfo(name: "킹짱 숙소", detail: Detail(rating: 4.35, reviewCount: 121), price: 1032131, hostingBy: "김씨", latitude: 37.480765, longitude: 127.032433),
        HouseInfo(name: "왕짱 숙소", detail: Detail(rating: 4.25, reviewCount: 121), price: 10141244, hostingBy: "김씨", latitude: 37.47065, longitude: 127.031433),
        HouseInfo(name: "한국 어딘가의 아주 근사한 숙소인데 이름이 조금 길어 근데 좋은데니까 한번 눌러", detail: Detail(rating: 4.15, reviewCount: 121), price: 10001, hostingBy: "김씨", latitude: 37.490765, longitude: 127.037433)
    ]
    
    func didChangeIsWish(_ cardIndex: Int?, completionHandler: ([HouseInfo]) -> Void) {
        guard let cardIndex = cardIndex else { return }
        // out of range 방지
        if houseInfoBundle.checkIsSafeIndex(index: cardIndex) {
            houseInfoBundle[cardIndex].isWish = !houseInfoBundle[cardIndex].isWish
        }
        completionHandler(houseInfoBundle)
    }
    
    func fetchHouseInfo<T: Codable>(endpoint: Endpointable, onCompleted: @escaping (T?) -> Void) {
        networkManager.request(endpoint: endpoint) { [weak self]  (result: DataResponse<T?, AFError>) in
            guard let self = self else { return }
            switch result.result {
            case .success(let data):
                self.houseInfoBundle = data as? [HouseInfo] ?? []
                onCompleted(data)
            case .failure(let error):
                os_log(.error, "\(error.localizedDescription)")
            }
        }
    }
}
