//
//  DetailsView.swift
//  GitHub_Search
//
//  Created by Alessandro H de Jesus & Gyuyoung Lee on 2021-11-23.
//

import SwiftUI
import Kingfisher

struct DetailsView: View {
    // MARK: Property
    @ObservedObject var observed: DetailsData
    let nilURL: URL = URL(string: "Nil") ?? URL(string: "Unknown")!
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack(spacing: 20){
                KFImage(URL(string: observed.avatarURL) ?? nilURL)
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
                    .clipShape(Circle())
                Link(observed.htmlURL, destination: URL(string: observed.htmlURL) ?? nilURL).foregroundColor(.lightGreen)
                Text("user-name \(observed.name)")
                Text("user-location \(observed.location)")
                Text("user-company \(observed.company)")
                Text("user-followers \(observed.followers)")
                Text("user-public-gists \(observed.publicGists)")
                Text("user-public-repos \(observed.publicRepos)")
                Text("user-last-update \(observed.lastUpdate)")
                Text("user-account-created \(observed.accountCreated)")
            }
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(SwiftUI.Color.darkGray.edgesIgnoringSafeArea(.all))
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
