package com.kisanledger.viewmodel;

import android.app.Application;
import androidx.annotation.NonNull;
import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import com.kisanledger.models.ExpenseRecord;
import com.kisanledger.models.FieldRecord;
import com.kisanledger.repository.KisanRepository;
import java.util.List;

public class HomeViewModel extends AndroidViewModel {
    private final KisanRepository repository;

    public HomeViewModel(@NonNull Application application) {
        super(application);
        repository = new KisanRepository(application);
    }

    public LiveData<List<FieldRecord>> getFields() { return repository.getFields(); }
    public LiveData<List<ExpenseRecord>> getExpenses() { return repository.getExpenses(); }
}
