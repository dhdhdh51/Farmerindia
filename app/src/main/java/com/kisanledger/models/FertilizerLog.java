package com.kisanledger.models;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class FertilizerLog {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String fertilizerName;
    public String quantity;
    public long usedDate;
    public int remindAfterDays;
}
