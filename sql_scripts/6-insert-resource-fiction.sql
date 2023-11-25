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

