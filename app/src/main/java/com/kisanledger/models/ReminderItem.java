package com.kisanledger.models;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "reminders")
public class ReminderItem {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String type;
    public String title;
    public long targetDateMillis;
    public int repeatDays;
}
