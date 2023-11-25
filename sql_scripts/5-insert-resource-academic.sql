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

