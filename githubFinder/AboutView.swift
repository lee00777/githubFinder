//
//  AboutView.swift
//  GitHub_Search
//
//  Created by Alessandro H de Jesus & Gyuyoung Lee on 2021-11-23.
//

import SwiftUI

struct AboutView: View {
    // MARK: Properties
    @Environment(\.verticalSizeClass) var verticalSizeClass : UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass : UserInterfaceSizeClass?
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image("alessandro").resizable()
                        .frame(width: 150, height: 150)
                        .mask(Circle())
                        .padding(.top, 60)
                    Image("gyuyoung").resizable()
                        .frame(width: 150, height: 150)
                        .mask(Circle())
                        .padding(.top, 60)
                }
                .padding(.horizontal)
                .padding(.bottom,50)
                VStack{
                    Text("GitHub SearchApp")
                        .padding(.bottom, 5)
                    Text("Version : 1.0.1")
                        .padding(.bottom, 5)
                    Text("Created by Alessandro de Jesus & Gyuyoung Lee ")
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.center)
                    Text("MAD9137 Inc.")
                        .padding(.bottom, 5)
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "envelope")
                            Link("deje0014@algonquinlive.com", destination: URL(string: "mailto:deje0014@algonquinlive.com")! )
                                .accentColor(.lightGreen)
                                .frame(width: 250)
                        }
                        HStack{
                            Image(systemName: "link")
                            Link("https://alessandroj.ca", destination: URL(string: "https://alessandroj.ca")! )
                                .accentColor(.lightGreen)
                                .frame(width: 250)
                        }
                    }.padding(.bottom, 5)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "envelope")
                            Link("lee00777@algonquinlive.com", destination: URL(string: "mailto:lee00777@algonquinlive.com")! )
                                .accentColor(.lightGreen)
                                .frame(width: 250)
                        }
                        HStack{
                            Image(systemName: "link")
                            Link("https://github.com/lee00777", destination: URL(string: "https://github.com/lee00777")! )
                                .accentColor(.lightGreen)
                                .frame(width: 250)
                        }
                    }
                }
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(SwiftUI.Color.darkGray.edgesIgnoringSafeArea(.all))
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
