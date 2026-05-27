package com.kisanledger.activities;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import com.kisanledger.R;
import com.kisanledger.utils.PrefsManager;

public class SplashActivity extends BaseActivity {
    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        new Handler().postDelayed(() -> {
            Class<?> next = PrefsManager.isOnboardingDone(this) ? MainActivity.class : OnboardingActivity.class;
            startActivity(new Intent(this, next));
            finish();
        }, 1400);
    }
}
