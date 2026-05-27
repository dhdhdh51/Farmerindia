package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import com.google.android.material.button.MaterialButton;
import com.kisanledger.R;
import com.kisanledger.utils.PrefsManager;

public class OnboardingActivity extends BaseActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_onboarding);
        MaterialButton btn = findViewById(R.id.btnStart);
        btn.setOnClickListener(v -> {
            PrefsManager.setOnboardingDone(this, true);
            startActivity(new Intent(this, MainActivity.class));
            finish();
        });
    }
}
