//
//  ResultsView.swift
//  GitHub_Search
//
//  Created by Alessandro H de Jesus & Gyuyoung Lee on 2021-11-23.
//

import SwiftUI
import Kingfisher

// MARK: NavigationLazyView
// NavigationLazyView is used to call a view only when it actually navigates to the view
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping ()-> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct ResultsView: View {
    // MARK: Property
    @EnvironmentObject var globalUserData: UserData
    
    var body: some View {
        List {
            Section(header: HStack {
                if globalUserData.users.count > 1 {
                    Image(systemName: "person.2")
                        .foregroundColor(.lightGreen)
                    Text("\(globalUserData.users.count) Users")
                        .textCase(.lowercase)
                        .foregroundColor(.lightGreen)
                } else {
                    Image(systemName: "person")
                    Text("\(globalUserData.users.count) User")
                        .textCase(.lowercase)
                        .foregroundColor(.lightGreen)
                }
            }
                        .font(.title3)
            )
            {
                if globalUserData.users.count > 0 {
                    ForEach(globalUserData.users, id: \.id, content: {
                        user in
                        NavigationLink(destination: NavigationLazyView(DetailsView(observed: DetailsData(url: user.url, htmlURL: user.htmlURL, avatarURL: user.avatarURL))
                                                                      ))
                        {
                            HStack(spacing: 40){
                                KFImage(URL(string: user.avatarURL))
                                    .resizable()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 20){
                                    Text("Login: \(user.login)")
                                    Text("Score: \(String(user.score))")
                                    Text("ID: \(user.id)")
                                }
                            }
                        }
                    })
                        .listRowBackground(Color.darkGray)
                }
            }
        }
        .onAppear(perform: {
            UITableView.appearance().contentInset.top = -30
        })
        .listStyle(GroupedListStyle())
        .environment(\.defaultMinListRowHeight, 130)
    }
    // MARK: Method
    init(){
        print("ResultsView")
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor(Color.darkGray)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
