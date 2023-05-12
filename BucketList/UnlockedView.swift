//
//  UnlockedView.swift
//  BucketList
//
//  Created by Bruke on 8/5/22.
//

import SwiftUI

struct UnlockedView: View {
    @ObservedObject var viewModel: ContentView.ViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var username: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "list.bullet.rectangle")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
                Text("BucketList")
                    .font(.largeTitle)
            }
            
            Group {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            .autocapitalization(.none)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            .padding()
            
            Button {
                viewModel.signIn(username: username, password: password)
            } label: {
                Text("Sign in")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundColor(.white)
                    .font(.headline)
                    .cornerRadius(10)
                    .padding()
            }
            
            Button {
                viewModel.authenticate()
            } label: {
                HStack {
                    Image(systemName: "faceid")
                        .font(.largeTitle)
                    Text("Face ID")
                        .font(.headline)
                }

            }

        }
    }
}

//struct UnlockedView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnlockedView(viewModel: ContentView.ViewModel())
//    }
//}
