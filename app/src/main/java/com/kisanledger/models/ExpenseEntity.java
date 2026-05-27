package com.kisanledger.models;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "expenses")
public class ExpenseEntity {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String category;
    public double amount;
    public long dateMillis;
    public String notes;
}
