package com.pinky.noteappkmm.di

import com.pinky.noteappkmm.data.local.DatabaseDriverFactory
import com.pinky.noteappkmm.data.note.SqlDelightNoteDataSource
import com.pinky.noteappkmm.database.NoteDatabase
import com.pinky.noteappkmm.domain.note.NoteDataSource

class DatabaseModule {
    private val factory by lazy { DatabaseDriverFactory() }
    val noteDataSource: NoteDataSource by lazy {
        SqlDelightNoteDataSource(NoteDatabase(factory.createDriver()))
    }
}