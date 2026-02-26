import pandas as pd
import numpy as np
 
# --- Configuration: Adjust these variables if needed ---
# I have updated these names to match your latest information.
EXCEL_FILE_NAME = 'CD710_Settlement_Analysis_Mar_Dec_2025 (2).xlsx'
SHEET_NAME = 'CD710 Analysis'
OUTPUT_FILE_NAME = 'unexplained_late_transactions.csv' # The name for the final report
 
# Define the columns you expect to be in the file
# IMPORTANT: Double-check these names against your Excel file's column headers.
# I am using the names from our previous discussions.
MEMBER_COL = 'Member'
TRANSACTION_TYPE_COL = 'Transaction Type Text'
DEBIT_COL = 'Debit'
CREDIT_COL = 'Credit'
DATE_OF_TRANSACTION_COL = 'Date of Transaction'
TRANSACTION_VALUE_DATE_COL = 'Transaction Value Date'
# --- End of Configuration ---
 
print("Starting the audit script...")
 
try:
    # 1. Load the data from the Excel sheet into a pandas DataFrame
    print(f"Loading data from '{EXCEL_FILE_NAME}'...")
    df = pd.read_excel(EXCEL_FILE_NAME, sheet_name=SHEET_NAME)
    print(f"Successfully loaded {len(df)} rows.")
 
    # 2. Clean and prepare the data
    print("Preparing data for analysis...")
    # Convert date columns to actual datetime objects
    df[DATE_OF_TRANSACTION_COL] = pd.to_datetime(df[DATE_OF_TRANSACTION_COL])
    df[TRANSACTION_VALUE_DATE_COL] = pd.to_datetime(df[TRANSACTION_VALUE_DATE_COL])
 
    # Create a single 'Amount' column
    df['Amount'] = df[DEBIT_COL].where(df[DEBIT_COL] > 0, df[CREDIT_COL])
 
    # Create a clear 'Status' column to identify 'Original' vs 'Rereported'
    # This checks if the word 'Rereported' exists in the transaction type text
    df['Status'] = np.where(df[TRANSACTION_TYPE_COL].str.contains('Rereported', case=False, na=False), 'Rereported', 'Original')
 
    # 3. Separate the data into two DataFrames
    originals_df = df[df['Status'] == 'Original'].copy()
    rereported_df = df[df['Status'] == 'Rereported'].copy()
    print(f"Separated into {len(originals_df)} Original and {len(rereported_df)} Rereported transactions.")
 
    # 4. Prepare the 'Rereported' data for matching
    # We create a "Join Key" which is the business day *before* the rereported transaction date.
    # This lets us match it back to the original failure date.
    rereported_df['JoinDate'] = rereported_df[DATE_OF_TRANSACTION_COL] - pd.tseries.offsets.BusinessDay(1)
 
    # 5. Perform a "Left Anti-Join" to find Originals with NO match
    print("Searching for Original transactions that were not corrected...")
    # We merge the originals with the rereported transactions. If an original has no match,
    # the columns from the rereported_df will be empty (NaN).
    unmatched_originals = pd.merge(
        originals_df,
        rereported_df[['JoinDate', MEMBER_COL, 'Amount', TRANSACTION_VALUE_DATE_COL]],
        how='left',
        left_on=[DATE_OF_TRANSACTION_COL, MEMBER_COL, 'Amount', TRANSACTION_VALUE_DATE_COL],
        right_on=['JoinDate', MEMBER_COL, 'Amount', TRANSACTION_VALUE_DATE_COL],
        indicator=True
    )
 
    # Keep only the rows that were 'left_only' (i.e., had no match in the rereported table)
    unmatched_originals = unmatched_originals[unmatched_originals['_merge'] == 'left_only']
    print(f"Found {len(unmatched_originals)} Original transactions with no corresponding Rereported entry.")
 
    # 6. From the unmatched, find the ones that are actually 'late'
    print("Calculating settlement times for unmatched transactions...")
    # Calculate the number of business days between transaction and settlement
    unmatched_originals['BusinessDaysToSettle'] = np.busday_count(
        unmatched_originals[DATE_OF_TRANSACTION_COL].values.astype('datetime64[D]'),
        unmatched_originals[TRANSACTION_VALUE_DATE_COL].values.astype('datetime64[D]')
    )
 
    # Filter for transactions that took more than 2 business days (T+3 or more)
    late_unexplained_df = unmatched_originals[unmatched_originals['BusinessDaysToSettle'] > 2].copy()
    print(f"Identified {len(late_unexplained_df)} transactions that are late (>T+2) and unexplained.")
 
    # 7. Save the final list to a CSV file for review
    if not late_unexplained_df.empty:
        # Clean up the final report by dropping helper columns
        columns_to_drop = ['Status', '_merge', 'JoinDate']
        late_unexplained_df.drop(columns=columns_to_drop, inplace=True, errors='ignore')
        late_unexplained_df.to_csv(OUTPUT_FILE_NAME, index=False)
        print(f"\nSUCCESS: A report named '{OUTPUT_FILE_NAME}' has been created with the {len(late_unexplained_df)} unexplained late transactions.")
        print("You should now manually investigate these items for alternative currency settlements (Step 2).")
    else:
        print("\nSUCCESS: No unexplained late transactions were found!")
 
except FileNotFoundError:
    print(f"\nERROR: The file '{EXCEL_FILE_NAME}' was not found. Please make sure it's in the same folder as the script.")
except KeyError as e:
    print(f"\nERROR: A column was not found in your Excel file. Please check the column names in the configuration section.")
    print(f"The column that caused the error was: {e}")
except Exception as e:
    print(f"\nAn unexpected error occurred: {e}")
 
