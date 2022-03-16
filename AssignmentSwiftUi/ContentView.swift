//
//  ContentView.swift
//  AssignmentSwiftUi
//
//  Created by karma on 3/15/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                if vm.isFetching {
                    ProgressView()
                }
                
//                // list view of the courses
//                List(vm.courses, id: \.id){course in
//                    Text(course.name)
//                }
                ForEach(vm.courses){course in
                    let urlString = course.imageUrl
                    AsyncImage(url: URL(string: urlString)) { image in
                        image.resizable().scaledToFill()
                            .padding(20)
                    } placeholder: {
                        ProgressView()
                    }

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
