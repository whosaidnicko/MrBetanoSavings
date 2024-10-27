//
//  LandingView.swift
//  Mr. Betano Win Using Savings
//
//  Created by Nicolae Chivriga on 25/10/2024.
//

import Foundation
import SwiftUI
import StoreKit
import UserNotifications


struct LandingView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @Environment(\.requestReview) var requestReview
    @State var showAnimation: Bool = false
    @State var timer: Timer?
    @Environment(\.openURL) var openURL
    @State var bottomImage: String = "betanoLanding"
    @State var firstTitle: String = "Save and Earn with Mr. Betano"
    @State var secondTitle: String = "Keep track of your expenses, analyze expenses, set goals and win!"
    @State var titleButton: String = "Support Us With Rate"
    @State var number: Int = 1 {
        didSet {
            switch number {
            case 1:
                bottomImage = "betanoLanding"
                firstTitle = "Save and Earn with Mr. Betano"
                secondTitle = "Keep track of your expenses, analyze expenses, set goals and win!"
                
            case 2:
                bottomImage = "peopleRat"
                firstTitle = "Join the winners"
                secondTitle = "Hundreds of people have already found success! Now it’s your turn!"
                titleButton = "Support Us With Rate"
                
            case 3:
                bottomImage = "fb"
                firstTitle = "Join the community"
                secondTitle = "Join us on Facebook and chat with like-minded people"
                titleButton = "Go to Facebook"
            case 4:
                bottomImage = "tipsSc"
                firstTitle = "Be always informed"
                secondTitle = "Turn on notifications and get useful tips every day!"
                titleButton = "Turn On"
            default:
                bottomImage = "betanoLanding"
            }
        }
    }
    var body: some View {
        ZStack {
            VStack {
                Text("Mr.Betano")
                    .font(.custom(Font.semiBold, size: 20))
                    .foregroundStyle(.white)
                    .scaleEffect(self.showAnimation ? 1 : 0)
                    .fixedSize(horizontal: false, vertical: true)
                    .animation(Animation.easeInOut.delay(showAnimation ?  0.2 : 0), value: showAnimation)
                
                Text("Using Savings")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(.white)
                    .offset(x: self.showAnimation ? 0 : -400)
                    .opacity(self.showAnimation ? 1 : 0)
                    .fixedSize(horizontal: false, vertical: true)
                    .animation(Animation.easeInOut.delay(showAnimation ? 0.4 : 0), value: showAnimation)
                
                VStack(spacing: 40 * (UIScreen.main.bounds.height > 680 ? 1 : 0.8)) {
                    Text(firstTitle)
                        .font(.custom(Font.semiBold, size: 32))
                        .foregroundStyle(.white)
                        .offset(x: self.showAnimation ? 0 : -500)
                        .opacity(self.showAnimation ? 1 : 0)
                        .fixedSize(horizontal: false, vertical: true)
                        .animation(Animation.easeInOut.delay(showAnimation ? 0.6 : 0), value: showAnimation)
                       
                    
                    Text(secondTitle)
                        .font(.custom(Font.semiBold, size: 18))
                        .foregroundStyle(.white)
                    
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .offset(x: self.showAnimation ? 0 : 500)
                        .opacity(self.showAnimation ? 1 : 0)
                        .animation(Animation.easeInOut.delay(showAnimation ? 0.8 : 0), value: showAnimation)
                }.padding(.top)
                
                VStack(spacing: UIScreen.main.bounds.height > 680 ? 10 : 4) {
                    VStack {
                        
                        Button(action: {
                            switch number {
                            case 3:
                                openURL(URL(string: "https://www.facebook.com/profile.php?id=100063214813097")!)
                                
                            case 4:
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                                    if granted {
                                        print("Notification permission granted")
                                        UserDefaults.standard.set(true, forKey: "hasRequestedNotifications")
                                    } else if let error = error {
                                        print("Error requesting notifications permission: \(error)")
                                    }
                                }
                            default:
                                requestReview()
                            }
                        }, label: {
                            actionButtonSecond()
                        })
                        .opacity(number >= 2 ? 1 : 0)
                    }
                    .frame(height: 52)
                    Button(action: {
                        
                        if number < 4 {
                            showAnimation = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                                
                                showAnimation = true
                                number += 1
                            }
                        } else {
                            navigationManager.goingToView(.wallet)
                        }
                    }, label: {
                        nextButton()
                    })
                    .disabled(!self.showAnimation)
                }
                .padding(.top, UIScreen.main.bounds.height > 680 ? 50 : 0)
                
               
                Spacer()
                
                
            }
            
            VStack {
              
                Spacer()
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.48)
                    .opacity(0)
                ZStack {
                    if self.number == 2 {
                        Image("starsRate")
                            .resizable()
                            .scaledToFit()
                            .offset(y: -100)
                    }
                    Image(bottomImage)
                                    .resizable()
                                    .scaledToFit()
                }
                    .offset(y: self.showAnimation ? 0 : 800)
                    .opacity(self.showAnimation ? 1 : 0)
                    .animation(Animation.easeInOut.delay( showAnimation ? 1 : 0), value: showAnimation)
            }
        }
        .padding(.top)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.showAnimation = true
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
                timer in
                if number == 4 {
                    checkNotificationAuthorizationStatus()
                }
            }
        }
       
    }
    
    func nextButton() -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.white)
            .overlay {
                Text(number > 2 ? "Later" : "Next")
                    .font(.custom(Font.semiBold, size: 18))
                    .foregroundStyle(Color.init(hex: "#FE3B00"))
                    .animation(.none, value: showAnimation)
            }
            .frame(width: 89, height: 52)
            .mask {
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 89 * (self.showAnimation ? 1 : 0))
            }
            .animation(Animation.easeInOut.delay(showAnimation ? 0.90 : 0), value: showAnimation)
    }
    
    func checkNotificationAuthorizationStatus() {
           UNUserNotificationCenter.current().getNotificationSettings { settings in
               DispatchQueue.main.async {
                   if  settings.authorizationStatus == .authorized {
                       timer?.invalidate()
                       self.navigationManager.goingToView(.wallet)
                   } else if settings.authorizationStatus == .denied {
                       timer?.invalidate()
                       self.navigationManager.goingToView(.wallet)
                   }
               }
           }
       }
    func actionButtonSecond() -> some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color.white)
            .overlay {
                Text(titleButton)
                    .font(.custom(Font.semiBold, size: 18))
                    .foregroundStyle(Color.init(hex: "#FE3B00"))
                    .animation(.none, value: showAnimation)
            }
            .frame(width: 241, height: 52)
            .mask {
                RoundedRectangle(cornerRadius: 24)
                    .frame(width: 241 * (self.showAnimation ? 1 : 0))
            }
            .animation(Animation.easeInOut.delay(showAnimation ? 0.85 : 0), value: showAnimation)
    }
}

extension Font {
    static var semiBold: String = "Inter28pt-SemiBold"
    static var bold: String = "Inter28pt-Bold"
    static var medium: String = "Inter28pt-Medium.ttf"
}
