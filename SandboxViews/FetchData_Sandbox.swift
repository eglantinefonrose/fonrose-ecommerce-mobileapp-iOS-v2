//
//  FetchData_Sandbox.swift
//  fonrose-ecommerceV2
//
//  Created by Eglantine Fonrose on 28/04/2023.
//  Copyright © 2023 fonrose. All rights reserved.
//

import SwiftUI

struct FetchData_Sandbox: View {
    
    @EnvironmentObject var bigModel: BigModel
    @State var show = false
    
    var body: some View {
        ZStack {
            
            if show {
                VStack {
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[0].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[1].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[2].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[3].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[4].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[5].measurementName ?? "nil")
                    Text(bigModel.user.persons[bigModel.currentPersonIndex ?? 0].measurements?.measurements[6].measurementName ?? "nil")
                    Text("💋")
                        .onTapGesture {
                            show = false
                        }
                }
            }
            
            if !show {
                VStack {
                    Text("🤪")
                        .onTapGesture {
                            
                            Task {
                                //await bigModel.updateMeasurementModel()
                                show = true
                            }
                            
                        }
                }
            }
                
        }.onAppear {
            bigModel.fetchAllMeasurementInfo()
        }
    }
}

struct FetchData_Sandbox_Previews: PreviewProvider {
    static var previews: some View {
        FetchData_Sandbox()
            .environmentObject(BigModel())
    }
}
