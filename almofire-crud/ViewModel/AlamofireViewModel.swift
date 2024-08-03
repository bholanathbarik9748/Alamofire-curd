//
//  AlamofireViewModel.swift
//  almofire-crud
//
//  Created by Bholanath Barik on 03/08/24.
//

import Foundation
import Alamofire

class AlamofireViewModel : ObservableObject {
    @Published var Post: [AlamofileModel] = []
    @Published var isLoading = false
    @Published var errMsg: String?
    
    func addRecord(_ title: String,_ body: String,_ userId : Int) {
        isLoading = true;
        errMsg = "";
        
        let endPoint = "https://jsonplaceholder.typicode.com/posts";
        let body: [String : Any]  = [
            "title": title,
            "body": body,
            "userId": userId
        ]
        
        AF.request(
            endPoint,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: AlamofileModel.self){ [weak self] response in
            guard let self = self else { return }
            self.isLoading = false;
            
            switch response.result {
            case .success(let data):
                self.Post.append(data)
            case .failure(let err):
                self.errMsg = err.localizedDescription
            }
        }
    }
    
    func getRecord() {
        isLoading = true
        errMsg = nil
        
        let endpoints = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(endpoints)
            .validate()
            .responseDecodable(of: [AlamofileModel].self) { [weak self] response in
                guard let self = self else { return }
                self.isLoading = false
                
                switch response.result {
                case .success(let data):
                    self.Post = data
                    print("self.Post",self.Post)
                case .failure(let err):
                    self.errMsg = err.localizedDescription
                    if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Error response data: \(json)")
                    }
                    print("Error: \(err)")
                }
            }
    }
    
    
    func updateRecord(_ id: Int, _ title: String,_ body: String,_ userId : Int){
        isLoading = true;
        errMsg = "";
        
        let endpoint = "https://jsonplaceholder.typicode.com/posts/\(id)"
        let body: [String : Any]  = [
            "id" : id,
            "title": title,
            "body": body,
            "userId": userId
        ]
        
        AF.request(
            endpoint,
            method: .put,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable(of : AlamofileModel.self){ [weak self] response in
            guard let self = self else { return }
            self.isLoading = false;
            
            switch response.result {
            case .success(let updateData) :
                if let index = self.Post.firstIndex(where: { $0.id == id }){
                    self.Post[index] = updateData;
                }
            case .failure(let error):
                self.errMsg = error.localizedDescription
            }
        }
    }
    
    func deleteRecord(_ id : Int){
        isLoading = true;
        errMsg = "";
        
        let endpoint = "https://jsonplaceholder.typicode.com/posts/\(id)";
        
        AF.request(
            endpoint,
            method: .delete
        )
        .validate()
        .response { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false;
            
            switch response.result {
            case .success:
                self.Post.removeAll { $0.id == id }
            case .failure(let error):
                self.errMsg = error.localizedDescription;
            }
        }
    }
}
