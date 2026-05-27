package com.kisanledger.viewmodel;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.kisanledger.models.ExpenseEntity;
import com.kisanledger.models.FieldEntity;
import com.kisanledger.repository.KisanRepository;

import java.util.List;

public class KisanViewModel extends AndroidViewModel {
    private final KisanRepository repository;

    public KisanViewModel(@NonNull Application application) {
        super(application);
        repository = new KisanRepository(application);
    }

    public LiveData<List<FieldEntity>> getFields() { return repository.getFields(); }
    public LiveData<List<ExpenseEntity>> getExpenses() { return repository.getExpenses(); }
    public LiveData<Double> getTotalExpense() { return repository.getTotalExpense(); }
    public void addField(FieldEntity f) { repository.insertField(f); }
    public void addExpense(ExpenseEntity e) { repository.insertExpense(e); }
}
