//
//  ProfileView.swift
//  CITRARB
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI
import CachedAsyncImage


struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @State private var showToast = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("bgDay")
                    .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.5)
                                .frame(maxWidth: UIScreen.main.bounds.width,
                                       maxHeight: UIScreen.main.bounds.height)

                  if viewModel.isLoading == false{
                      VStack{
                           if let userProfile = viewModel.userProfileResponse{

                          
                          //Spacer()
                          Image(systemName: "person.circle.fill")
                              .font(.system(size: 120))
                               Text(userProfile.user.username)
                              .fontWeight(.semibold)
                              .font(.headline)
                               Text("Joined " + "\(formatDateToMonthAndYear(userProfile.user.createdAt) ?? "2023")")
                              .font(.callout)
                          
                          Form{
                              Section(header: Text("BIO")){
                                  ProfileBioDataView(userProfile: userProfile.user)
                                  
                              }
                              Section(header: Text("OCCUPATION")){
                                  ProfileOccupationDataView(userOccupation: userProfile.occupation)
                                  
                              }
                          }.background(Color.clear)
                          
                          Spacer()
                          
                          Text("Log Out")
                              .fontWeight(.bold)
                              .foregroundColor(.blue)
                              .padding(8)
                              .onTapGesture {
                                  
                              }
                          
                          Text("Deactivate Account")
                              .fontWeight(.bold)
                              .foregroundColor(.red)
                              .padding(8)
                              .onTapGesture {
                                  showAlert = true
                                  alertMessage = "Sure to deactivate account?"

                              }
                      }
                 
                    
                    //                            Text(userProfile.user.username)
                    //                            CachedAsyncImage(url: URL(string: "\(BASE_NORMAL_URL)\(userProfile.user.photo)"),
                    //                                             transaction: Transaction(animation: .easeInOut)){ phase in
                    //                                //set an animation to display the placeholder image
                    //                                if let image = phase.image{
                    //                                    image
                    //                                        .resizable()
                    //                                        .scaledToFit()
                    //                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    //                                        .transition(.opacity)
                    //                                        .frame(width: 120, height: 240)
                    //                                        .padding(4)
                    //                                }else{
                    //                                    HStack{
                    //                                        Image(systemName: "person.circle.fill")
                    //                                        ProgressView()
                    //                                    }
                    //
                    //                                }
                    //                            }
                    
                    //}
                }.refreshable {
                    viewModel.fetchUserProfile()
                }
                Spacer()
                }
                                else {
                                    // Show a loading view or error message while data is being fetched
                                    VStack{
                                        LottieView(filename: "loading")
                                            .frame(width: 120,  height: 120)
                                    }
                
                }
            }
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Warning!"),
                message: Text(alertMessage),
                primaryButton: .destructive(Text("Yes")) {
                    viewModel.deleteMe()

                    showAlert = false // Close the alert when OK is tapped
                },
                secondaryButton: .cancel() {
                    showAlert = false // Close the alert when Cancel is tapped
                }
            )
        }
        .onAppear{
            viewModel.fetchUserProfile()
        }.overlay(
            Group {
                if showToast {
                    ToastView(text: "This is a toast", isPresented: $showToast)
                        .transition(.move(edge: .bottom))
                }
            }
        )
        .navigationBarTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
