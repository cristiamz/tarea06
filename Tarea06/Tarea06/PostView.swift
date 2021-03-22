//
//  PostView.swift
//  Tarea06
//
//  Created by Cristian Zuniga on 21/3/21.
//

import SwiftUI

struct PostView: View {
    
    @ObservedObject var urlVM = UrlShortenerViewModel()
    @State var longUrl: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Text("Post Request")
                        .font(.largeTitle)
                    
                    VStack(alignment: .leading, spacing: 12, content:{
                            HStack{
                                Text("POST URL: https://cleanuri.com/api/v1/shorten")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 150)
                            }})
                    
                    VStack(alignment: .leading, spacing: 12, content:{
                            HStack{
                                Text("Url to shorten:")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    
                            
                                TextField("Insert Link Here", text: $longUrl)
                                    .autocapitalization(.none)
                            }
                            .padding(.leading, 20.0)})
                    VStack{
                        HStack{
                            Button("Execute Post Request")
                            {
                                self.urlVM.getShortenURL(inputUrl: .init(url:longUrl))
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 12, content:{
                            HStack{
                                Text("Short URL: \(self.urlVM.Url_Result)")
                                    .font(.subheadline)
                                    .padding(.vertical)
                                    
                            }.padding(.leading, 20.0)})
                }
            }
        }
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
