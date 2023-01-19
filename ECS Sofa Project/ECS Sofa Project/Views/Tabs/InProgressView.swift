//
//  InProgress.swift
//  ECS Sofa Project
//
//  Created by Leonardo Daniele on 11/01/23.
//

import SwiftUI

struct InProgressView: View {
    @ObservedObject var viewModel = PortfolioViewModel()
    
    var body: some View {
        Text("Hello, World")
    }
}

struct InProgress_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView()
    }
}
