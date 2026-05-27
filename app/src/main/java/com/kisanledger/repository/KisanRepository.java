package com.kisanledger.repository;

import android.app.Application;

import androidx.lifecycle.LiveData;

import com.kisanledger.database.KisanDao;
import com.kisanledger.database.KisanDatabase;
import com.kisanledger.models.ExpenseEntity;
import com.kisanledger.models.FieldEntity;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class KisanRepository {
    private final KisanDao dao;
    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    public KisanRepository(Application application) {
        dao = KisanDatabase.getInstance(application).kisanDao();
    }

    public LiveData<List<FieldEntity>> getFields() { return dao.getAllFields(); }
    public LiveData<List<ExpenseEntity>> getExpenses() { return dao.getAllExpenses(); }
    public LiveData<Double> getTotalExpense() { return dao.getTotalExpense(); }

    public void insertField(FieldEntity field) { executorService.execute(() -> dao.insertField(field)); }
    public void insertExpense(ExpenseEntity expense) { executorService.execute(() -> dao.insertExpense(expense)); }
}
