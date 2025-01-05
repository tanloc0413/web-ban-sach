SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint NOT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `street_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK6i66ijb8twgcqtetl8eeeed6v`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FK6i66ijb8twgcqtetl8eeeed6v` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------

-- ----------------------------
-- Table structure for address_seq
-- ----------------------------
DROP TABLE IF EXISTS `address_seq`;
CREATE TABLE `address_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address_seq
-- ----------------------------
INSERT INTO `address_seq` VALUES (1);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` bigint NOT NULL,
  `level` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_category_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK9il7y6fehxwunjeepq0n7g5rd`(`parent_category_id` ASC) USING BTREE,
  CONSTRAINT `FK9il7y6fehxwunjeepq0n7g5rd` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, 1, 'Văn học', 1);
INSERT INTO `categories` VALUES (2, 1, 'Tiểu thuyết', 1);
INSERT INTO `categories` VALUES (3, 1, 'Tâm lý - Kỹ năng sống', 1);
INSERT INTO `categories` VALUES (4, 1, 'Kinh tế', 1);

-- ----------------------------
-- Table structure for categories_seq
-- ----------------------------
DROP TABLE IF EXISTS `categories_seq`;
CREATE TABLE `categories_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories_seq
-- ----------------------------
INSERT INTO `categories_seq` VALUES (1);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` bigint NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_at` datetime(6) NULL DEFAULT current_timestamp(6),
  `parent_comment_id` bigint NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (1, 'Nguyen Van C', 'Sách tốt nha', NULL, NULL, 4, 602);
INSERT INTO `comments` VALUES (2, 'Nguyen Van C', 'Giao hàng nhanh ủng hộ tiếp', NULL, NULL, 4, 602);
INSERT INTO `comments` VALUES (3, 'Nguyen Van C', 'Đóng gói cẩn thận', NULL, NULL, 5, 602);
INSERT INTO `comments` VALUES (4, 'Nguyen Van C', 'Đúng như mô tả', NULL, 52, 5, 602);

-- ----------------------------
-- Table structure for comments_seq
-- ----------------------------
DROP TABLE IF EXISTS `comments_seq`;
CREATE TABLE `comments_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments_seq
-- ----------------------------
INSERT INTO `comments_seq` VALUES (151);

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` bigint NOT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKbioxgbv59vetrxe0ejfubep1w`(`order_id` ASC) USING BTREE,
  INDEX `FKocimc7dtr037rh4ls4l95nlfi`(`product_id` ASC) USING BTREE,
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKocimc7dtr037rh4ls4l95nlfi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, 1, 4, 1);
INSERT INTO `order_items` VALUES (2, 1, 4, 1);
INSERT INTO `order_items` VALUES (3, 1, 4, 1);
INSERT INTO `order_items` VALUES (4, 1, 4, 1);
INSERT INTO `order_items` VALUES (5, 1, 4, 1);
INSERT INTO `order_items` VALUES (6, 1, 4, 1);
INSERT INTO `order_items` VALUES (7, 1, 4, 1);
INSERT INTO `order_items` VALUES (8, 2, 4, 1);
INSERT INTO `order_items` VALUES (9, 2, 4, 3);
INSERT INTO `order_items` VALUES (10, 3, 6, 1);
INSERT INTO `order_items` VALUES (11, 2, 4, 3);
INSERT INTO `order_items` VALUES (12, 3, 6, 1);

-- ----------------------------
-- Table structure for order_items_seq
-- ----------------------------
DROP TABLE IF EXISTS `order_items_seq`;
CREATE TABLE `order_items_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_items_seq
-- ----------------------------
INSERT INTO `order_items_seq` VALUES (301);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `customer_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `customer_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `payment_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `transaction_id` int NULL DEFAULT NULL,
  `total_price` int NULL DEFAULT NULL,
  `payment_status` int NULL DEFAULT NULL,
  `shipping_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `order_status` int NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK32ql8ubntj5uh44ph9659tiih`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (54, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623110249', 14473658, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (55, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623110249', 14473658, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (56, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623110630', 14473664, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (57, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623110630', 14473664, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (102, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623112852', 14473673, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (103, 'Tran Duc Minh', 'tranmin1122@gmail.com', '033333333333', '20240623112852', 14473673, 15000000, 1, 'fffffffffffffffff,\n T?nh Tuy?n Quang, Huy?n L?m B?nh', 1, 602);
INSERT INTO `orders` VALUES (152, 'Tran Duc Minh', 'tranmin1122@gmail.com', '77777777777', '20240623170449', 14474001, 15000000, 1, 'kkkkkkkkkkkkk,\n         Tỉnh Cao Bằng, Huyện Bảo Lâm', 1, 602);
INSERT INTO `orders` VALUES (153, 'Tran Duc Minh', 'tranmin1122@gmail.com', '77777777777', '20240623170449', 14474001, 15000000, 1, 'kkkkkkkkkkkkk,\n  Tỉnh Cao Bằng, Huyện Bảo Lâm', 1, 602);
INSERT INTO `orders` VALUES (202, 'Tran Duc Minh', 'tranmin1122@gmail.com', '099999999999', '20240623210242', 14474318, 70000000, 1, 'linh trung,\n         Thành phố Hà Nội, Quận Ba Đình', 1, 602);
INSERT INTO `orders` VALUES (203, 'Tran Duc Minh', 'tranmin1122@gmail.com', '099999999999', '20240623210242', 14474318, 70000000, 1, 'linh trung,\n         Thành phố Hà Nội, Quận Ba Đình', 1, 602);

-- ----------------------------
-- Table structure for orders_seq
-- ----------------------------
DROP TABLE IF EXISTS `orders_seq`;
CREATE TABLE `orders_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_seq
-- ----------------------------
INSERT INTO `orders_seq` VALUES (301);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `id` bigint NOT NULL,
  `create_at` datetime(6) NULL DEFAULT NULL,
  `expiry_date` datetime(6) NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_71lqwbwtklmljk3qlsugr1mig`(`token` ASC) USING BTREE,
  INDEX `FKk3ndxg5xp6v7wd4gjyusp15gq`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FKk3ndxg5xp6v7wd4gjyusp15gq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
INSERT INTO `password_reset_tokens` VALUES (2, NULL, '2024-06-24 21:10:06.000000', 'a8eb67c3-9a19-4704-9dec-351d34ba00a3', 502);
INSERT INTO `password_reset_tokens` VALUES (3, NULL, '2024-06-24 21:10:50.000000', '58d5c70d-4b01-47b8-9335-66785d7bcc3d', 502);

-- ----------------------------
-- Table structure for password_reset_tokens_seq
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens_seq`;
CREATE TABLE `password_reset_tokens_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens_seq
-- ----------------------------
INSERT INTO `password_reset_tokens_seq` VALUES (101);

-- ----------------------------
-- Table structure for payment_information
-- ----------------------------
DROP TABLE IF EXISTS `payment_information`;
CREATE TABLE `payment_information`  (
  `user_id` bigint NOT NULL,
  `card_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cardholder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cvv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expiration_date` date NULL DEFAULT NULL,
  INDEX `FK5xb28hck1puvn9ldjnbb1vqm8`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FK5xb28hck1puvn9ldjnbb1vqm8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment_information
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` bigint NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_at` datetime(6) NULL DEFAULT current_timestamp(6),
  `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `discounted_price` int NULL DEFAULT NULL,
  `image_url` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `price` int NULL DEFAULT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `category_id` bigint NULL DEFAULT NULL,
  `promotion_percent` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKog2rp4qthbtt2lfyhfo32lsw9`(`category_id` ASC) USING BTREE,
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES
(1, 'NXB Trẻ', '2024-04-20 10:00:00.000000', 'Đắc Nhân Tâm của Dale Carnegie là quyển sách duy nhất về thể loại self-help liên tục đứng đầu danh mục sách bán chạy nhất (best-selling Books) do báo The New York Times bình chọn suốt 10 năm liền. Được xuất bản năm 1936, với số lượng bán ra hơn 15 triệu bản, tính đến nay, sách đã được dịch ra ở hầu hết các ngôn ngữ, trong đó có cả Việt Nam, và đã nhận được sự đón tiếp nhiệt tình của đọc giả ở hầu hết các quốc gia.', 50000, 'https://nhasachphuongnam.com/images/thumbnails/730/900/detailed/217/dac-nhan-tam-bc.jpg', 60000, 'Đắc Nhân Tâm', 50, 1, NULL);
INSERT INTO `products` VALUES
(2, 'NXB Trẻ', '2024-04-20 12:00:00.000000', 'Người đàn ông mang tên Ove năm nay năm mươi chín tuổi. Ông là kiểu người hay chỉ thẳng mặt những kẻ mà ông không ưa như thể họ là bọn ăn trộm và ngón trỏ của ông là cây đèn pin của cảnh sát. Ove tin tất cả những người ở nơi ông sống đều kém cỏi, ngu dốt và không đáng làm hàng xóm của ông. Ove nguyên tắc, cứng nhắc, cấm cảu và cay nghiệt.', 13000, 'https://cdn0.fahasa.com/media/flashmagazine/images/page_images/nguoi_dan_ong_mang_ten_ove_tai_ban/2024_02_29_17_38_24_1-390x510.jpg?_gl=1*r59v5x*_ga*MTI4MTYzMzMyLjE3MzM5ODI2MzQ.*_ga_D3YYPWQ9LN*MTczNTg1MTE5Ny4zLjEuMTczNTg1MTMzMS4wLjAuMA..*_gcl_aw*R0NMLjE3MzU4NTEyNDcuQ2owS0NRaUFqOW03QmhEMUFSSXNBTnNJSXZDX1dkTHdNeXczV3paTG4zREs2dDM0WkRnZU12VDFrWFUwcDd5ZW1KbXJuQTl6ZmdkY3pYVWFBaVRHRUFMd193Y0I.*_gcl_au*MjEwMTA0MzMuMTczMzk4MjYzNA..*_ga_460L9JMC2G*MTczNTg1MTE5Ny4zLjEuMTczNTg1MTMzMi4zNy4wLjcxOTkxMzQ5MQ..', 15000, 'Người Đàn Ông Mang Tên OVE', 20, 1, NULL);
INSERT INTO `products` VALUES (3, 'NXB Trẻ', '2024-04-20 13:00:00.000000', '', 10000, 'https://www.nxbtre.com.vn/Images/Book/nxbtre_thumb_25412024_024109.jpg', 20000, 'Tiệm sách của nàng', 25, 1, NULL);
INSERT INTO `products` VALUES 
(4, 'NXB Phương Nam', '2024-04-20 15:00:00.000000', 'Cuốn sách này kể về một hành trình đầy cảm hứng, khơi dậy niềm tin và động lực sống. Một lựa chọn tuyệt vời cho những ai muốn tìm hiểu về khả năng vượt qua thử thách trong cuộc sống.', 75000, 'https://cdn0.fahasa.com/media/catalog/product/i/m/image_58685.jpg', 100000, 'Cuộc Sống Lý Tưởng', 40, 1, NULL),
(5, 'NXB Phương Nam', '2024-04-20 15:15:00.000000', 'Một cuốn sách giúp bạn thay đổi cách nhìn nhận về cuộc sống, mở rộng trí tuệ và học cách sống một cách tích cực hơn. Những bài học quý giá để giúp bạn tiến xa hơn trong cuộc đời.', 85000, 'https://eccthai.com/wp-content/uploads/2021/12/tim-diem-can-bang-trong-cuoc-song.jpg', 110000, 'Sống Tích Cực', 50, 1, NULL),
(6, 'NXB Hà Nội', '2024-04-20 16:00:00.000000', 'Câu chuyện cảm động về tình yêu và sự hy sinh của những người thân yêu. Một cuốn sách đầy cảm xúc về những mối quan hệ gia đình và tình bạn. Một sự lựa chọn không thể bỏ qua cho những ai yêu thích sự sâu sắc trong văn học.', 60000, 'https://newshop.vn/public/uploads/products/56361/tinh-yeu-tinh-duc-va-gia-dinh.jpg', 70000, 'Tình Yêu Và Gia Đình', 60, 1, NULL),
(7, 'NXB TPHCM', '2024-04-20 16:30:00.000000', 'Cuốn sách này mang đến cho bạn những kỹ năng quan trọng trong việc phát triển bản thân, từ việc làm việc nhóm đến kỹ năng giao tiếp. Dành cho những ai muốn thành công trong cuộc sống.', 95000, 'https://nhasachphuongnam.com/images/thumbnails/730/900/detailed/239/ky-nang-phat-trien-ban-than.jpg', 120000, 'Kỹ Năng Phát Triển Bản Thân', 45, 1, NULL),
(8, 'NXB TPHCM', '2024-04-20 17:00:00.000000', 'Hành trình tìm kiếm sự bình an trong tâm hồn giữa thế giới ồn ào và vội vã. Cuốn sách này hướng dẫn bạn cách tìm lại sự thanh thản trong tâm trí và cuộc sống. Một lựa chọn tuyệt vời cho những ai tìm kiếm sự an yên trong cuộc sống.', 99000, 'https://bizbooks.vn/uploads/images/2024/thang-11/binh-an-trong-bao-tap-1.jpg', 130000, 'Tìm Lại Bình An', 55, 1, NULL),
(9, 'NXB Trẻ', '2024-04-20 18:00:00.000000', 'Cuốn sách này giúp bạn vượt qua sự căng thẳng và lo âu, tìm ra cách để thư giãn và tận hưởng cuộc sống một cách trọn vẹn hơn. Một công cụ hữu ích cho những ai đang cảm thấy mệt mỏi trong công việc và cuộc sống.', 70000, 'https://product.hstatic.net/200000845405/product/82cf6947877e48511781a0daf79a5114_02e3352052c04b36a5e0a59aca1d6377_grande.jpg', 80000, 'Vượt Qua Lo Âu', 45, 1, NULL),
(10, 'NXB Trẻ', '2024-04-20 18:30:00.000000', 'Một câu chuyện cảm động về lòng dũng cảm và sức mạnh của con người khi đối diện với những khó khăn trong cuộc sống. Cuốn sách này sẽ khiến bạn rơi lệ và suy ngẫm sâu sắc về giá trị của sự sống.', 85000, 'https://thuviensohoa.vn/img/news/2024/05/larger/15676-long-dung-cam-1.jpg?v=5006', 100000, 'Lòng Dũng Cảm', 50, 1, NULL),
(11, 'NXB Kim Đồng', '2024-04-20 19:00:00.000000', 'Cuốn sách này sẽ đưa bạn vào một thế giới kỳ diệu của sự sáng tạo và đổi mới. Một lựa chọn tuyệt vời cho những ai muốn phát triển khả năng sáng tạo trong công việc và cuộc sống hàng ngày.', 60000, 'https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_47002.jpg', 70000, 'Sáng Tạo Mỗi Ngày', 40, 1, NULL),
(12, 'NXB Kim Đồng', '2024-04-20 19:30:00.000000', 'Hãy để cuốn sách này giúp bạn nhìn nhận lại cuộc sống và học cách yêu thương bản thân mình hơn. Cuốn sách truyền cảm hứng mạnh mẽ cho những ai cảm thấy lạc lối và cần tìm lại bản thân.', 75000, 'https://nhasachphuongnam.com/images/detailed/246/self-care-tu-cham-soc-cuoc-song-yeu-thuong-ban-than.jpg', 90000, 'Yêu Thương Bản Thân', 50, 1, NULL),
(13, 'NXB Nhã Nam', '2024-04-20 20:00:00.000000', 'Một cuốn sách thú vị về cách đối mặt với sự thất bại và biến nó thành cơ hội học hỏi. Cung cấp những bài học thực tế và ứng dụng cao trong công việc và cuộc sống. Đặc biệt thích hợp cho những ai đang đối mặt với thử thách.', 68000, 'https://sbooks.vn/wp-content/uploads/2024/05/73592436bd3740aeb2ebf6645f15addbtplv-o3syd03w52-origin-jpeg.jpeg', 80000, 'Biến Thất Bại Thành Thành Công', 35, 1, NULL),
(14, 'NXB Nhã Nam', '2024-04-20 20:30:00.000000', 'Cuốn sách này nói về việc vượt qua những thử thách lớn trong cuộc sống. Câu chuyện đầy cảm hứng của một người đàn ông không bao giờ từ bỏ và luôn tìm cách đạt được mục tiêu, bất chấp mọi khó khăn.', 90000, 'https://baodongnai.com.vn/file/e7837c02876411cd0187645a2551379f/dataimages/202002/original/images2269139_16b.jpg', 110000, 'Không Bao Giờ Từ Bỏ', 60, 1, NULL),
(15, 'NXB Phương Nam', '2024-04-20 21:00:00.000000', 'Cuốn sách này tập trung vào việc phát triển tư duy chiến lược và kỹ năng lãnh đạo. Một tài liệu quan trọng cho những ai muốn vươn lên trong sự nghiệp và trở thành những nhà lãnh đạo xuất sắc.', 95000, 'https://cdn0.fahasa.com/media/catalog/product/t/u/tu_duy_chien_luoc_1_2018_08_04_09_07_24.jpg', 115000, 'Lãnh Đạo Từ Tư Duy Chiến Lược', 40, 1, NULL),
(16, 'NXB Phương Nam', '2024-04-20 21:30:00.000000', 'Cuốn sách này sẽ hướng dẫn bạn cách vượt qua những nỗi sợ trong cuộc sống và biến những điều tiêu cực thành động lực phát triển bản thân. Một sự lựa chọn tuyệt vời cho những ai muốn phát triển tâm lý tích cực.', 80000, 'https://nhasachphuongnam.com/images/detailed/266/vuot-qua-noi-so-giao-tiep.jpg', 95000, 'Vượt Qua Nỗi Sợ', 55, 1, NULL),
(17, 'NXB Hà Nội', '2024-04-20 22:00:00.000000', 'Cuốn sách này khám phá cách mà các nhà lãnh đạo xuất sắc làm việc và đưa ra những quyết định quan trọng. Một cuốn sách dành cho những ai đang tìm kiếm sự thành công trong sự nghiệp và cuộc sống.', 105000, 'https://cdn0.fahasa.com/media/catalog/product/i/m/image_184724.jpg', 120000, 'Lãnh Đạo Xuất Sắc', 50, 1, NULL),
(18, 'NXB TPHCM', '2024-04-20 22:30:00.000000', 'Cuốn sách này không chỉ giúp bạn hiểu về chiến lược kinh doanh mà còn cung cấp những câu chuyện thực tế về cách các doanh nghiệp lớn thành công. Một tài liệu quan trọng cho những ai muốn phát triển sự nghiệp kinh doanh.', 100000, 'https://salt.tikicdn.com/ts/product/2a/a7/1c/1f7dd121ff829d626a3bfd4dced31555.jpg', 120000, 'Chiến Lược Kinh Doanh', 60, 1, NULL),
(19, 'NXB TPHCM', '2024-04-20 23:00:00.000000', 'Cuốn sách này là một bộ sưu tập các câu chuyện ngắn giúp bạn nhìn nhận lại cuộc sống từ nhiều góc độ khác nhau. Mỗi câu chuyện là một bài học quý giá giúp bạn trưởng thành hơn.', 85000, 'https://www.nxbtre.com.vn/Images/Book/nxbtre_full_29292017_042903.jpg', 100000, 'Harry Potter Và Hoàng Tử Lai', 45, 1, NULL),
(20, 'NXB Kim Đồng', '2024-04-20 23:30:00.000000', 'Cuốn sách này sẽ đưa bạn đến với những câu chuyện huyền bí và kỳ thú, giúp bạn thư giãn và tìm lại sự thư thái trong tâm hồn. Một sự lựa chọn lý tưởng cho những ai yêu thích thể loại văn học kỳ ảo.', 95000, 'https://cdn0.fahasa.com/media/catalog/product/b/i/bia_the_gioi_ky_bi_moonbooks_-1.png', 110000, 'Thế Giới Kỳ Bí', 50, 1, NULL),
(21, 'NXB Kim Đồng', '2024-04-21 00:00:00.000000', 'Cuốn sách này là câu chuyện về một cuộc phiêu lưu không ngừng nghỉ, nơi mà mỗi thử thách đều là một cơ hội để trưởng thành. Một lựa chọn hoàn hảo cho những ai yêu thích thể loại sách phiêu lưu.', 70000, 'https://cdn0.fahasa.com/media/catalog/product/c/u/cuoc_phieu_luu_vi_dai_cua_herbie_1_2018_09_24_11_33_57.JPG', 80000, 'Cuộc Phiêu Lưu Vĩ Đại', 55, 1, NULL),
(22, 'NXB Nhã Nam', '2024-04-21 00:30:00.000000', 'Cuốn sách này tập trung vào việc thay đổi thói quen để sống một cuộc đời hạnh phúc và thịnh vượng hơn. Đặc biệt hữu ích cho những ai muốn tạo dựng nền tảng cuộc sống vững chắc.', 65000, 'https://mcbooks.vn/wp-content/uploads/2019/05/S%C3%A1ch-th%C3%B3i-quen-th%C3%A0nh-c%C3%B4ng.jpg', 75000, 'Thói Quen Thành Công', 60, 1, NULL),
(23, 'NXB Nhã Nam', '2024-04-21 01:00:00.000000', 'Cuốn sách này nói về những bí quyết để thành công trong sự nghiệp và cuộc sống. Bạn sẽ học được cách xây dựng những mục tiêu lớn và cách thực hiện chúng từng bước một.', 85000, 'https://firstnews.vn/upload/products/thumb_800x0/biquyetthanhcong-88k-01.jpeg', 100000, 'Bí Quyết Thành Công', 40, 1, NULL),
(24, 'NXB Phương Nam', '2024-04-21 01:30:00.000000', 'Cuốn sách này giúp bạn khám phá những kỹ năng lãnh đạo đích thực và cách áp dụng chúng vào công việc và cuộc sống. Dành cho những ai muốn trở thành nhà lãnh đạo xuất sắc.', 92000, 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/l/a/lanh-dao-dich-thuc.jpg.webp', 110000, 'Kỹ Năng Lãnh Đạo Đích Thực', 50, 1, NULL),
(25, 'NXB Phương Nam', '2024-04-21 02:00:00.000000', 'Cuốn sách này cung cấp những hướng dẫn chi tiết về cách làm việc hiệu quả và đạt được mục tiêu một cách nhanh chóng. Một tài liệu quan trọng cho những ai muốn thành công trong công việc.', 87000, 'https://cdn0.fahasa.com/media/catalog/product/7/7/77-th_i-quen600.jpg', 100000, 'Làm Việc Hiệu Quả', 45, 1, NULL);  

-- ----------------------------
-- Table structure for products_seq
-- ----------------------------
DROP TABLE IF EXISTS `products_seq`;
CREATE TABLE `products_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products_seq
-- ----------------------------
INSERT INTO `products_seq` VALUES (1);

-- ----------------------------
-- Table structure for ratings
-- ----------------------------
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings`  (
  `id` bigint NOT NULL,
  `rating` double NULL DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK228us4dg38ewge41gos8y761r`(`product_id` ASC) USING BTREE,
  INDEX `FKb3354ee2xxvdrbyq9f42jdayd`(`user_id` ASC) USING BTREE,
  CONSTRAINT `FK228us4dg38ewge41gos8y761r` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKb3354ee2xxvdrbyq9f42jdayd` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ratings
-- ----------------------------

-- ----------------------------
-- Table structure for ratings_seq
-- ----------------------------
DROP TABLE IF EXISTS `ratings_seq`;
CREATE TABLE `ratings_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ratings_seq
-- ----------------------------
INSERT INTO `ratings_seq` VALUES (1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` datetime(6) NULL DEFAULT current_timestamp(6),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (502, 'tranminh80802@gmail.com', 'tranminh80802', '$2a$10$9PRzwwO0VlJNj0J4iVphg.2fF1b4PMyG8mTkshpq0ENrSq7NloOJW', '0378765888', 'Tran Duc Minh', 'ROLE_USER', NULL);
INSERT INTO `users` VALUES (602, 'tranmin1122@gmail.com', 'tranmin1122', '$2a$10$suNAU1oVmMdUjPBLDMPs2OY0vF2I7T/H54JMEJ1Av/wsrLKD6YhGm', '0378765888', 'Tran Duc Minh', 'ROLE_USER', NULL);

-- ----------------------------
-- Table structure for users_seq
-- ----------------------------
DROP TABLE IF EXISTS `users_seq`;
CREATE TABLE `users_seq`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_seq
-- ----------------------------
INSERT INTO `users_seq` VALUES (1);

SET FOREIGN_KEY_CHECKS = 1;
