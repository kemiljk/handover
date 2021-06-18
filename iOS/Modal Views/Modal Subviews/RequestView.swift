//
//  AboutView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 20/09/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI
import MessageUI
import UIKit

struct RequestView: View {
    let success = UIImpactFeedbackGenerator(style: .medium)
    @Environment(\.presentationMode) private var presentationMode
    var device = UIDevice.current.userInterfaceIdiom
    @State private var sendEmail: Bool = false
    
    let appleMail = URL(string: "mailto:karl+pxToEmFeatureRequest@kejk.tech")
    let outlook = URL(string: "ms-outlook://compose?to=karl+pxToEmFeatureRequest@kejk.tech")
    let gmail = URL(string: "googlegmail://co?to=karl+pxToEmFeatureRequest@kejk.tech")
    let spark = URL(string: "readdle-spark://compose?recipient=karl+pxToEmFeatureRequest@kejk.tech")
    let yahoo = URL(string: "ymail://mail/compose?to=karl+pxToEmFeatureRequest@kejk.tech")
    
    var body: some View {
        VStack {
            VStack (alignment: .leading,  spacing: 16) {
                Text("Thanks!")
                    .font(.title).bold()
                Text("First thing's first, thank you so much for using Hand››over!")
                Text("This app started as a Figma plugin and a desire to learn SwiftUI. It's now slowly morphing into my playground for learning new elements of the framework and hopefully providing greater utility to you as a customer.")
                Text("I'm just a single developer creating this in my spare time, but I welcome any potential feature requests you might have. Please fire me over an email using the button below and I'll do my best to get back to you and put your request on my roadmap if I can!")
            }
            .font(.system(.body))
            Spacer()
            VStack (alignment: .center) {
                Button(action: {
                    self.sendEmail = true
                    self.success.impactOccurred()
                 })
                {
                     Text("Submit feature request")
                        .foregroundColor(Color("shape"))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                 }
                .padding(.vertical, 16)
                .padding(.horizontal, 48)
                .background(Color("orange"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .contentShape(Capsule(style: .continuous))
                .hoverEffect(.highlight)
                .actionSheet(isPresented: $sendEmail) {
                    ActionSheet(
                        title: Text("Open email app"),
                        message: Text("Available email apps"),
                        buttons: [
                            .cancel { print(self.sendEmail) },
                            .default(Text("Apple Mail"), action: {
                                if UIApplication.shared.canOpenURL(appleMail!) {
                                     UIApplication.shared.open(appleMail!, options: [:], completionHandler: nil)
                                }
                            }),
                            .default(Text("Outlook"), action: {
                                if UIApplication.shared.canOpenURL(outlook!) {
                                     UIApplication.shared.open(outlook!, options: [:], completionHandler: nil)
                                }
                            }),
                            .default(Text("Gmail"), action: {
                                if UIApplication.shared.canOpenURL(gmail!) {
                                    UIApplication.shared.open(gmail!, options: [:], completionHandler: nil)
                                }
                            }),
                            .default(Text("Spark"), action: {
                                if UIApplication.shared.canOpenURL(spark!) {
                                     UIApplication.shared.open(spark!, options: [:], completionHandler: nil)
                                }
                            }),
                            .default(Text("Yahoo"), action: {
                                if UIApplication.shared.canOpenURL(yahoo!) {
                                     UIApplication.shared.open(yahoo!, options: [:], completionHandler: nil)
                                }
                            })
                        ]
                    )
                }
            }
        }
        .padding()
        .navigationBarTitle("Submit a feature request")
        Spacer()
    }
}


struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestView()
    }
}
