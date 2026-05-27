package com.kisanledger.activities;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.kisanledger.R;

public class SimpleSectionFragment extends Fragment {
    private static final String ARG_TITLE = "title";
    public static SimpleSectionFragment newInstance(String title) {
        SimpleSectionFragment fragment = new SimpleSectionFragment();
        Bundle b = new Bundle(); b.putString(ARG_TITLE, title); fragment.setArguments(b); return fragment;
    }

    @Nullable @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_simple, container, false);
        TextView tv = v.findViewById(R.id.sectionTitle);
        tv.setText(getArguments() != null ? getArguments().getString(ARG_TITLE) : "Section");
        return v;
    }
}
