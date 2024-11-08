//
//  NoteModel.swift
//  Notes
//
//  Created by James Clifford on 11/2/24.
//

import Foundation
import FirebaseFirestore

struct NoteModel: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
