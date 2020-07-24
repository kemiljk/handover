//
//  SettingsModal.swift
//  Px ›› Em
//
//  Created by Karl Koch on 22/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct SettingsModalView: View {
    enum BMAppIcon: CaseIterable {
        case classic,
        innerShadow,
        neuomorphic,
        gradient,
        shadow,
        white,
        black

        var name: String? {
            switch self {
               case .classic:
                    return nil
                case .innerShadow:
                    return "innerShadowIcon"
                case .neuomorphic:
                    return "neuomorphicIcon"
                case .gradient:
                    return "gradientIcon"
                case .shadow:
                    return "shadowIcon"
                case .white:
                    return "whiteIcon"
                case .black:
                return "blackIcon"
            }
        }

        var preview: UIImage {
            switch self {
                case .classic:
                    return #imageLiteral(resourceName: "classic")
                case .innerShadow:
                    return #imageLiteral(resourceName: "innerShadow")
                case .neuomorphic:
                    return #imageLiteral(resourceName: "neuomorphic")
                case .gradient:
                    return #imageLiteral(resourceName: "gradient")
                case .shadow:
                    return #imageLiteral(resourceName: "shadow")
                case .white:
                    return #imageLiteral(resourceName: "white")
                case .black:
                    return #imageLiteral(resourceName: "black")
            }
        }
    }
    
    var current: BMAppIcon {
         return BMAppIcon.allCases.first(where: {
           $0.name == UIApplication.shared.alternateIconName
         }) ?? .classic
       }

       func setIcon(_ appIcon: BMAppIcon, completion: ((Bool) -> Void)? = nil) {
         
         guard current != appIcon,
           UIApplication.shared.supportsAlternateIcons
           else { return }
               
         UIApplication.shared.setAlternateIconName(appIcon.name) { error in
           if let error = error {
             print("Error setting alternate icon \(appIcon.name ?? ""): \(error.localizedDescription)")
           }
           completion?(error != nil)
         }
       }
    
    let success = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack {
            Image(systemName: "chevron.compact.down").font(.system(size: 40, weight: .semibold)).padding(.top, 20).foregroundColor(Color.secondary)
            VStack (alignment: .center) {
                Text("Change app icon").bold()
                    .font(.system(.title, design: .rounded))
                    .padding()
            }
            VStack (alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: {
                        self.setIcon(.classic)
                        self.success.impactOccurred()
                    }) {
                    Text("Default")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image("classic")
                    .renderingMode(.original)
                    .cornerRadius(15)
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.innerShadow)
                        self.success.impactOccurred()
                    }) {
                    Text("Inner Shadow")
                        .foregroundColor(Color.primary)
                    Spacer()
                    
                    Image("innerShadow")
                    .renderingMode(.original)
                    .cornerRadius(15)
                        
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.neuomorphic)
                        self.success.impactOccurred()
                    }) {
                    Text("Neuomorphic")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image("neuomorphic")
                    .renderingMode(.original)
                    .cornerRadius(15)
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.gradient)
                        self.success.impactOccurred()
                    }) {
                        Text("Gradient")
                            .foregroundColor(Color.primary)
                    Spacer()
                    Image("gradient")
                    .renderingMode(.original)
                    .cornerRadius(15)
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.shadow)
                        self.success.impactOccurred()
                    }) {
                    Text("Shadow")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image("shadow")
                    .renderingMode(.original)
                    .cornerRadius(15)
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.white)
                        self.success.impactOccurred()
                    }) {
                    Text("White")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image("white")
                    .renderingMode(.original)
                    .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 0.4), lineWidth: 1))
                    }
                }
                HStack {
                    Button(action: {
                        self.setIcon(.black)
                        self.success.impactOccurred()
                    }) {
                    Text("Black")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Image("black")
                    .renderingMode(.original)
                    .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 0.4), lineWidth: 1))
                    }
                }
                }.padding(.leading, 32).padding(.trailing, 32)
            Spacer()
        }
    }
}

struct SettingsModal_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModalView()
    }
}
