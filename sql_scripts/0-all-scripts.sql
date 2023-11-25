-- AUTO GEN SQL SCRIPT --

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
	BarcodeNumber INTEGER NOT NULL PRIMARY KEY,
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
	LibraryCardNumber INTEGER NOT NULL PRIMARY KEY,
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
	REFERENCES Member(LibraryCardNumber);

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
	REFERENCES Copy(BarcodeNumber);

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
	REFERENCES Copy(BarcodeNumber);

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
	REFERENCES Member(LibraryCardNumber);

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_unique UNIQUE (ReservedBook, ReservedAVMedia, ReservedBy, ReservedTimestamp);

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_xor
	CHECK((ReservedBook IS NULL OR ReservedBy IS NULL)
	AND NOT (ReservedBook IS NULL AND ReservedBy IS NULL));

ALTER TABLE Reservation
ADD CONSTRAINT Reservation_Resolution_in
	CHECK(Resolution IN ('P', 'A', 'R'));

CREATE TABLE MemberMaxLoans(
	MemberType CHAR(1) NOT NULL,
	MaxCopiesOnLoan INTEGER NOT NULL
);

ALTER TABLE MemberMaxLoans
ADD CONSTRAINT MemberMaxLoans_unique UNIQUE (MemberType);

ALTER TABLE MemberMaxLoans
ADD CONSTRAINT MemberMaxLoans_MemberType_in
	CHECK(MemberType IN ('S', 'T'));

-- INSERT MAX LOANS --

INSERT INTO MemberMaxLoans
(MemberType, MaxCopiesOnLoan)
VALUES ('S', 5);

INSERT INTO MemberMaxLoans
(MemberType, MaxCopiesOnLoan)
VALUES ('T', 10);

-- INSERT DATA --

-- 2: INSERT MEMBERS --

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (0, 'Ivan', 'Aziz', 'Ivan.Aziz0@qmul.ac.uk', To_Date('1998/7/27', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (1, 'Lucia', 'Faucher', 'Lucia.Faucher1@qmul.ac.uk', To_Date('2002/5/17', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (2, 'Charlotte', 'Diwali', 'Charlotte.Diwali2@qmul.ac.uk', To_Date('2000/8/24', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (3, 'Simon', 'Butler', 'Simon.Butler3@qmul.ac.uk', To_Date('2006/5/13', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (4, 'Adiza', 'Knight', 'Adiza.Knight4@qmul.ac.uk', To_Date('2002/4/2', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (5, 'Zora', 'Fyodorov', 'Zora.Fyodorov5@qmul.ac.uk', To_Date('1998/1/12', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (6, 'Jessica', 'White', 'Jessica.White6@qmul.ac.uk', To_Date('2006/2/3', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (7, 'Rufus', 'Montogomery', 'Rufus.Montogomery7@qmul.ac.uk', To_Date('1999/4/28', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (8, 'Hua', 'Wahed', 'Hua.Wahed8@qmul.ac.uk', To_Date('2005/8/9', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (9, 'Lorenzo', 'Suzuki', 'Lorenzo.Suzuki9@qmul.ac.uk', To_Date('2001/5/8', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (10, 'Pablo', 'Jacobsen', 'Pablo.Jacobsen10@qmul.ac.uk', To_Date('2000/2/5', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (11, 'Pablo', 'Stewart', 'Pablo.Stewart11@qmul.ac.uk', To_Date('2000/9/25', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (12, 'Katerina', 'Gomez', 'Katerina.Gomez12@qmul.ac.uk', To_Date('2000/2/6', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (13, 'Florence', 'Kaas', 'Florence.Kaas13@qmul.ac.uk', To_Date('1998/11/24', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (14, 'Manuel', 'Hemmingson', 'Manuel.Hemmingson14@qmul.ac.uk', To_Date('1998/12/19', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (15, 'Flynn', 'Kennedy', 'Flynn.Kennedy15@qmul.ac.uk', To_Date('1990/9/19', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (16, 'Vega', 'Diwali', 'Vega.Diwali16@qmul.ac.uk', To_Date('1993/9/16', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (17, 'Wei', 'Garcia', 'Wei.Garcia17@qmul.ac.uk', To_Date('1999/5/16', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (18, 'Rafael', 'Sing', 'Rafael.Sing18@qmul.ac.uk', To_Date('1996/9/21', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (19, 'Peter', 'Faucher', 'Peter.Faucher19@qmul.ac.uk', To_Date('1996/2/21', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (20, 'Mila', 'Li', 'Mila.Li20@qmul.ac.uk', To_Date('1997/6/30', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (21, 'Anya', 'Karlsen', 'Anya.Karlsen21@qmul.ac.uk', To_Date('1994/9/30', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (22, 'Zora', 'Sanchez', 'Zora.Sanchez22@qmul.ac.uk', To_Date('1998/11/15', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (23, 'Luna', 'Bassam', 'Luna.Bassam23@qmul.ac.uk', To_Date('1989/8/11', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (24, 'Julia', 'Wilde', 'Julia.Wilde24@qmul.ac.uk', To_Date('1996/12/9', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (25, 'Karina', 'Ramos', 'Karina.Ramos25@qmul.ac.uk', To_Date('1996/1/11', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (26, 'Heather', 'Rukober', 'Heather.Rukober26@qmul.ac.uk', To_Date('1990/9/20', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (27, 'Lana', 'Fedorov', 'Lana.Fedorov27@qmul.ac.uk', To_Date('1994/9/4', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (28, 'Luna', 'Myers', 'Luna.Myers28@qmul.ac.uk', To_Date('1990/9/20', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (29, 'Sonia', 'Zhang', 'Sonia.Zhang29@qmul.ac.uk', To_Date('1990/6/26', 'yyyy/mm/dd'), 'S');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (30, 'Flynn', 'Knight', 'Flynn.Knight30@qmul.ac.uk', To_Date('1990/2/21', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (31, 'Sofia', 'Sokolov', 'Sofia.Sokolov31@qmul.ac.uk', To_Date('1989/3/22', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (32, 'Hiroto', 'Lopez', 'Hiroto.Lopez32@qmul.ac.uk', To_Date('1977/8/14', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (33, 'Mia', 'Ruiz', 'Mia.Ruiz33@qmul.ac.uk', To_Date('1991/12/24', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (34, 'Maria', 'Kaas', 'Maria.Kaas34@qmul.ac.uk', To_Date('1983/3/17', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (35, 'William', 'Roberts', 'William.Roberts35@qmul.ac.uk', To_Date('1968/1/15', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (36, 'June', 'Diaz', 'June.Diaz36@qmul.ac.uk', To_Date('1970/11/10', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (37, 'Chun', 'Bruun', 'Chun.Bruun37@qmul.ac.uk', To_Date('1975/9/26', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (38, 'Zach', 'Garcia', 'Zach.Garcia38@qmul.ac.uk', To_Date('1994/7/14', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (39, 'Jane', 'Stewart', 'Jane.Stewart39@qmul.ac.uk', To_Date('1995/10/4', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (40, 'Alexei', 'Knight', 'Alexei.Knight40@qmul.ac.uk', To_Date('1987/1/10', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (41, 'Sara', 'Gomez', 'Sara.Gomez41@qmul.ac.uk', To_Date('1987/2/9', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (42, 'Harvey', 'Granger', 'Harvey.Granger42@qmul.ac.uk', To_Date('1990/4/5', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (43, 'Louis', 'Popov', 'Louis.Popov43@qmul.ac.uk', To_Date('1971/3/10', 'yyyy/mm/dd'), 'T');

INSERT INTO Member
(LibraryCardNumber, FirstName, LastName, Email, DOB, MemberType)
VALUES (44, 'Anya', 'Butler', 'Anya.Butler44@qmul.ac.uk', To_Date('1981/9/2', 'yyyy/mm/dd'), 'T');

-- 3: INSERT SUBJECTS --

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (0, 'Fiction');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (1, 'Non-fiction');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (2, 'Biology');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (3, 'Philosophy');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (4, 'Computer science');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (5, 'Medicine');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (6, 'Physics');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (7, 'Psychology');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (8, 'Engineering');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (9, 'History');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (10, 'Linguistics');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (11, 'Literature');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (12, 'Mathematics');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (13, 'Art');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (14, 'Anthropology');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (15, 'Economics');

INSERT INTO Subject
(ClassNo, SubjectName)
VALUES (16, 'Geography');

-- 4: INSERT AUTHORS --

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (0, 'Basil', 'Granger', To_Date('1944/1/12', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (1, 'Wei', 'Ramos', To_Date('1971/5/22', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (2, 'Leo', 'Wilde', To_Date('1973/3/30', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (3, 'Ding', 'Hemmingson', To_Date('1955/4/12', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (4, 'Zach', 'Bassam', To_Date('1942/1/10', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (5, 'Zayd', 'Zhang', To_Date('1981/11/10', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (6, 'Chun', 'Khalid', To_Date('1987/10/31', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (7, 'Wei', 'Jabal', To_Date('1981/4/8', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (8, 'Michael', 'Suzuki', To_Date('1984/8/9', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (9, 'Sandy', 'Hamdi', To_Date('1949/5/5', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (10, 'Emily', 'Davidson', To_Date('1978/8/24', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (11, 'Adiza', 'Reid', To_Date('1951/4/19', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (12, 'Hao', 'Martinez', To_Date('1983/6/19', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (13, 'Carmen', 'Bassam', To_Date('1964/6/5', 'yyyy/mm/dd'));

INSERT INTO Author
(AuthorNumber, FirstName, LastName, DOB)
VALUES (14, 'Boris', 'Ramos', To_Date('1955/10/7', 'yyyy/mm/dd'));

-- 5: INSERT RESOURCES, COPIES: ACADEMIC --

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (0, 'Explaining Procedural Programming with foreword from the author', 'First', To_Date('1994/8/13', 'yyyy/mm/dd'), 4, 'L', 243);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (0, 0, NULL, To_Timestamp('2012/1/2 14:47:32', 'YYYY/MM/DD HH24:MI:SS'), 3, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (1, 0, NULL, To_Timestamp('2012/1/2 14:47:32', 'YYYY/MM/DD HH24:MI:SS'), 3, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (2, 0, NULL, To_Timestamp('2019/3/6 12:3:44', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (3, 0, NULL, To_Timestamp('2021/1/3 11:37:13', 'YYYY/MM/DD HH24:MI:SS'), 3, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (4, 0, NULL, To_Timestamp('2015/5/9 10:14:34', 'YYYY/MM/DD HH24:MI:SS'), 3, 14, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 0, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (1, 'Advanced Archaeology', 'First', To_Date('2007/10/13', 'yyyy/mm/dd'), 14, 'L', 105);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (5, 1, NULL, To_Timestamp('2013/12/19 11:58:42', 'YYYY/MM/DD HH24:MI:SS'), 1, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (6, 1, NULL, To_Timestamp('2022/6/14 9:48:24', 'YYYY/MM/DD HH24:MI:SS'), 1, 5, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 1, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (2, 'Advanced Archaeology', 'Second', To_Date('2007/10/13', 'yyyy/mm/dd'), 14, 'L', 105);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (7, 2, NULL, To_Timestamp('2015/2/14 20:13:56', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (8, 2, NULL, To_Timestamp('2019/12/2 12:27:25', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (9, 2, NULL, To_Timestamp('2014/3/8 17:47:52', 'YYYY/MM/DD HH24:MI:SS'), 3, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 2, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (3, 'Evolution with foreword from the author', 'First', To_Date('2007/3/31', 'yyyy/mm/dd'), 2, 'L', 550);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (10, 3, NULL, To_Timestamp('2017/5/16 20:52:28', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (11, 3, NULL, To_Timestamp('2017/5/16 20:52:28', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (12, 3, NULL, To_Timestamp('2018/5/12 19:26:13', 'YYYY/MM/DD HH24:MI:SS'), 1, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (13, 3, NULL, To_Timestamp('2017/5/16 20:52:28', 'YYYY/MM/DD HH24:MI:SS'), 1, 2, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 3, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 3, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (4, 'Blacksmithing and Related Topics', 'First', To_Date('1992/2/18', 'yyyy/mm/dd'), 8, 'L', 414);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (14, 4, NULL, To_Timestamp('2015/11/11 19:7:43', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (15, 4, NULL, To_Timestamp('2020/9/9 17:8:49', 'YYYY/MM/DD HH24:MI:SS'), 1, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (16, 4, NULL, To_Timestamp('2020/9/9 17:8:49', 'YYYY/MM/DD HH24:MI:SS'), 1, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (17, 4, NULL, To_Timestamp('2020/9/9 17:8:49', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (1, 4, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 4, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (5, 'Banking', 'First', To_Date('2007/10/6', 'yyyy/mm/dd'), 9, 'L', 337);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (18, 5, NULL, To_Timestamp('2022/5/2 10:52:5', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (19, 5, NULL, To_Timestamp('2022/5/2 10:52:5', 'YYYY/MM/DD HH24:MI:SS'), 3, 11, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (20, 5, NULL, To_Timestamp('2020/5/13 17:0:30', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (21, 5, NULL, To_Timestamp('2022/5/2 10:52:5', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (22, 5, NULL, To_Timestamp('2023/4/9 14:13:26', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 5, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 5, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (6, 'Object-oriented Programming', 'First', To_Date('1984/4/23', 'yyyy/mm/dd'), 4, 'L', 339);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (23, 6, NULL, To_Timestamp('2015/1/10 13:53:11', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (24, 6, NULL, To_Timestamp('2013/1/3 16:50:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 6, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (7, 'Speleology', 'First', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (25, 7, NULL, To_Timestamp('2020/9/9 19:50:48', 'YYYY/MM/DD HH24:MI:SS'), 1, 1, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 7, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (8, 'Speleology', 'Second', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (26, 8, NULL, To_Timestamp('2022/9/27 17:57:19', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (27, 8, NULL, To_Timestamp('2020/2/6 19:4:27', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 8, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (9, 'Speleology', 'Third', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (28, 9, NULL, To_Timestamp('2016/7/16 10:45:27', 'YYYY/MM/DD HH24:MI:SS'), 3, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (29, 9, NULL, To_Timestamp('2014/1/22 20:12:40', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (30, 9, NULL, To_Timestamp('2023/2/9 15:3:59', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (31, 9, NULL, To_Timestamp('2012/5/15 16:58:30', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (32, 9, NULL, To_Timestamp('2012/5/15 16:58:30', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 9, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 7, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 8, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 9, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (10, 'Some Thoughts on Theatrical Works', 'First', To_Date('1988/3/27', 'yyyy/mm/dd'), 13, 'N', 482);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (33, 10, NULL, To_Timestamp('2019/7/9 14:44:57', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (34, 10, NULL, To_Timestamp('2019/7/9 14:44:57', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (4, 10, NULL);

-- 6: INSERT RESOURCES, COPIES: FICTION --

INSERT INTO AVMedia
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (0, 'The Marriage', 'Standard', To_Date('1999/3/1', 'yyyy/mm/dd'), 0, 'L', 125, 'C');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (35, NULL, 0, To_Timestamp('2020/8/11 20:55:26', 'YYYY/MM/DD HH24:MI:SS'), 2, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (36, NULL, 0, To_Timestamp('2019/8/15 10:40:31', 'YYYY/MM/DD HH24:MI:SS'), 2, 3, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (37, NULL, 0, To_Timestamp('2020/8/11 20:55:26', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (38, NULL, 0, To_Timestamp('2018/7/9 18:54:19', 'YYYY/MM/DD HH24:MI:SS'), 2, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (5, NULL, 0);

INSERT INTO AVMedia
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (1, 'The Little Space', 'Standard', To_Date('2009/1/26', 'yyyy/mm/dd'), 0, 'L', 226, 'D');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (39, NULL, 1, To_Timestamp('2019/9/8 18:5:25', 'YYYY/MM/DD HH24:MI:SS'), 2, 7, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (40, NULL, 1, To_Timestamp('2019/9/8 18:5:25', 'YYYY/MM/DD HH24:MI:SS'), 2, 7, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (41, NULL, 1, To_Timestamp('2019/9/8 18:5:25', 'YYYY/MM/DD HH24:MI:SS'), 2, 7, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (5, NULL, 1);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (11, 'Lover', 'Paperback', To_Date('1981/3/16', 'yyyy/mm/dd'), 0, 'L', 678);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (42, 11, NULL, To_Timestamp('2023/10/12 9:27:29', 'YYYY/MM/DD HH24:MI:SS'), 1, 2, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (43, 11, NULL, To_Timestamp('2019/2/28 15:37:27', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (6, 11, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (12, 'Lover', 'Hardback', To_Date('1981/3/16', 'yyyy/mm/dd'), 0, 'L', 678);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (44, 12, NULL, To_Timestamp('2021/3/3 11:44:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (45, 12, NULL, To_Timestamp('2021/3/3 11:44:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (46, 12, NULL, To_Timestamp('2023/11/24 14:21:16', 'YYYY/MM/DD HH24:MI:SS'), 2, 13, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (6, 12, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (13, 'Seeking Boys', 'Paperback', To_Date('1993/11/26', 'yyyy/mm/dd'), 0, 'L', 344);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (47, 13, NULL, To_Timestamp('2023/7/10 13:8:24', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (48, 13, NULL, To_Timestamp('2023/7/10 13:8:24', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (49, 13, NULL, To_Timestamp('2023/7/10 13:8:24', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (50, 13, NULL, To_Timestamp('2023/7/10 13:8:24', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (51, 13, NULL, To_Timestamp('2012/2/4 9:35:20', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (6, 13, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (14, 'Wandering Alleys', 'Paperback', To_Date('2012/12/5', 'yyyy/mm/dd'), 0, 'L', 533);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (52, 14, NULL, To_Timestamp('2022/8/7 15:18:22', 'YYYY/MM/DD HH24:MI:SS'), 1, 13, 'Y');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (7, 14, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (15, 'Oh Wedding', 'Paperback', To_Date('1993/11/3', 'yyyy/mm/dd'), 0, 'L', 517);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (53, 15, NULL, To_Timestamp('2013/10/15 14:15:32', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (54, 15, NULL, To_Timestamp('2013/3/17 13:50:23', 'YYYY/MM/DD HH24:MI:SS'), 2, 6, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (55, 15, NULL, To_Timestamp('2018/4/11 19:1:42', 'YYYY/MM/DD HH24:MI:SS'), 2, 6, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (56, 15, NULL, To_Timestamp('2015/7/6 19:34:44', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (57, 15, NULL, To_Timestamp('2013/2/6 14:46:48', 'YYYY/MM/DD HH24:MI:SS'), 2, 6, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (8, 15, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (16, 'The Spirit', 'Paperback', To_Date('1994/6/30', 'yyyy/mm/dd'), 0, 'L', 318);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (58, 16, NULL, To_Timestamp('2014/1/30 18:24:43', 'YYYY/MM/DD HH24:MI:SS'), 3, 7, 'Y');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (8, 16, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (17, 'The Mirthless Cliff', 'Paperback', To_Date('2021/10/19', 'yyyy/mm/dd'), 0, 'L', 174);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (59, 17, NULL, To_Timestamp('2017/12/14 19:17:33', 'YYYY/MM/DD HH24:MI:SS'), 1, 2, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (60, 17, NULL, To_Timestamp('2019/1/20 20:42:58', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (61, 17, NULL, To_Timestamp('2017/12/14 19:17:33', 'YYYY/MM/DD HH24:MI:SS'), 1, 2, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (62, 17, NULL, To_Timestamp('2017/12/14 19:17:33', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (63, 17, NULL, To_Timestamp('2023/8/15 20:1:30', 'YYYY/MM/DD HH24:MI:SS'), 1, 2, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (9, 17, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (18, 'Finally Mysterious', 'Paperback', To_Date('2009/2/17', 'yyyy/mm/dd'), 0, 'L', 107);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (64, 18, NULL, To_Timestamp('2018/6/7 9:25:19', 'YYYY/MM/DD HH24:MI:SS'), 2, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (65, 18, NULL, To_Timestamp('2018/6/7 9:25:19', 'YYYY/MM/DD HH24:MI:SS'), 2, 13, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (9, 18, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (19, 'Over the Tactic', 'Paperback', To_Date('2004/9/24', 'yyyy/mm/dd'), 0, 'S', 630);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (66, 19, NULL, To_Timestamp('2021/1/28 19:55:28', 'YYYY/MM/DD HH24:MI:SS'), 2, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (67, 19, NULL, To_Timestamp('2021/1/28 19:55:28', 'YYYY/MM/DD HH24:MI:SS'), 2, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (68, 19, NULL, To_Timestamp('2023/10/27 13:44:47', 'YYYY/MM/DD HH24:MI:SS'), 2, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (69, 19, NULL, To_Timestamp('2021/1/28 19:55:28', 'YYYY/MM/DD HH24:MI:SS'), 2, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (70, 19, NULL, To_Timestamp('2017/5/6 9:46:34', 'YYYY/MM/DD HH24:MI:SS'), 2, 10, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (9, 19, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (20, 'Vessel', 'Paperback', To_Date('1992/4/30', 'yyyy/mm/dd'), 0, 'L', 388);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (71, 20, NULL, To_Timestamp('2019/8/28 13:16:12', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (72, 20, NULL, To_Timestamp('2021/3/21 9:37:15', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (73, 20, NULL, To_Timestamp('2022/4/10 13:1:22', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (74, 20, NULL, To_Timestamp('2022/6/9 20:12:44', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (75, 20, NULL, To_Timestamp('2015/6/29 13:41:9', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (9, 20, NULL);

-- 7: INSERT RESOURCES, COPIES: NON-FICTION --

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (21, 'The Vietnam War and pancakes', 'Paperback', To_Date('2006/5/21', 'yyyy/mm/dd'), 1, 'L', 638);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (76, 21, NULL, To_Timestamp('2023/8/28 11:47:8', 'YYYY/MM/DD HH24:MI:SS'), 2, 6, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (77, 21, NULL, To_Timestamp('2017/1/28 16:22:56', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (78, 21, NULL, To_Timestamp('2023/8/28 11:47:8', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (79, 21, NULL, To_Timestamp('2023/8/28 11:47:8', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (10, 21, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (22, 'The Vietnam War and pancakes', 'Hardback', To_Date('2006/5/21', 'yyyy/mm/dd'), 1, 'L', 638);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (80, 22, NULL, To_Timestamp('2014/12/23 15:9:18', 'YYYY/MM/DD HH24:MI:SS'), 2, 11, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (81, 22, NULL, To_Timestamp('2021/6/22 15:25:43', 'YYYY/MM/DD HH24:MI:SS'), 2, 11, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (82, 22, NULL, To_Timestamp('2015/10/27 17:17:35', 'YYYY/MM/DD HH24:MI:SS'), 2, 11, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (83, 22, NULL, To_Timestamp('2023/4/19 16:30:9', 'YYYY/MM/DD HH24:MI:SS'), 2, 11, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (84, 22, NULL, To_Timestamp('2016/12/11 19:18:53', 'YYYY/MM/DD HH24:MI:SS'), 2, 11, 'Y');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (10, 22, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (23, 'Everything you wanted to know about earthquakes', 'Paperback', To_Date('1998/3/16', 'yyyy/mm/dd'), 1, 'S', 626);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (85, 23, NULL, To_Timestamp('2012/4/28 17:59:23', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (86, 23, NULL, To_Timestamp('2023/4/17 17:18:20', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (87, 23, NULL, To_Timestamp('2022/7/17 12:10:40', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (88, 23, NULL, To_Timestamp('2019/9/22 11:55:45', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (10, 23, NULL);

INSERT INTO AVMedia
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (2, 'SEO and boxing', 'Standard', To_Date('2000/2/25', 'yyyy/mm/dd'), 1, 'L', 229, 'C');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (89, NULL, 2, To_Timestamp('2022/4/8 13:52:55', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (90, NULL, 2, To_Timestamp('2022/4/8 13:52:55', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (91, NULL, 2, To_Timestamp('2013/1/4 13:9:42', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (10, NULL, 2);

INSERT INTO AVMedia
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (4, 'Connor Stewart: a Biography', 'Standard', To_Date('1992/12/20', 'yyyy/mm/dd'), 1, 'L', 197, 'V');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (92, NULL, 4, To_Timestamp('2016/10/21 19:53:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (93, NULL, 4, To_Timestamp('2016/10/21 19:53:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (11, NULL, 4);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (24, 'Diving deeper into the Bible', 'Paperback', To_Date('1987/5/26', 'yyyy/mm/dd'), 1, 'S', 275);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (94, 24, NULL, To_Timestamp('2021/2/25 19:40:14', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (95, 24, NULL, To_Timestamp('2013/5/31 16:9:26', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (96, 24, NULL, To_Timestamp('2019/2/27 19:36:7', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (12, 24, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (25, 'What we learned from the Internet', 'Paperback', To_Date('2020/9/7', 'yyyy/mm/dd'), 1, 'L', 493);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (97, 25, NULL, To_Timestamp('2017/11/17 20:30:14', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (98, 25, NULL, To_Timestamp('2021/3/29 17:26:15', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (13, 25, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (26, 'Sharon Khalid: the Untold tales', 'Paperback', To_Date('1980/4/23', 'yyyy/mm/dd'), 1, 'L', 243);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (99, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (100, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (101, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (13, 26, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (27, 'Sharon Khalid: the Untold tales', 'Hardback', To_Date('1980/4/23', 'yyyy/mm/dd'), 1, 'L', 243);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (102, 27, NULL, To_Timestamp('2021/9/6 19:35:22', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (103, 27, NULL, To_Timestamp('2015/12/6 9:53:3', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (13, 27, NULL);

INSERT INTO AVMedia
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (5, 'Finding out about the BBC', 'Standard', To_Date('2007/8/2', 'yyyy/mm/dd'), 1, 'L', 143, 'D');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (104, NULL, 5, To_Timestamp('2014/9/12 20:48:34', 'YYYY/MM/DD HH24:MI:SS'), 2, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (105, NULL, 5, To_Timestamp('2018/6/25 12:45:43', 'YYYY/MM/DD HH24:MI:SS'), 2, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (106, NULL, 5, To_Timestamp('2014/4/7 18:55:9', 'YYYY/MM/DD HH24:MI:SS'), 2, 9, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (107, NULL, 5, To_Timestamp('2014/10/27 9:15:57', 'YYYY/MM/DD HH24:MI:SS'), 2, 9, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (13, NULL, 5);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (28, 'Fencing - a guide', 'Paperback', To_Date('2019/10/2', 'yyyy/mm/dd'), 1, 'S', 425);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (108, 28, NULL, To_Timestamp('2019/12/17 14:58:43', 'YYYY/MM/DD HH24:MI:SS'), 3, 15, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (109, 28, NULL, To_Timestamp('2013/8/26 13:26:55', 'YYYY/MM/DD HH24:MI:SS'), 3, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (110, 28, NULL, To_Timestamp('2021/9/5 16:9:20', 'YYYY/MM/DD HH24:MI:SS'), 3, 15, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (111, 28, NULL, To_Timestamp('2022/7/28 16:52:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 15, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (112, 28, NULL, To_Timestamp('2018/12/23 12:15:23', 'YYYY/MM/DD HH24:MI:SS'), 3, 15, 'Y');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (14, 28, NULL);

