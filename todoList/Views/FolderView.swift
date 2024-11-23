//
//  FolderView.swift
//  todoList
//
//  Created by Trey Bertram on 2023-09-20.
//

import SwiftUI

struct FolderView: View {
    //@StateObject var viewModel = FolderViewViewModel()
    let folder: Folder

    
    var body: some View {
        HStack {
            
            Text(folder.name)
                .font(.body)
            Spacer()
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
    }
        
}


struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(folder: Folder(id: "1", name: "Folder 1"))
    }
}
