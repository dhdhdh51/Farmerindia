package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.kisanledger.R;

public class SplashActivity extends BaseActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        getWindow().getDecorView().postDelayed(() -> {
            startActivity(new Intent(this, OnboardingActivity.class));
            finish();
        }, 1200);
    }
}
