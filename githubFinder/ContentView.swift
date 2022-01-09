//
//  ContentView.swift
//  GitHub_Search
//
//  Created by Alessandro H de Jesus & Gyuyoung Lee on 2021-11-23.
//

import SwiftUI
import Alamofire
import ToastSwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var isLoading = false
    @State private var isNoResultsFound = false
    @State private var userName = ""
    @State private var isShowingResultsView = false
    // The @AppStorage property wrapper is used to save and read variables from UserDefaults and use them in the same way as @State
    @AppStorage("minimumNumberOfRepos") private var minimumNumberOfRepos = ""
    @AppStorage("minimumNumberOfFollowers")  private var minimumNumberOfFollowers = ""
    @AppStorage("usersPerPage") private var usersPerPage = 30
    let defaultRepos = 10
    let defaultFollowers = 10
    let baseURL = "https://api.github.com/search/users?q="
    @EnvironmentObject var globalUserData: UserData
    var body: some View {
        // MARK: NavigationView
        NavigationView{
            ZStack{
                Color.darkGray
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink("ResultsView", isActive: $isShowingResultsView){
                        NavigationLazyView(ResultsView())
                    }
                    .hidden()
                    VStack (alignment: .leading){
                        HStack (spacing: 66){
                            Text("Name : ")
                            TextField("Search name", text: $userName)
                                .frame(width: 150)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(Color.darkGray)
                                .fixedSize()
                        }
                        HStack (spacing: 31){
                            Text("Min Repos : ")
                            TextField("Min Repos", text: $minimumNumberOfRepos)
                                .frame(width: 150)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(Color.darkGray)
                                .fixedSize()
                        }
                        HStack{
                            Text("Min Followers : ")
                            TextField("Min Followers", text: $minimumNumberOfFollowers)
                                .frame(width: 150)
                                .textFieldStyle(.roundedBorder)
                                .foregroundColor(Color.darkGray)
                                .fixedSize()
                        }
                    }
                    VStack {
                        Stepper("Page size: \(usersPerPage)", value: $usersPerPage, in: 1...100)
                            .fixedSize()
                            .accentColor(Color.lightPink)
                    }
                    .padding()
                    Button("Search"){
                        isLoading = true
                        globalUserData.clearUserData()
                        let url = "\(baseURL)\(userName)"
                        let parameters: [String: Any] = ["per_page": usersPerPage]
                        let numRepos = Int(minimumNumberOfRepos) ?? defaultRepos
                        let numFollowers = Int(minimumNumberOfFollowers) ?? defaultFollowers
                        let repos = "repos:>=\(numRepos)".stringByAddingPercentEncodingForRFC3986() ?? ""
                        let followers = "followers:>=\(numFollowers)".stringByAddingPercentEncodingForRFC3986() ?? ""
                        let formedURL = "\(url)+\(repos)+\(followers)"
                        AF.request(formedURL, parameters: parameters)
                            .validate()
                            .responseDecodable(of: ResponseData.self) {
                                response in
                                guard let jsonData = response.value
                                else {
                                    isLoading = false
                                    print(response.error ?? "Unknown error")
                                    return
                                }
                                var singleUser = RequiredUserData()
                                for user in jsonData.items {
                                    print(user.login)
                                    singleUser.url = user.url
                                    singleUser.avatarURL = user.avatarURL
                                    singleUser.htmlURL = user.htmlURL
                                    singleUser.login = user.login
                                    singleUser.score = user.score
                                    singleUser.id = user.id
                                    globalUserData.users.append(singleUser)
                                }
                                if globalUserData.users.count > 0 {
                                    isLoading = false
                                    isShowingResultsView = true
                                }else{
                                    isLoading = false
                                    isNoResultsFound = true
                                }
                            }
                    }
                    .buttonStyle(.bordered)
                    .tint(Color.lightGreen)
                    .controlSize(.large)
                    .padding(.top)
                    .navigationBarTitle(Text("GitHub User Search"), displayMode: .large)
                    .toolbar {
                        NavigationLink(destination: AboutView()){
                            Image(systemName: "info.circle")
                        }
                    }
                }
                
            }
        }
        .overlay(ProgressView()
                    .tint(Color.white)
                    .scaleEffect(x:2 , y:2)
                    .opacity(isLoading ? 1 : 0)
        )
        .toast(isPresenting: $isNoResultsFound, message: "No results found", icon: .error)
        .foregroundColor(Color.lightPink)
        .accentColor(.white)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    // MARK: Method
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Extension method
extension Color {
    static let darkGray = Color(red: 22 / 255, green: 22 / 255, blue: 24 / 255)
    static let lightPink = Color(red: 251 / 255, green: 234 / 255, blue: 235 / 255)
    static let lightGreen = Color(red: 2 / 255, green: 163 / 255, blue: 162 / 255)
}
