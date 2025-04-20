package com.pinky.noteappkmm.data.note

import com.pinky.noteappkmm.database.NoteDatabase
import com.pinky.noteappkmm.domain.note.Note
import com.pinky.noteappkmm.domain.note.NoteDataSource
import com.pinky.noteappkmm.presentation.utils.DateTimeUtil

class SqlDelightNoteDataSource(db: NoteDatabase): NoteDataSource {
    private val queries = db.noteQueries
    override suspend fun getAllNotes(): List<Note> {
        return queries.getAllNotes()
            .executeAsList()
            .map { it.toNote() }
    }

    override suspend fun getNoteById(id: Long): Note? {
        return queries.getNoteById(id = id)
            .executeAsOneOrNull()
            ?.toNote()
    }

    override suspend fun insertNote(note: Note) {
        queries.insertNote(
            id = note.id,
            title = note.title,
            content = note.content,
            colorHex = note.colorHex,
            created = DateTimeUtil.toEpochMillis(note.created)
        )
    }

    override suspend fun deleteNoteById(id: Long) {
        queries.deleteNote(id)
    }

}