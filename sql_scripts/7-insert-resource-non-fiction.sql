-- 7: INSERT RESOURCES, COPIES: NON-FICTION --

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (21, 'The Vietnam War and pancakes', To_Date('2006/5/21', 'yyyy/mm/dd'), 1, 'L', 'Paperback', 638);

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

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (10, 21, NULL, 'A');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (22, 'The Vietnam War and pancakes', To_Date('2006/5/21', 'yyyy/mm/dd'), 1, 'L', 'Hardback', 638);

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

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (10, 22, NULL, 'A');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (23, 'Everything you wanted to know about earthquakes', To_Date('1998/3/16', 'yyyy/mm/dd'), 1, 'S', 'Paperback', 626);

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

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (10, 23, NULL, 'A');

INSERT INTO AVMedia
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (2, 'SEO and boxing', To_Date('2000/2/25', 'yyyy/mm/dd'), 1, 'L', 229, 'C');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (89, NULL, 2, To_Timestamp('2022/4/8 13:52:55', 'YYYY/MM/DD HH24:MI:SS'), 1, 15, 'Y');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (90, NULL, 2, To_Timestamp('2022/4/8 13:52:55', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (91, NULL, 2, To_Timestamp('2013/1/4 13:9:42', 'YYYY/MM/DD HH24:MI:SS'), 1, 14, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (10, NULL, 2, 'D');

INSERT INTO AVMedia
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (4, 'Connor Stewart: a Biography', To_Date('1992/12/20', 'yyyy/mm/dd'), 1, 'L', 197, 'V');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (92, NULL, 4, To_Timestamp('2016/10/21 19:53:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (93, NULL, 4, To_Timestamp('2016/10/21 19:53:39', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (11, NULL, 4, 'D');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (24, 'Diving deeper into the Bible', To_Date('1987/5/26', 'yyyy/mm/dd'), 1, 'S', 'Paperback', 275);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (94, 24, NULL, To_Timestamp('2021/2/25 19:40:14', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (95, 24, NULL, To_Timestamp('2013/5/31 16:9:26', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (96, 24, NULL, To_Timestamp('2019/2/27 19:36:7', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (12, 24, NULL, 'A');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (25, 'What we learned from the Internet', To_Date('2020/9/7', 'yyyy/mm/dd'), 1, 'L', 'Paperback', 493);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (97, 25, NULL, To_Timestamp('2017/11/17 20:30:14', 'YYYY/MM/DD HH24:MI:SS'), 2, 5, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (98, 25, NULL, To_Timestamp('2021/3/29 17:26:15', 'YYYY/MM/DD HH24:MI:SS'), 2, 4, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (13, 25, NULL, 'A');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (26, 'Sharon Khalid: the Untold tales', To_Date('1980/4/23', 'yyyy/mm/dd'), 1, 'L', 'Paperback', 243);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (99, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (100, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (101, 26, NULL, To_Timestamp('2021/10/2 11:39:16', 'YYYY/MM/DD HH24:MI:SS'), 1, 10, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (13, 26, NULL, 'A');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (27, 'Sharon Khalid: the Untold tales', To_Date('1980/4/23', 'yyyy/mm/dd'), 1, 'L', 'Hardback', 243);

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (102, 27, NULL, To_Timestamp('2021/9/6 19:35:22', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO Copy
(BarcodeNumber, BookNumber, AVNumber, AcquiredTimestamp, FloorNo, ShelfNo, Archived)
VALUES (103, 27, NULL, To_Timestamp('2015/12/6 9:53:3', 'YYYY/MM/DD HH24:MI:SS'), 1, 3, 'N');

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (13, 27, NULL, 'A');

INSERT INTO AVMedia
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, MediaLength, MediaType)
VALUES (5, 'Finding out about the BBC', To_Date('2007/8/2', 'yyyy/mm/dd'), 1, 'L', 143, 'D');

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

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (13, NULL, 5, 'D');

INSERT INTO Book
(ResourceNumber, Title, DatePublished, ClassNo, LoanType, Edition, PageLength)
VALUES (28, 'Fencing - a guide', To_Date('2019/10/2', 'yyyy/mm/dd'), 1, 'S', 'Paperback', 425);

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

INSERT INTO CreatorResource
(CreatorNumber, BookNumber, AVNumber, CreatorType)
VALUES (14, 28, NULL, 'A');

