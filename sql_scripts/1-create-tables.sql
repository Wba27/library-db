-- 1: CREATE TABLES --

CREATE TABLE Subject(
	ClassNo INTEGER NOT NULL PRIMARY KEY,
	SubjectName VARCHAR(255) NOT NULL
);

ALTER TABLE Subject
ADD CONSTRAINT Subject_unique UNIQUE (SubjectName);

CREATE TABLE Book(
	ResourceNumber INTEGER NOT NULL PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Edition VARCHAR(255) NOT NULL,
	DatePublished DATE NOT NULL,
	ClassNo INTEGER NOT NULL,
	LoanType CHAR(1) NOT NULL,
	PageLength INTEGER NOT NULL
);

ALTER TABLE Book
ADD CONSTRAINT fk_Book_ClassNo
	FOREIGN KEY (ClassNo)
	REFERENCES Subject(ClassNo);

ALTER TABLE Book
ADD CONSTRAINT Book_unique UNIQUE (Title, Edition, DatePublished);

ALTER TABLE Book
ADD CONSTRAINT Book_LoanType_in
	CHECK(LoanType IN ('L', 'S', 'N'));

CREATE TABLE AVMedia(
	ResourceNumber INTEGER NOT NULL PRIMARY KEY,
	Title VARCHAR(255) NOT NULL,
	Edition VARCHAR(255) NOT NULL,
	DatePublished DATE NOT NULL,
	ClassNo INTEGER NOT NULL,
	LoanType CHAR(1) NOT NULL,
	MediaLength INTEGER NOT NULL,
	MediaType CHAR(1) NOT NULL
);

ALTER TABLE AVMedia
ADD CONSTRAINT fk_AVMedia_ClassNo
	FOREIGN KEY (ClassNo)
	REFERENCES Subject(ClassNo);

ALTER TABLE AVMedia
ADD CONSTRAINT AVMedia_unique UNIQUE (Title, Edition, DatePublished);

ALTER TABLE AVMedia
ADD CONSTRAINT AVMedia_LoanType_in
	CHECK(LoanType IN ('L', 'S', 'N'));

ALTER TABLE AVMedia
ADD CONSTRAINT AVMedia_MediaType_in
	CHECK(MediaType IN ('D', 'C', 'V'));

CREATE TABLE Copy(
	Barcode INTEGER NOT NULL PRIMARY KEY,
	BookNumber INTEGER NULL,
	AVNumber INTEGER NULL,
	AcquiredTimestamp TIMESTAMP NOT NULL,
	FloorNo INTEGER NOT NULL,
	ShelfNo INTEGER NOT NULL,
	Archived CHAR(1) DEFAULT 'N'
);

ALTER TABLE Copy
ADD CONSTRAINT fk_Copy_BookNumber
	FOREIGN KEY (BookNumber)
	REFERENCES Book(ResourceNumber);

ALTER TABLE Copy
ADD CONSTRAINT fk_Copy_AVNumber
	FOREIGN KEY (AVNumber)
	REFERENCES AVMedia(ResourceNumber);

ALTER TABLE Copy
ADD CONSTRAINT Copy_xor
	CHECK((BookNumber IS NULL OR AVNumber IS NULL)
	AND NOT (BookNumber IS NULL AND AVNumber IS NULL));

ALTER TABLE Copy
ADD CONSTRAINT Copy_Archived_bool
	CHECK(Archived IN ('Y', 'N'));

CREATE TABLE Author(
	AuthorNumber INTEGER NOT NULL PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	DOB DATE NOT NULL
);

CREATE TABLE AuthorResource(
	AuthorNumber INTEGER NOT NULL,
	BookNumber INTEGER NULL,
	AVNumber INTEGER NULL
);

ALTER TABLE AuthorResource
ADD CONSTRAINT fk_AuthorResource_AuthorNumber
	FOREIGN KEY (AuthorNumber)
	REFERENCES Author(AuthorNumber);

ALTER TABLE AuthorResource
ADD CONSTRAINT fk_AuthorResource_BookNumber
	FOREIGN KEY (BookNumber)
	REFERENCES Book(ResourceNumber);

ALTER TABLE AuthorResource
ADD CONSTRAINT fk_AuthorResource_AVNumber
	FOREIGN KEY (AVNumber)
	REFERENCES AVMedia(ResourceNumber);

ALTER TABLE AuthorResource
ADD CONSTRAINT AuthorResource_unique UNIQUE (AuthorNumber, BookNumber, AVNumber);

ALTER TABLE AuthorResource
ADD CONSTRAINT AuthorResource_xor
	CHECK((BookNumber IS NULL OR AVNumber IS NULL)
	AND NOT (BookNumber IS NULL AND AVNumber IS NULL));

CREATE TABLE Member(
	LibraryCard INTEGER NOT NULL PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	DOB DATE NOT NULL,
	MemberType CHAR(1) NOT NULL,
	Suspended CHAR(1) DEFAULT 'N'
);

ALTER TABLE Member
ADD CONSTRAINT Member_unique UNIQUE (Email);

ALTER TABLE Member
ADD CONSTRAINT Member_MemberType_in
	CHECK(MemberType IN ('S', 'T'));

ALTER TABLE Member
ADD CONSTRAINT Member_Suspended_bool
	CHECK(Suspended IN ('Y', 'N'));

CREATE TABLE Loan(
	LoanedCopy INTEGER NOT NULL,
	LoanedTo INTEGER NOT NULL,
	LoanedTimestamp TIMESTAMP NOT NULL,
	ReturnedTimestamp TIMESTAMP NULL
);

ALTER TABLE Loan
ADD CONSTRAINT fk_Loan_LoanedCopy
	FOREIGN KEY (LoanedCopy)
	REFERENCES Copy(Barcode);

ALTER TABLE Loan
ADD CONSTRAINT fk_Loan_LoanedTo
	FOREIGN KEY (LoanedTo)
	REFERENCES Member(LibraryCard);

ALTER TABLE Loan
ADD CONSTRAINT Loan_unique UNIQUE (LoanedCopy, LoanedTo, LoanedTimestamp);

CREATE TABLE Offer(
	ReservationNo INTEGER NOT NULL PRIMARY KEY,
	OfferedCopy INTEGER NOT NULL,
	OfferedTimestamp TIMESTAMP NOT NULL,
	Status CHAR(1) NOT NULL
);

ALTER TABLE Offer
ADD CONSTRAINT fk_Offer_OfferedCopy
	FOREIGN KEY (OfferedCopy)
	REFERENCES Copy(Barcode);

ALTER TABLE Offer
ADD CONSTRAINT Offer_Status_in
	CHECK(Status IN ('P', 'A', 'R'));

CREATE TABLE Fine(
	FinedCopy INTEGER NOT NULL,
	FineTo INTEGER NOT NULL,
	FinedTimestamp TIMESTAMP NOT NULL,
	PaidTimestamp TIMESTAMP NULL,
	FineAmount DECIMAL NOT NULL
);

ALTER TABLE Fine
ADD CONSTRAINT fk_Fine_FinedCopy
	FOREIGN KEY (FinedCopy)
	REFERENCES Copy(Barcode);

ALTER TABLE Fine
ADD CONSTRAINT fk_Fine_FineTo
	FOREIGN KEY (FineTo)
	REFERENCES Member(LibraryCard);

ALTER TABLE Fine
ADD CONSTRAINT Fine_unique UNIQUE (FinedCopy, FineTo, FinedTimestamp);

CREATE TABLE Reservation(
	ReservationNo INTEGER NOT NULL PRIMARY KEY,
	ReservedBook INTEGER NULL,
	ReservedAVMedia INTEGER NULL,
	ReservedBy INTEGER NOT NULL,
	ReservedTimestamp TIMESTAMP NOT NULL,
	ResolvedTimestamp TIMESTAMP NULL,
	Resolution CHAR(1) NULL
);

ALTER TABLE Reservation
ADD CONSTRAINT fk_Reservation_ReservedBook
	FOREIGN KEY (ReservedBook)
	REFERENCES Book(ResourceNumber);

ALTER TABLE Reservation
ADD CONSTRAINT fk_Reservation_ReservedAVMedia
	FOREIGN KEY (ReservedAVMedia)
	REFERENCES AVMedia(ResourceNumber);

ALTER TABLE Reservation
ADD CONSTRAINT fk_Reservation_ReservedBy
	FOREIGN KEY (ReservedBy)
	REFERENCES Member(LibraryCard);

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_unique UNIQUE (ReservedBook, ReservedAVMedia, ReservedBy, ReservedTimestamp);

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_Resolution_in
	CHECK(Resolution IN ('P', 'A', 'R'));

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_xor
	CHECK((ReservedBook IS NULL OR ReservedBy IS NULL)
	AND NOT (ReservedBook IS NULL AND ReservedBy IS NULL));

CREATE TABLE MemberMaxLoans(
	MemberType CHAR(1) NOT NULL,
	MaxCopiesOnLoan INTEGER NOT NULL
);

ALTER TABLE MemberMaxLoans
ADD CONSTRAINT MemberMaxLoans_unique UNIQUE (MemberType);

ALTER TABLE MemberMaxLoans
ADD CONSTRAINT MemberMaxLoans_MemberType_in
	CHECK(MemberType IN ('S', 'T'));
