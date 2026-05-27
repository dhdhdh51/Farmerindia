package com.kisanledger.models;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class DiaryEntry {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public long date;
    public String note;
    public String imagePath;
}
