//
//  ServersListItemView.swift
//  RoSocketDebug
//
//  Created by rolodestar on 2023/1/17.
//

import SwiftUI




struct ServersListItemView: View {
    @ObservedObject var serverViewModel: ServerViewModel
    @Binding var selectedServerViewModel: ServerViewModel?
    var isForClientView:Bool = true
    var body: some View {
        HStack{
            Image(systemName: serverViewModel.clients.count > 0 ? "waveform":"waveform.slash")
                .resizable()
                .frame(width: 16,height: 16)
                .foregroundColor(serverViewModel.clients.count > 0 ? Color.green:Color.red)
//            Text(isForClientView ? clientViewModel.connectDescription  : clientViewModel.localDescription)
            Text(serverViewModel.serverDescription )
                .font(.title3)
                .foregroundColor(serverViewModel.clients.count > 0 ? .primary : .secondary)
            
        }.padding(7)
            .overlay(alignment: .center, content: {
                
                    if(selectedServerViewModel != nil){
                        if(serverViewModel == selectedServerViewModel!){
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

struct ServersListItemView_Previews: PreviewProvider {
    static var client = ClientViewModel()
    static var previews: some View {
        ServersListItemView(serverViewModel: ServerViewModel(), selectedServerViewModel: .constant(ServerViewModel()))
    }
}
