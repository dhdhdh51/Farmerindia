package com.kisanledger.models;

import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "fields")
public class Field {
    @PrimaryKey(autoGenerate = true)
    public int id;
    public String name;
    public double latitude;
    public double longitude;
    public float area;
    public String cropType;
    public String soilType;
    public String imagePath;
    public String notes;
}
