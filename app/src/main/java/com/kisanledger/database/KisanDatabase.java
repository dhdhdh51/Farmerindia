package com.kisanledger.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.kisanledger.models.ExpenseEntity;
import com.kisanledger.models.FieldEntity;

@Database(entities = {FieldEntity.class, ExpenseEntity.class}, version = 1)
public abstract class KisanDatabase extends RoomDatabase {
    public abstract KisanDao kisanDao();
    private static volatile KisanDatabase INSTANCE;

    public static KisanDatabase getInstance(Context context) {
        if (INSTANCE == null) {
            synchronized (KisanDatabase.class) {
                if (INSTANCE == null) {
                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(), KisanDatabase.class, "kisan_ledger.db").build();
                }
            }
        }
        return INSTANCE;
    }
}
