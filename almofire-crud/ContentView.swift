//
//  ContentView.swift
//  almofire-crud
//
//  Created by Bholanath Barik on 03/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var ViewModel = AlamofireViewModel()
    
    var body: some View {
        NavigationView{
            if ViewModel.isLoading {
                ProgressView("Please Wait.....");
            }else if let errorMessage = ViewModel.errMsg {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }else{
                List(ViewModel.Post) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.subheadline)
                    }
                }
                .onAppear {
                    ViewModel.getRecord();
                }
            }
        }
        .navigationTitle("Posts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    ViewModel.addRecord("New Title", "New Body", 1)
                }) {
                    Text("Add Post")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
