//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Sayaka Sasaki on 2025/11/09.
//

import Foundation
import SwiftUI
import Alamofire
import Combine
// APIレスポンスを保持するクラス
class WeatherViewModel: ObservableObject {

    // リクエスト用URLの共通部分とAPIキー
    let baseUrl = APIProperties().baseUrl
    let apiKey = APIProperties().myAPIKey
    
    // レスポンスの値を保持する変数
    @Published var forecast: Forecast?
    @Published var location: UserLocation?

//３日間の予報リクエスト、latが緯度、lonが経度
    func request3DaysForecast(lat: Double, lon: Double) {
        //リクエストするためのURLを作成
        let url = URL(string: baseUrl + "/forecast.json")!
        
        //リクエストに含めるパラメータを用意
        let parameters: Parameters = [
            "key": apiKey,
            "q": "\(lat),\(lon)",
            "days": "3",
            "lang": "ja"
        ]
        
        //実際のリクエスト→レスポンス部分
        AF.request(url, method:  .get, parameters: parameters)
            .responseDecodable(of: WeatherInfo.self) { response in
                switch response.result {
                    //通信成功時
                case .success(let data):
                    self.forecast = data.forecast
                    self.location = data.location
                    print("LOCATION:", data.location.name)
                    
                    //通信失敗時
                case .failure(let err):
                    
                    print("FAILED:", err)
                }
            }
    }
}
