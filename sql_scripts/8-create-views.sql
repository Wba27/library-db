CREATE VIEW LoanOverdueDate AS 
SELECT * FROM Loan WHERE ReturnedTimeStamp != NULL AND CURRENT_TIMESTAMP - LoanedTimestamp > 14;

----

CREATE VIEW ShowFines AS 
SELECT * FROM Fine WHERE PaidTimeStamp = NULL;

------------

CREATE VIEW OfferDueDate AS 
SELECT * FROM Offer WHERE CURRENT_TIMESTAMP - OfferTimestamp > 10;
