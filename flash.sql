/*
 Navicat Premium Data Transfer

 Source Server         : luxuhua
 Source Server Type    : MySQL
 Source Server Version : 50618
 Source Host           : localhost:3306
 Source Schema         : flash

 Target Server Type    : MySQL
 Target Server Version : 50618
 File Encoding         : 65001

 Date: 07/06/2023 18:19:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '收货人',
  `province_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '区级名称',
  `sex` tinyint(4) NOT NULL COMMENT '性别 0 女 1 男',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '地址管理' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (1664957993697763330, 1664930207318720514, '小明', NULL, NULL, NULL, NULL, NULL, NULL, 1, '14256478126', '花都区广东培正学院', '学校', 1, '2023-06-03 21:05:11', '2023-06-07 11:41:25', 1664930207318720514, 1664930207318720514, 0);
INSERT INTO `address_book` VALUES (1666086168964108290, 1, '张三', NULL, NULL, NULL, NULL, NULL, NULL, 1, '13456847861', '花都区广东培正学院', '学校', 1, '2023-06-06 22:14:32', '2023-06-06 22:14:33', 1, 1, 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1665744874484019202, 1, '主食', 0, '2023-06-05 23:38:21', '2023-06-05 23:38:21', 1, 1);
INSERT INTO `category` VALUES (1666070892243709954, 1, '大口吃肉', 1, '2023-06-06 21:13:49', '2023-06-06 21:13:49', 1, 1);
INSERT INTO `category` VALUES (1666070951416950785, 1, '甜品', 2, '2023-06-06 21:14:04', '2023-06-06 21:14:04', 1, 1);
INSERT INTO `category` VALUES (1666071175346647042, 1, '饮品', 3, '2023-06-06 21:14:57', '2023-06-06 21:14:57', 1, 1);
INSERT INTO `category` VALUES (1666072997381664770, 2, '超值套餐', 5, '2023-06-06 21:22:11', '2023-06-06 21:40:08', 1, 1);
INSERT INTO `category` VALUES (1666077550701256705, 1, '小吃', 4, '2023-06-06 21:40:17', '2023-06-06 21:40:17', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_dish_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品管理' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1666075903702933506, '安格斯牛勒条', 1666070892243709954, 5000.00, '', '7ca975f4-e07c-414d-80a3-07119bc195b8.jpg', '安格斯牛勒条是一道以高品质Angus牛肉为原材料制作的菜品。这种肉质鲜嫩多汁、味道浓郁的肉类，经过精细加工成长条状，再油炸或烤制至金黄酥脆，外酥里嫩，口感极佳。', 1, 0, '2023-06-06 21:33:44', '2023-06-06 21:33:44', 1, 1, 0);
INSERT INTO `dish` VALUES (1666076755821928450, '宝仙尼菌菠菜面', 1665744874484019202, 3000.00, '', '33a29207-3b6f-4a68-ac55-0cd71f01e367.jpg', '宝仙尼菌菠菜面是一道以宝仙尼菌和菠菜为主要原材料的面食菜品，它是一道健康营养而又美味口感的素食佳肴。', 1, 0, '2023-06-06 21:37:07', '2023-06-06 21:37:07', 1, 1, 0);
INSERT INTO `dish` VALUES (1666077309730103298, '菠萝炒饭', 1665744874484019202, 3000.00, '', '4ae30407-723c-4600-ab72-7df96ed84948.jpg', '菠萝炒饭是一道美味的中式菜品，它以米饭和菠萝为主要原材料，加入鸡蛋、鸡肉、胡萝卜、青豆等多种食材，经过煮炒烹制而成。', 1, 0, '2023-06-06 21:39:20', '2023-06-06 21:39:20', 1, 1, 0);
INSERT INTO `dish` VALUES (1666077875931783170, '脆皮金枪鱼沙拉', 1666077550701256705, 5600.00, '', 'e563d778-9b01-4943-84bc-9da95fceaa61.jpg', '脆皮金枪鱼沙拉是一道以金枪鱼为主要原材料，搭配蔬菜、水果等多种食材烹制而成的沙拉美食', 1, 0, '2023-06-06 21:41:35', '2023-06-06 21:41:35', 1, 1, 0);
INSERT INTO `dish` VALUES (1666078183244242946, '德国肠拼盘', 1666077550701256705, 2500.00, '', 'bb22c056-5377-46d2-8a50-1ed9c9be1e0e.jpg', '德国肠拼盘是一道德国经典的开胃菜。它是由多种不同口感、风味的香肠和腌制蔬菜组成的，常见的原材料包括多种烟熏和生肠、辣味和甜味香肠、腌黄瓜、糖渍小青椒等。', 1, 0, '2023-06-06 21:42:48', '2023-06-06 21:42:48', 1, 1, 0);
INSERT INTO `dish` VALUES (1666078464854007809, '煎蘑菇', 1666077550701256705, 3000.00, '', '72f47f3d-b269-47de-ab1a-833fe346bf6a.jpg', '新鲜蘑菇制作', 1, 0, '2023-06-06 21:43:55', '2023-06-06 21:43:55', 1, 1, 0);
INSERT INTO `dish` VALUES (1666078870900383746, '烤蒜香鸡扒', 1666070892243709954, 3500.00, '', 'fd2b04a0-44bd-4871-927e-db7dbf34bc45.jpg', '烤蒜香鸡扒是一道美味可口的主菜，以鸡肉为主要原材料，配以大蒜和各种香料制成。', 1, 0, '2023-06-06 21:45:32', '2023-06-06 21:45:32', 1, 1, 0);
INSERT INTO `dish` VALUES (1666079137301602306, '奶茶', 1666071175346647042, 1500.00, '', 'cd534ac5-2836-4886-a0be-db59930e7913.jpg', '丝滑醇厚，茶叶和牛奶调配而成。', 1, 0, '2023-06-06 21:46:35', '2023-06-06 21:46:35', 1, 1, 0);
INSERT INTO `dish` VALUES (1666079368084791298, '生椰拿铁', 1666071175346647042, 2000.00, '', 'c12997df-a6f0-44d6-8e16-8782edd644b7.jpg', '生椰拿铁是一种非常受欢迎的咖啡饮品，它以浓缩咖啡为基础，添加了椰子糖浆和牛奶。这种咖啡饮品味道丰富、口感圆润，深受喜爱。', 1, 0, '2023-06-06 21:47:30', '2023-06-06 21:47:30', 1, 1, 0);
INSERT INTO `dish` VALUES (1666079668887691265, '提拉米苏', 1666070951416950785, 2600.00, '', 'b28c5513-72b7-4a32-b761-a68c6c9eb5d7.jpg', '提拉米苏的口感丰富，略带甜味，既具有浓郁的咖啡香气，也有奶酪馅的柔软浓郁。它的口感非常丰富，丝滑、柔软，同时又带有微妙的酒香和咖啡苦涩的味道.', 1, 0, '2023-06-06 21:48:42', '2023-06-06 21:48:42', 1, 1, 0);
INSERT INTO `dish` VALUES (1666079781014020098, '西瓜奶冰', 1666071175346647042, 1800.00, '', 'd1c1621c-0aa3-42d1-b206-70defbab5a06.jpg', '西瓜、奶和冰制作而成。', 1, 0, '2023-06-06 21:49:09', '2023-06-06 21:49:09', 1, 1, 0);
INSERT INTO `dish` VALUES (1666080071889002497, '小吃拼盘', 1666077550701256705, 4200.00, '', 'bdf2275a-eb5a-418e-b4e6-e1ae4289b809.jpg', '由德国香肠、煎蘑菇等几种小吃组成的拼盘', 1, 0, '2023-06-06 21:50:18', '2023-06-06 21:50:18', 1, 1, 0);
INSERT INTO `dish` VALUES (1666080193645453313, '新奥尔良鸡翅', 1666070892243709954, 3400.00, '', '4992e104-b450-46e7-a33b-62b8c1df5196.jpg', '奥尔良风味鸡翅', 1, 0, '2023-06-06 21:50:47', '2023-06-06 21:50:47', 1, 1, 0);
INSERT INTO `dish` VALUES (1666080613168128001, '雪花牛小扒', 1666070892243709954, 5600.00, '', '4eb515ca-e6a1-4684-a921-2dfa0185827a.jpg', '雪花牛小扒的口感非常特别，牛肉一片片像雪花一样纷繁飞舞，口感清爽且富有嚼劲，香气扑鼻。同时，它也具有较高的营养价值，牛肉含有大量蛋白质、铁和维生素等营养元素，对身体健康有很好的作用。', 1, 0, '2023-06-06 21:52:27', '2023-06-06 21:52:27', 1, 1, 0);
INSERT INTO `dish` VALUES (1666081143546257410, '榴莲pizza', 1666070951416950785, 5600.00, '', '75efa70c-36fa-47ce-b909-347d9d713ae6.jpg', '榴莲披萨，是一种将传统的意式披萨与亚洲特有的水果榴莲相结合的美食。它通常使用新鲜榴莲果肉作为配料，与芝士、蔬菜、番茄酱等传统意式披萨材料搭配在一起，烤至金黄色即可。', 1, 0, '2023-06-06 21:54:34', '2023-06-06 21:54:34', 1, 1, 0);
INSERT INTO `dish` VALUES (1666084678539153410, '意式奶油菠菜面', 1665744874484019202, 3500.00, '', 'b10f7036-7bf2-43ad-9138-b7f4b59db171.jpg', '', 1, 0, '2023-06-06 22:08:36', '2023-06-06 22:08:36', 1, 1, 0);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) NOT NULL COMMENT '菜品',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '口味名称',
  `value` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味数据list',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品口味关系表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (1666075903702933507, 1666075903702933506, '火候', '[\"三成熟\",\"五成熟\",\"七成熟\",\"全熟\"]', '2023-06-06 21:33:44', '2023-06-06 21:33:44', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666075903702933508, 1666075903702933506, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-06-06 21:33:44', '2023-06-06 21:33:44', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666078183244242947, 1666078183244242946, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2023-06-06 21:42:48', '2023-06-06 21:42:48', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666079137301602307, 1666079137301602306, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"正常糖\",\"多糖\"]', '2023-06-06 21:46:35', '2023-06-06 21:46:35', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666079137301602308, 1666079137301602306, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2023-06-06 21:46:35', '2023-06-06 21:46:35', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666079368084791299, 1666079368084791298, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"正常糖\",\"多糖\"]', '2023-06-06 21:47:30', '2023-06-06 21:47:30', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1666079368084791300, 1666079368084791298, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2023-06-06 21:47:30', '2023-06-06 21:47:30', 1, 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '员工信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2021-05-06 17:20:07', '2021-05-10 02:24:09', 1, 1);
INSERT INTO `employee` VALUES (1663114319506558977, '张大春', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '14567895432', '1', '445611111123384454', 1, '2023-05-29 17:25:28', '2023-05-30 20:55:48', 1, 1);
INSERT INTO `employee` VALUES (1663532716098641922, 'text', 'text', 'e10adc3949ba59abbe56e057f20f883e', '13245458165', '1', '454515121231312313', 1, '2023-05-30 21:08:01', '2023-05-30 21:08:01', 1, 1);
INSERT INTO `employee` VALUES (1663533133486358530, 'dsa', 'abc', 'e10adc3949ba59abbe56e057f20f883e', '14579412134', '1', '121233464642122121', 1, '2023-05-30 21:09:44', '2023-06-05 18:02:06', 1, 1);
INSERT INTO `employee` VALUES (1665660394297708546, 'qwe', 'qwe', 'e10adc3949ba59abbe56e057f20f883e', '14725836911', '0', '441247856210321423', 1, '2023-06-05 18:02:39', '2023-06-05 18:02:39', 1, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单明细表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1666086633617526785, '精选团聚三人套餐', 'd3005814-9f81-47a9-8248-1337256677fb.jpg', 1666086633550417922, NULL, 1666084828707819521, NULL, 1, 199.00);
INSERT INTO `order_detail` VALUES (1666286081681436674, '意式奶油菠菜面', 'b10f7036-7bf2-43ad-9138-b7f4b59db171.jpg', 1666286081681436673, 1666084678539153410, NULL, NULL, 1, 35.00);
INSERT INTO `order_detail` VALUES (1666286081681436675, '安格斯牛勒条', '7ca975f4-e07c-414d-80a3-07119bc195b8.jpg', 1666286081681436673, 1666075903702933506, NULL, '三成熟,不辣', 1, 50.00);
INSERT INTO `order_detail` VALUES (1666292675144122370, '意式奶油菠菜面', 'b10f7036-7bf2-43ad-9138-b7f4b59db171.jpg', 1666292675144122369, 1666084678539153410, NULL, NULL, 1, 35.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款，2待派送，3已派送，4已完成，5已取消',
  `user_id` bigint(20) NOT NULL COMMENT '下单用户',
  `address_book_id` bigint(20) NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NOT NULL COMMENT '结账时间',
  `pay_method` int(11) NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1666086633550417922, '1666086633550417922', 2, 1664930207318720514, 1664957993697763330, '2023-06-06 22:16:22', '2023-06-06 22:16:22', 1, 199.00, '', '14256478126', '花都区广东培正学院', NULL, '小明');
INSERT INTO `orders` VALUES (1666292675144122369, '1666292675144122369', 2, 1664930207318720514, 1664957993697763330, '2023-06-07 11:55:07', '2023-06-07 11:55:07', 1, 35.00, '', '14256478126', '花都区广东培正学院', NULL, '小明');

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_setmeal_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (1666084485596975106, 1666072997381664770, '罗曼蒂克双人套餐', 11900.00, 1, '', '超值双人套餐', 'fe44cb32-6634-42cb-85a9-9d77d488e9b8.jpg', '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal` VALUES (1666084828707819521, 1666072997381664770, '精选团聚三人套餐', 19900.00, 1, '', '', 'd3005814-9f81-47a9-8248-1337256677fb.jpg', '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `setmeal_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐id ',
  `dish_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品原价（冗余字段）',
  `copies` int(11) NOT NULL COMMENT '份数',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐菜品关系' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (1666084485596975107, '1666084485596975106', '1666077309730103298', '菠萝炒饭', 3000.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084485596975108, '1666084485596975106', '1666076755821928450', '宝仙尼菌菠菜面', 3000.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084485596975109, '1666084485596975106', '1666080613168128001', '雪花牛小扒', 5600.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084485596975110, '1666084485596975106', '1666079781014020098', '西瓜奶冰', 1800.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084485596975111, '1666084485596975106', '1666079368084791298', '生椰拿铁', 2000.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084485596975112, '1666084485596975106', '1666078183244242946', '德国肠拼盘', 2500.00, 1, 0, '2023-06-06 22:07:50', '2023-06-06 22:07:50', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819522, '1666084828707819521', '1666077309730103298', '菠萝炒饭', 3000.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819523, '1666084828707819521', '1666076755821928450', '宝仙尼菌菠菜面', 3000.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819524, '1666084828707819521', '1666075903702933506', '安格斯牛勒条', 5000.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819525, '1666084828707819521', '1666080193645453313', '新奥尔良鸡翅', 3400.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819526, '1666084828707819521', '1666079781014020098', '西瓜奶冰', 1800.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819527, '1666084828707819521', '1666079368084791298', '生椰拿铁', 2000.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819528, '1666084828707819521', '1666079137301602306', '奶茶', 1500.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1666084828707819529, '1666084828707819521', '1666080071889002497', '小吃拼盘', 4200.00, 1, 0, '2023-06-06 22:09:12', '2023-06-06 22:09:12', 1, 1, 0);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '购物车' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1666289990638616578, '菠萝炒饭', '4ae30407-723c-4600-ab72-7df96ed84948.jpg', 1, 1666077309730103298, NULL, NULL, 1, 30.00, '2023-06-07 11:44:27');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '姓名',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邮箱地址',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '头像',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态 0:禁用，1:正常',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '用户信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1664930207318720514, NULL, '1944845571@qq.com', NULL, NULL, NULL, 1);

SET FOREIGN_KEY_CHECKS = 1;
