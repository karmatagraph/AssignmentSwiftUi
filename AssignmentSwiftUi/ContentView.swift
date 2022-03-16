//
//  ContentView.swift
//  AssignmentSwiftUi
//
//  Created by karma on 3/15/22.
//

import SwiftUI



class ContentViewModel: ObservableObject{
    
    @Published var isFetching = false
    @Published var courses: [Course] = []
    
    init(){
        // fetch data from here
        DispatchQueue.main.async {
            self.isFetching = true
        }
    }
    
    func fetchData() async {
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        isFetching = true
        guard let url = URL(string: urlString) else {return}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
//            print(data)
            
            self.courses = try JSONDecoder().decode([Course].self, from: data)
            isFetching = false
//            print(courses)
        }catch let error{
            print("error occured: \(error)")
            isFetching = false
        }
    }
}

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                if vm.isFetching {
                    Text("is fetching data form the internet")
                }
                
//                // list view of the courses
//                List(vm.courses, id: \.id){course in
//                    Text(course.name)
//                }
                ForEach(vm.courses){course in
                    Text(course.name)
                }
                
            }
            .navigationTitle("Courses")
            .task {
                await vm.fetchData()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
