package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;
import com.github.mikephil.charting.charts.PieChart;
import com.google.android.material.card.MaterialCardView;
import com.kisanledger.R;
import com.kisanledger.database.AppDatabase;

public class MainActivity extends BaseActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        AppDatabase db = AppDatabase.get(this);
        TextView tvField = findViewById(R.id.tvTotalFields);
        TextView tvExpense = findViewById(R.id.tvTotalExpenses);
        tvField.setText(String.valueOf(db.fieldDao().count()));
        tvExpense.setText("₹ " + db.expenseDao().sumAll());
        PieChart chart = findViewById(R.id.expenseChart);
        chart.setCenterText(getString(R.string.monthly_expenses));
        chart.invalidate();

        ((MaterialCardView)findViewById(R.id.cardFields)).setOnClickListener(v -> startActivity(new Intent(this, FieldListActivity.class)));
        findViewById(R.id.btnExpense).setOnClickListener(v -> startActivity(new Intent(this, ExpenseActivity.class)));
        findViewById(R.id.btnFertilizer).setOnClickListener(v -> startActivity(new Intent(this, FertilizerActivity.class)));
        findViewById(R.id.btnWatering).setOnClickListener(v -> startActivity(new Intent(this, WateringActivity.class)));
        findViewById(R.id.btnReports).setOnClickListener(v -> startActivity(new Intent(this, ReportsActivity.class)));
    }
}
