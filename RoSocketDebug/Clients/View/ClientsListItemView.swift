//
//  ClientsListItemView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/16.
//

import SwiftUI

struct ClientsListItemView: View {
    @ObservedObject var clientViewModel: ClientViewModel
    @Binding var selectedClientViewModel: ClientViewModel?
    var body: some View {
        HStack{
            Image(systemName: clientViewModel.isConnected ? "waveform":"waveform.slash")
                .resizable()
                .frame(width: 16,height: 16)
                .foregroundColor(clientViewModel.isConnected ? Color.green:Color.red)
            Text(clientViewModel.clientDescription)
                .font(.title3)
                .foregroundColor(clientViewModel.isConnected ? .primary : .secondary)
            
        }.padding(7)
            .overlay(alignment: .center, content: {
                
                    if(selectedClientViewModel != nil){
                        if(clientViewModel == selectedClientViewModel!){
                            withAnimation{
                            RoundedRectangle(cornerRadius: 6,style: .continuous)
                                .strokeBorder(.gray, lineWidth: 1)
                            
                        }
                    }
                }
            })
            .padding([.top,.bottom],5)
            .padding([.leading,.trailing],10)
        
    }
}

struct ClientsListItemView_Previews: PreviewProvider {
    static var client = ClientViewModel()
    static var previews: some View {
        ClientsListItemView(clientViewModel: ClientsListItemView_Previews.client, selectedClientViewModel: .constant(ClientsListItemView_Previews.client))
    }
}
