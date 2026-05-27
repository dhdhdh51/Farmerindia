package com.kisanledger.repository;

import android.content.Context;

import androidx.lifecycle.LiveData;

import com.kisanledger.database.KisanDatabase;
import com.kisanledger.models.Expense;
import com.kisanledger.models.Field;
import com.kisanledger.models.ReminderItem;

import java.util.List;
import java.util.concurrent.Executors;

public class KisanRepository {
    private final KisanDatabase db;

    public KisanRepository(Context context) { db = KisanDatabase.getInstance(context); }

    public LiveData<List<Field>> fields() { return db.dao().getAllFields(); }
    public LiveData<List<Expense>> expenses() { return db.dao().getAllExpenses(); }
    public LiveData<List<ReminderItem>> upcoming() { return db.dao().getUpcoming(System.currentTimeMillis()); }

    public void addField(Field field) { Executors.newSingleThreadExecutor().execute(() -> db.dao().insertField(field)); }
}
