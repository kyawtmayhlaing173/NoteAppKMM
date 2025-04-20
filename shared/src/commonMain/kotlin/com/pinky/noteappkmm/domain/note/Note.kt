package com.pinky.noteappkmm.domain.note

import com.pinky.noteappkmm.presentation.BabyBlueHex
import com.pinky.noteappkmm.presentation.LightGreenHex
import com.pinky.noteappkmm.presentation.RedOrangeHex
import com.pinky.noteappkmm.presentation.RedPinkHex
import com.pinky.noteappkmm.presentation.VioletHex
import kotlinx.datetime.LocalDateTime

data class Note(
    val id: Long?,
    val title: String,
    val content: String,
    val colorHex: Long,
    val created: LocalDateTime
) {
    companion object {
        private val colors = listOf(RedOrangeHex, RedPinkHex, BabyBlueHex, VioletHex, LightGreenHex)

        fun generateRandomColor() = colors.random()
    }
}