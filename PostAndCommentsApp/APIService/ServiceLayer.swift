//
//  ServiceLayer.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation

protocol ServiceLayer {
    func fetch(path: String, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void))
}

struct ServiceLayerImpl: ServiceLayer {
    func fetch(path: String, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let url = URL(string: path)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completionHandler(nil, nil, error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200 ... 299).contains(httpResponse.statusCode)
            else {
                let errorTemp = NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? 200, userInfo: nil)
                completionHandler(nil, nil, errorTemp)
                return
            }

            completionHandler(data, response, error)
        })
        task.resume()
    }
}
