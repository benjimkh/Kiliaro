//
//  NetworkingLayer.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/28/21.
//

import Foundation

class NetworkingLayer {

    class func request<T: Codable>(router: Router, completion: @escaping (Result<[T], Error>) -> ()) {

        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.mainUrl
        components.path = router.path


        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        // 4.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in

            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }

            let responseObject = try! JSONDecoder().decode([T].self, from: data)

            DispatchQueue.main.async {

                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
