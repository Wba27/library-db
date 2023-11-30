-- Create View LoanDueDate AS

SELECT * FROM Loan, Copy, Book, AVMedia WHERE Loan.LoanNumber = 0 AND Loan.LoanedCopy = Copy.BarcodeNumber AND (Copy.BookNumber = Book.ResourceNumber OR Copy.AVNumber = AVMedia.ResourceNumber);

-- Pay a Fine 
UPDATE Fine 
SET FineAmount = 0,
    PaidTimestamp = CURRENT_TIMESTAMP
WHERE FineTo = :LibraryCardNumber
AND FinedResource = :ResourceNumber
AND FineAmount > 0;

UPDATE Fine 
SET PaidTimestamp = CURRENT_TIMESTAMP
WHERE FineTo = :LibraryCardNumber
AND FinedResource = :ResourceNumber
AND PaidTimestamp IS NULL;


-- ShowPaidFines
SELECT Member.LibraryCardNumber, Fine.FinedLoan, Fine.FinedTimeStamp, Fine.PaidTimestamp, Member.FirstName, Member.LastName
FROM Fine
JOIN Member ON Fine.FineTo = Member.LibraryCardNumber
JOIN Resource ON Fine.FinedCopy = Resource.ResourceNumber (what's the com to get the name)
WHERE PaidTimestamp IS NOT NULL
AND Member.LibraryCardNumber = :LibraryCardNumber;


-- MemberOverdueResources

SELECT Member.LibraryCardNumber, Member.FirstName, Member.LastName, Book.ResourceNumber, Book.Title, Loan.LoanedTimestamp, Loan.ReturnedTimestamp
FROM Loan 
JOIN Member ON Loan.LoanedTo = Member.LibraryCardNumber
JOIN Copy ON Loan.LoanedCopy = Copy.BookNumber
JOIN Book ON Copy.BookNumber = Book.ResourceNumber
WHERE CAST( CURRENT_TIMESTAMP AS DATE) - CAST (Loan.LoanedTimestamp AS DATE) > 14
AND Loan.ReturnedTimestamp IS NULL
UNION ALL
SELECT Member.LibraryCardNumber, Member.FirstName, Member.LastName, AVMedia.ResourceNumber, AVMedia.Title, Loan.LoanedTimestamp, Loan.ReturnedTimestamp
FROM Loan 
JOIN Member ON Loan.LoanedTo = Member.LibraryCardNumber
JOIN Copy ON Loan.LoanedCopy = Copy.AVNumber
JOIN AVMedia ON Copy.AVNumber = AVMedia.ResourceNumber
WHERE CAST( CURRENT_TIMESTAMP AS DATE) - CAST (Loan.LoanedTimestamp AS DATE) > 14
AND Loan.ReturnedTimestamp IS NULL;


--OfferExpiresToday

SELECT Offer.ForReservation, Offer.OfferedTimestamp, (Offer.OfferedTimestamp + INTERVAL '2' DAY) AS OfferExpiresDate, Book.Title
FROM Offer
JOIN Copy ON Offer.OfferedCopy = Copy.BookNumber
JOIN Book ON Copy.BookNumber = Book.ResourceNumber
WHERE (Offer.OfferedTimestamp + INTERVAL '2' DAY) = CURRENT_DATE
AND NOT EXISTS (
    SELECT Loan.LoanedCopy
    FROM Loan
    WHERE Loan.LoanedCopy = Offer.OfferedCopy
    AND lOan.loanedTimestamp IS NOT NULL
)
UNION ALL

SELECT Offer.ForReservation, Offer.OfferedTimestamp, (Offer.OfferedTimestamp + INTERVAL '2' DAY) AS OfferExpiresDate, AVMedia.Title
FROM Offer
JOIN Copy ON Offer.OfferedCopy = Copy.AVNumber
JOIN AVMedia ON Copy.AVNumber = AVMedia.ResourceNumber
WHERE (Offer.OfferedTimestamp + INTERVAL '2' DAY) = CURRENT_DATE
AND NOT EXISTS (
    SELECT Loan.LoanedCopy
    FROM Loan
    WHERE Loan.LoanedCopy = Offer.OfferedCopy
    AND lOan.loanedTimestamp IS NOT NULL
);
