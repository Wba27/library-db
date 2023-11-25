-- 5: INSERT RESOURCES, COPIES: ACADEMIC --

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (0, 'Explaining Procedural Programming with foreword from the author', 'First', To_Date('1994/8/13', 'yyyy/mm/dd'), 4, 'L', 243);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (0, 0, NULL, To_Timestamp('2017/12/17 18:12:13', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (1, 0, NULL, To_Timestamp('2019/3/6 12:3:44', 'YYYY/MM/DD HH24:MI:SS'), 1, 13, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 0, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (4, 0, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (1, 'Advanced Archaeology', 'First', To_Date('2007/10/13', 'yyyy/mm/dd'), 14, 'L', 105);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (2, 1, NULL, To_Timestamp('2016/2/8 17:57:19', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (3, 1, NULL, To_Timestamp('2013/12/19 11:58:42', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (4, 1, NULL, To_Timestamp('2013/3/19 12:16:13', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 1, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (2, 'Advanced Archaeology', 'Second', To_Date('2007/10/13', 'yyyy/mm/dd'), 14, 'L', 105);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (5, 2, NULL, To_Timestamp('2018/11/12 15:0:48', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (6, 2, NULL, To_Timestamp('2018/11/12 15:0:48', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (7, 2, NULL, To_Timestamp('2018/11/12 15:0:48', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (8, 2, NULL, To_Timestamp('2018/11/12 15:0:48', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 2, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (3, 'Evolution with foreword from the author', 'First', To_Date('2007/3/31', 'yyyy/mm/dd'), 2, 'S', 161);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (9, 3, NULL, To_Timestamp('2018/10/15 14:1:27', 'YYYY/MM/DD HH24:MI:SS'), 3, 2, 'Y');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 3, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (4, 'Experts on Homeopathy for the Modern Scholar', 'First', To_Date('1985/1/6', 'yyyy/mm/dd'), 5, 'L', 649);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (10, 4, NULL, To_Timestamp('2023/5/9 13:38:14', 'YYYY/MM/DD HH24:MI:SS'), 1, 12, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (1, 4, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (5, 'Experts on Homeopathy for the Modern Scholar', 'Second', To_Date('1985/1/6', 'yyyy/mm/dd'), 5, 'L', 649);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (11, 5, NULL, To_Timestamp('2013/5/17 10:15:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (12, 5, NULL, To_Timestamp('2015/11/11 19:7:43', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (13, 5, NULL, To_Timestamp('2013/5/17 10:15:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (14, 5, NULL, To_Timestamp('2013/5/17 10:15:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 12, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (15, 5, NULL, To_Timestamp('2013/5/17 10:15:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 13, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (1, 5, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 4, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (0, 5, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (6, 'Interpreting Procedural Programming', 'First', To_Date('2022/7/7', 'yyyy/mm/dd'), 4, 'S', 690);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (16, 6, NULL, To_Timestamp('2022/5/5 10:27:37', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (17, 6, NULL, To_Timestamp('2022/5/5 10:27:37', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (1, 6, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (7, 'Semantics', 'First', To_Date('2016/12/27', 'yyyy/mm/dd'), 10, 'L', 208);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (18, 7, NULL, To_Timestamp('2023/4/9 14:13:26', 'YYYY/MM/DD HH24:MI:SS'), 2, 15, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 7, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 7, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (8, 'Theatrical Works for the Modern Scholar', 'First', To_Date('1999/11/8', 'yyyy/mm/dd'), 13, 'L', 622);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (19, 8, NULL, To_Timestamp('2015/1/10 13:53:11', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (20, 8, NULL, To_Timestamp('2013/1/3 16:50:35', 'YYYY/MM/DD HH24:MI:SS'), 3, 1, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 8, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (9, 'Speleology', 'First', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (21, 9, NULL, To_Timestamp('2020/9/9 19:50:48', 'YYYY/MM/DD HH24:MI:SS'), 1, 1, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 9, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (10, 'Speleology', 'Second', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (22, 10, NULL, To_Timestamp('2022/9/27 17:57:19', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (23, 10, NULL, To_Timestamp('2020/2/6 19:4:27', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 10, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (11, 'Speleology', 'Third', To_Date('1999/2/18', 'yyyy/mm/dd'), 16, 'L', 344);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (24, 11, NULL, To_Timestamp('2016/7/16 10:45:27', 'YYYY/MM/DD HH24:MI:SS'), 3, 3, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (25, 11, NULL, To_Timestamp('2014/1/22 20:12:40', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (26, 11, NULL, To_Timestamp('2023/2/9 15:3:59', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (27, 11, NULL, To_Timestamp('2012/5/15 16:58:30', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'N');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (28, 11, NULL, To_Timestamp('2012/5/15 16:58:30', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (3, 11, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 9, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 10, NULL);

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (2, 11, NULL);

INSERT INTO Book
(ResourceNumber, Title, Edition, DatePublished, ClassNo, LoanType, PageLength)
VALUES (12, 'Some Thoughts on Theatrical Works', 'First', To_Date('1988/3/27', 'yyyy/mm/dd'), 13, 'N', 482);

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (29, 12, NULL, To_Timestamp('2019/7/9 14:44:57', 'YYYY/MM/DD HH24:MI:SS'), 3, 5, 'Y');

INSERT INTO Copy
(Barcode, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (30, 12, NULL, To_Timestamp('2019/7/9 14:44:57', 'YYYY/MM/DD HH24:MI:SS'), 3, 4, 'N');

INSERT INTO AuthorResource
(AuthorNumber, BookNumber, AVNumber)
VALUES (4, 12, NULL);

