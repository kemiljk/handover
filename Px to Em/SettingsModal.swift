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
        black,
        blackSmall,
        whiteSmall,
        orangeInnerShadow,
        orangeNeuo,
        darkGrey,
        orangeMono,
        greyScale,
        whiteSmallShadow,
        blackSmallShadow

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
                case .blackSmall:
                    return "blackSmallIcon"
                case .whiteSmall:
                    return "whiteSmallIcon"
                case .blackSmallShadow:
                    return "blackSmallShadowIcon"
                case .whiteSmallShadow:
                    return "whiteSmallShadowIcon"
                case .orangeMono:
                    return "orangeMonoIcon"
                case .orangeNeuo:
                    return "orangeNeuoIcon"
                case .orangeInnerShadow:
                    return "orangeInnerShadowIcon"
                case .darkGrey:
                    return "darkGreyIcon"
                case .greyScale:
                    return "greyScaleIcon"
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
                case .blackSmall:
                    return #imageLiteral(resourceName: "blackSmall")
                case .blackSmallShadow:
                    return #imageLiteral(resourceName: "blackSmallShadow")
                case .whiteSmall:
                    return #imageLiteral(resourceName: "whiteSmall")
                case .whiteSmallShadow:
                    return #imageLiteral(resourceName: "whiteSmallShadow")
                case .orangeMono:
                    return #imageLiteral(resourceName: "orangeMono")
                case .orangeNeuo:
                    return #imageLiteral(resourceName: "orangeNeuo")
                case .orangeInnerShadow:
                    return #imageLiteral(resourceName: "orangeInnerShadow")
                case .darkGrey:
                    return #imageLiteral(resourceName: "darkGrey")
                case .greyScale:
                    return #imageLiteral(resourceName: "greyScale")
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
    @Environment(\.presentationMode) private var presentationMode
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack {
            if device == .phone {
            Image(systemName: "chevron.compact.down").font(.system(size: 40, weight: .semibold)).padding(.top, 20).foregroundColor(Color.secondary)
            }
            else {
                HStack {
                    Spacer()
                    Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done").bold()
                        .foregroundColor(Color("teal"))
                    }
                    .padding()
                }
            }
            VStack (alignment: .center) {
                Text("Change app icon").bold()
                    .font(.system(.title, design: .rounded))
                    .padding()
            }
            VStack (alignment: .leading, spacing: 24) {
                HStack (spacing: 24) {
                    HStack {
                        Button(action: {
                            self.setIcon(.classic)
                            self.success.impactOccurred()
                        }) {
                        Image("classic")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.shadow)
                            self.success.impactOccurred()
                        }) {
                        Image("shadow")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.gradient)
                            self.success.impactOccurred()
                        }) {
                        Image("gradient")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.innerShadow)
                            self.success.impactOccurred()
                        }) {
                        Image("innerShadow")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                }
                HStack (spacing: 24) {
                    HStack {
                        Button(action: {
                            self.setIcon(.neuomorphic)
                            self.success.impactOccurred()
                        }) {
                        Image("neuomorphic")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.white)
                            self.success.impactOccurred()
                        }) {
                        Image("white")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.black)
                            self.success.impactOccurred()
                        }) {
                        Image("black")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.darkGrey)
                            self.success.impactOccurred()
                        }) {
                        Image("darkGrey")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                }
                HStack (spacing: 24) {
                    HStack {
                        Button(action: {
                            self.setIcon(.greyScale)
                            self.success.impactOccurred()
                        }) {
                        Image("greyScale")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.orangeMono)
                            self.success.impactOccurred()
                        }) {
                        Image("orangeMono")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.orangeInnerShadow)
                            self.success.impactOccurred()
                        }) {
                        Image("orangeInnerShadow")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.orangeNeuo)
                            self.success.impactOccurred()
                        }) {
                        Image("orangeNeuo")
                        .renderingMode(.original)
                        .cornerRadius(15)
                        }
                    }
                }
                HStack (spacing: 24) {
                    HStack {
                        Button(action: {
                            self.setIcon(.blackSmall)
                            self.success.impactOccurred()
                        }) {
                        Image("blackSmall")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.whiteSmall)
                            self.success.impactOccurred()
                        }) {
                        Image("whiteSmall")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.blackSmallShadow)
                            self.success.impactOccurred()
                        }) {
                        Image("blackSmallShadow")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                    HStack {
                        Button(action: {
                            self.setIcon(.whiteSmallShadow)
                            self.success.impactOccurred()
                        }) {
                        Image("whiteSmallShadow")
                        .renderingMode(.original)
                        .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("teal"), lineWidth: 1))
                        }
                    }
                }
            }.padding(.leading, 32).padding(.trailing, 32).padding(.top, 32)
            Spacer()
        }
    }
}

struct SettingsModal_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModalView()
    }
}
