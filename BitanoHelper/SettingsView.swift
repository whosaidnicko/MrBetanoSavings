//
//  SettingsView.swift
//  Bitana Helper
//
//  Created by Pen Ke on 26/10/2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) var openURL
    @State var notificationAccepted: Bool = false
    @State var timer: Timer?
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    navigationManager.fullScreenCoverSettings = false 
                }, label: {
                    Image("backBtn")
                })
               
                Text("Settings")
                    .font(.custom(Font.bold, size: 20))
                    .foregroundStyle(Color.init(hex: "#111111"))
                
                Spacer()
            }
            Rectangle()
                .fill(Color.init(hex: "#EBEBEB"))
                .frame(height: 1)
                
                .padding(.top, 40)
            
            
           Rectangle()
                .fill(Color.white)
                .overlay {
                    HStack {
                        Image("alert")
                        
                        Text("Notifications")
                            .font(.custom(Font.semiBold, size: 16))
                            .foregroundStyle(Color.init(hex: "#111111"))
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.init(hex: "#EBEBEB"))
                            .overlay {
                                Circle()
                                    .fill(notificationAccepted ? Color.init(hex: "#FE3B00") : Color.init(hex: "#999999"))
                                    .frame(width: 20, height: 20)
                                    .offset(x: notificationAccepted ? 10 : -10)
                            }
                            .frame(width: 32, height: 18)
                          
                    }
                }
                .frame(height: 56)
                .padding(.horizontal)
                .onTapGesture {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            Rectangle()
                .fill(Color.init(hex: "#EBEBEB"))
                .frame(height: 1)
            
            Rectangle()
                 .fill(Color.white)
                 .overlay {
                     HStack {
                         Image("info")
                         
                         Text("Privacy Policy")
                             .font(.custom(Font.semiBold, size: 16))
                             .foregroundStyle(Color.init(hex: "#111111"))
                         
                         Spacer()
                        
                           
                     }
                 }
                 .frame(height: 56)
                 .padding(.horizontal)
                 .onTapGesture {
                     openURL(URL(string: "https://www.dropbox.com/scl/fi/me9ewefd0u35ebltmkfdl/Privacy-Policy-for-Mr-Betano-Saving.paper?rlkey=nqfnk6apvvzlgme5qv5uli56o&st=w02ziqni&dl=0")!)
                 }
            
            Rectangle()
                .fill(Color.init(hex: "#EBEBEB"))
                .frame(height: 1)
            
            Rectangle()
                 .fill(Color.white)
                 .overlay {
                     HStack {
                         Image("mailBlack")
                         
                         Text("Contact Us")
                             .font(.custom(Font.semiBold, size: 16))
                             .foregroundStyle(Color.init(hex: "#111111"))
                         
                         Spacer()
                     }
                 }
                 .frame(height: 56)
                 .padding(.horizontal)
                 .onTapGesture {
                     if let url = URL(string: "mailto:nguyenthigamlieu9523@gmail.com") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                 }
            
            Rectangle()
                .fill(Color.init(hex: "#EBEBEB"))
                .frame(height: 1)
            
            Rectangle()
                 .fill(Color.white)
                 .overlay {
                     HStack {
                         Image("facebook")
                         
                         Text("Facebook")
                             .font(.custom(Font.semiBold, size: 16))
                             .foregroundStyle(Color.init(hex: "#111111"))
                         
                         Spacer()  
                     }
                 }
                 .frame(height: 56)
                 .padding(.horizontal)
                 .onTapGesture {
                     openURL(URL(string: "https://www.facebook.com/profile.php?id=100063214813097")!)
                 }
            Rectangle()
                .fill(Color.init(hex: "#EBEBEB"))
                .frame(height: 1)
            Spacer()
        }
        .padding()
        .onChange(of: scenePhase) { scene in
            checkNotificationAuthorizationStatus()
            
        }
        .onAppear() {
           checkNotificationAuthorizationStatus()
        }
    }
    func checkNotificationAuthorizationStatus() {
           UNUserNotificationCenter.current().getNotificationSettings { settings in
               DispatchQueue.main.async {
                   if  settings.authorizationStatus == .authorized {
                       
                       self.notificationAccepted = true
                   } else if settings.authorizationStatus == .denied {
                       
                       self.notificationAccepted = false
                   }
               }
           }
       }
}
