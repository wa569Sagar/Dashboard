✅ Step 1: Search for a Corrective "Rereported" Transaction
This is the most common reason for what appears to be a delay. You are checking if the failed payment was successfully corrected on the next business day.
Question to Answer: Was this failed payment simply re-attempted and corrected?
What to Look For in Your Excel File:
Note the Details of the Late Transaction:
Member Name (e.g., INELO)
Debit or Credit Amount (e.g., 193.72)
Transaction Value Date (e.g., 2026-01-02)
Search Your Data: Look for another transaction that has:
The exact same Member, Debit/Credit amount, and Transaction Value Date.
The Original / Rereported column says "Rereported".
The Date of Transaction is one business day after the late transaction's Date of Transaction.
Conclusion for this step:
If you find this matching pair: This is a Handled Exception. The control for fixing failed payments worked correctly. You can document this and move to the next late item.
If you do NOT find a matching pair: This is potentially a bigger issue. Proceed to Step 2.
✅ Step 2: Search for an Alternative Currency Payment
The procedure document mentions that if a debit is expected to fail, the team might agree with the member to collect the funds in an alternative currency. This is a manual process.
Question to Answer: Was the failed payment settled manually in a different currency?
What to Look For in Your Excel File:
Look at the Same Member: Focus on the same member from your late transaction.
Check the Same and Next Business Day: Look at all transactions for that member on both the Date of Transaction and the day after.
Look for Manual or Odd Transactions: Search for transactions that look different from the rest. The Transaction Type Text might be unusual or indicate a manual booking. The amount will not be the same, but it might be a rough equivalent in a major currency like EUR or USD.
Conclusion for this step:
If you find a plausible alternative payment: This is likely a Handled Exception. It indicates the team followed the manual exception procedure. You may need to ask the cash management team for the written confirmation (email) mentioned in their procedures to fully verify this.
If you find nothing: The late payment remains unexplained. Proceed to Step 3.
✅ Step 3: Investigate as a Potential Control Failure
If you have completed Steps 1 and 2 and still have an unexplained late settlement, you have found a potential control weakness. Now you need to check if the other controls for late payments were followed.
Question to Answer: If the payment genuinely failed and was not corrected, was it properly managed and penalized according to the procedure?
What to Request from the Business/Operations Team (this evidence won't be in your file):
Evidence of Escalation: Ask for emails or system logs showing that the late payment was reported to the Head of Unit/Section, as required by the procedure (especially for large amounts).
Evidence of Penalty: Ask for the "dedicated Excel sheet" used for penalty calculations. Was a penalty calculated for this late payment? Was a formal notification sent to the member?
Evidence of Contact: Ask for any logs or notes documenting the phone call that should have been made to the member regarding the late payment.
Conclusion for this step:
If the team provides this evidence: The settlement control failed, but the monitoring and penalty controls worked. This is a weakness, but it was managed.
If the team CANNOT provide this evidence: You have likely found a significant control failure. The payment was late, and there is no evidence that it was corrected, managed, or penalized according to procedure.
By following this three-step process for every item on your list, you will be able to confidently sort all of your findings into "Handled Exceptions" and "Potential Control Failures."
