//
//  ContentViewModel.swift
//  AssignmentSwiftUi
//
//  Created by karma on 3/16/22.
//

import Foundation
class ContentViewModel: ObservableObject{
    
    @Published var isFetching = false
    @Published var courses: [Course] = []
    @Published var errorMessage = ""
    
    init(){
        // fetch data from here
        DispatchQueue.main.async {
            self.isFetching = true
        }
    }
    
    func fetchData() async {
        // url for the api call
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        isFetching = true
        
        // unwrap the url
        guard let url = URL(string: urlString) else {return}
        do{
            // actual fetching
            let (data, response) = try await URLSession.shared.data(from: url)
//            print(data)
            // checking for error on the response
            if let resp = response as? HTTPURLResponse, resp.statusCode >= 300{
                self.errorMessage = "failed to hit endpoint, status code: \(resp.statusCode)"
            }
            
            // decoding the response data into our course struct object
            self.courses = try JSONDecoder().decode([Course].self, from: data)
            isFetching = false
//            print(courses)
            
        }catch let error{
            print("error occured: \(error)")
            isFetching = false
        }
    }
}
