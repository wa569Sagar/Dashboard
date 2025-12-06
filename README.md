# EXCO Monthly Reporting Dashboard

An interactive Streamlit dashboard for Executive Committee (EXCO) monthly recommendation tracking.

## Features

- 📊 **KPI Cards** - Total recommendations, Active/Open, Overdue, Due in 30 Days
- 📈 **Interactive Charts** - Severity distribution, Status breakdown, Deadline trends
- 👥 **Board Insights** - Per-member statistics and workload visualization
- 🔍 **Advanced Filters** - Filter by board member, severity, status, legal entity
- 📋 **Data Explorer** - Sortable table with urgency-based highlighting
- 📥 **Export Options** - Download filtered data as CSV

## Deployment on Streamlit Cloud

1. Push this repo to GitHub
2. Go to [share.streamlit.io](https://share.streamlit.io)
3. Click "New app"
4. Select your repo and `exco_dashboard_app.py`
5. Click "Deploy"

## Local Development

```bash
# Install dependencies
pip install -r requirements.txt

# Run the app
streamlit run exco_dashboard_app.py
```

## Data

The dashboard reads from `EXCO_Report_Output.xlsx`. To update data:
1. Replace the Excel file with new data
2. Keep the same sheet names: "ECAG open Recos" and "SII Recommendations"
3. Redeploy or refresh the app

## Author

Satya Sagar Dandela
