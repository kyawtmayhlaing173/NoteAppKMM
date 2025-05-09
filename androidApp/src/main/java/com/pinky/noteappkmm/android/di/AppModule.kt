package com.pinky.noteappkmm.android.di

import android.app.Application
import app.cash.sqldelight.db.SqlDriver
import com.pinky.noteappkmm.data.local.DatabaseDriverFactory
import com.pinky.noteappkmm.data.note.SqlDelightNoteDataSource
import com.pinky.noteappkmm.database.NoteDatabase
import com.pinky.noteappkmm.domain.note.NoteDataSource
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {
    @Provides
    @Singleton
    fun provideSqlDriver(app: Application): SqlDriver {
        return DatabaseDriverFactory(app).createDriver()
    }

    @Provides
    @Singleton
    fun provideNoteDataSource(driver: SqlDriver): NoteDataSource {
        return SqlDelightNoteDataSource(NoteDatabase(driver))
    }
}