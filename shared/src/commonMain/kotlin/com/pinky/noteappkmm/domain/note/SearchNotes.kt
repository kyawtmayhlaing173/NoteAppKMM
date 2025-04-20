package com.pinky.noteappkmm.domain.note

import com.pinky.noteappkmm.presentation.utils.DateTimeUtil

class SearchNotes {
    fun execute(notes: List<Note>, query: String): List<Note> {
        if (query.isEmpty()) {
            return notes
        }
        return notes.filter {
            it.title.trim().lowercase().contains(query.lowercase()) || it.content.trim().lowercase().contains(query.lowercase())
        }.sortedBy {
            DateTimeUtil.toEpochMillis(it.created)
        }
    }
}