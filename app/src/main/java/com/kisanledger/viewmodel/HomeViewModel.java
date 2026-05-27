package com.kisanledger.viewmodel;

import android.app.Application;

import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;

import com.kisanledger.models.Expense;
import com.kisanledger.models.Field;
import com.kisanledger.models.ReminderItem;
import com.kisanledger.repository.KisanRepository;

import java.util.List;

public class HomeViewModel extends AndroidViewModel {
    private final KisanRepository repository;

    public HomeViewModel(@NonNull Application application) {
        super(application);
        repository = new KisanRepository(application);
    }

    public LiveData<List<Field>> fields() { return repository.fields(); }
    public LiveData<List<Expense>> expenses() { return repository.expenses(); }
    public LiveData<List<ReminderItem>> upcoming() { return repository.upcoming(); }
}
