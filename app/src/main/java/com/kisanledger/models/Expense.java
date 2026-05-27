package com.kisanledger.models;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity
public class Expense {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String category;
    public double amount;
    public long date;
    public String notes;
    public String crop;
}
