package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.kisanledger.R;

public class ExpenseActivity extends BaseActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_expense);
    }
}
