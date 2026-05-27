package com.kisanledger.models;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class WateringLog {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public long wateringDate;
    public String source;
    public float motorHours;
}
