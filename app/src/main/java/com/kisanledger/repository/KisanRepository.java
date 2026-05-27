package com.kisanledger.repository;

import android.content.Context;
import androidx.lifecycle.LiveData;
import com.kisanledger.database.KisanDatabase;
import com.kisanledger.models.ExpenseRecord;
import com.kisanledger.models.FieldRecord;
import java.util.List;
import java.util.concurrent.Executors;

public class KisanRepository {
    private final KisanDatabase db;

    public KisanRepository(Context context) { this.db = KisanDatabase.getInstance(context); }

    public LiveData<List<FieldRecord>> getFields() { return db.kisanDao().getFields(); }
    public LiveData<List<ExpenseRecord>> getExpenses() { return db.kisanDao().getExpenses(); }

    public void addField(FieldRecord record) { Executors.newSingleThreadExecutor().execute(() -> db.kisanDao().insertField(record)); }
    public void addExpense(ExpenseRecord record) { Executors.newSingleThreadExecutor().execute(() -> db.kisanDao().insertExpense(record)); }
}
