-- `item` 데이터 삽입 (변경 없음)
INSERT INTO `item` (`id`, `forthCategoryId`, `name`, `price`, `sellerId`, `createdAt`, `modifiedAt`) VALUES
                                                                                                         (1, 200, '후지 사과', '3000', '2', '2023-11-01 10:15:00', '2023-11-01 10:15:00'),
                                                                                                         (2, 200, '아오리 사과', '3200', '2', '2023-11-02 11:30:00', '2023-11-02 11:30:00'),
                                                                                                         (3, 200, '홍옥 사과', '2800', '2', '2023-11-03 12:45:00', '2023-11-03 12:45:00'),
                                                                                                         (4, 200, '썬후지 사과', '3500', '2', '2023-11-04 13:20:00', '2023-11-04 13:20:00'),
                                                                                                         (5, 200, '감홍 사과', '3000', '2', '2023-11-05 14:05:00', '2023-11-05 14:05:00'),
                                                                                                         (6, 200, '피나골드 사과', '3100', '2', '2023-11-06 15:00:00', '2023-11-06 15:00:00');
-- `forthcategory` 데이터 삽입 (thirdCategoryId 수정)
INSERT INTO `forthcategory` (`id`, `thirdCategoryId`, `name`) VALUES
                                                                  (200, 50, '사과류'),
                                                                  (201, 50, '배류'),
                                                                  (202, 50, '귤류'),
                                                                  (203, 50, '포도류'),
                                                                  (204, 50, '복숭아류');
-- `thirdcategory` 데이터 삽입 (변경 없음)
INSERT INTO `thirdcategory` (`id`, `subCategoryId`, `name`) VALUES
                                                                (50, 10, '과일류'),
                                                                (51, 10, '채소류'),
                                                                (52, 10, '곡류'),
                                                                (53, 10, '육류'),
                                                                (54, 10, '해산물류');
-- `subcategory` 데이터 삽입 (변경 없음)
INSERT INTO `subcategory` (`id`, `name`) VALUES
                                             (10, '식품'),
                                             (11, '가전제품'),
                                             (12, '의류'),
                                             (13, '가구'),
                                             (14, '생활용품');
UPDATE item
SET price = 3200
WHERE id = 1;
SELECT * FROM `item`
WHERE `forthCategoryId` = 200
  AND `price` > '3000'
  AND `sellerId` = '2';
UPDATE item
SET price = 3200