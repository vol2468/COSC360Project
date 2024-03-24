-- This file executes SQL DDL. 
-- This file is automatically run when you run docker-compose up -d on your terminal. 


-- Following is the DDLe statements only for testing purposes. 
-- Actual statements will be very defferent. 

DROP TABLE IF EXISTS test;

CREATE TABLE test (
    eno CHAR(5), 
    ename VARCHAR(30) NOT NULL, 
    bdate DATE, 
    title CHAR(2), 
    salary DECIMAL(9,2), 
    supereno CHAR(5), 
    dno CHAR(5), 
    PRIMARY KEY (eno)
);

INSERT INTO test (eno, ename) VALUES ("E0001", "Yuki Isomura"); 
INSERT INTO test (eno, ename) VALUES ("E0002", "Taii Hirano"); 
INSERT INTO test (eno, ename) VALUES ("E0003", "Adams Chen"); 
INSERT INTO test (eno, ename) VALUES ("E0004", "Mr.Random"); 



-- Dropping existing tables to clear
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS watchList;
DROP TABLE IF EXISTS priceHistory;
DROP TABLE IF EXISTS visitHistory;
DROP TABLE IF EXISTS image;


-- Creating tables
CREATE TABLE category (
    cid         INT AUTO_INCREMENT, 
    cname       VARCHAR(50) NOT NULL,
    PRIMARY KEY (cid)  
);

CREATE TABLE image (
    imgid       INT AUTO_INCREMENT, 
    fileType    VARCHAR(30), 
    file        LONGBLOB,
    PRIMARY KEY (imgid)
);

CREATE TABLE user (
    uid         INT AUTO_INCREMENT,
    uname       VARCHAR(40) NOT NULL,
    email       VARCHAR(50) NOT NULL, 
    password    VARCHAR(50) NOT NULL, 
    imgid       INT,                    
    usertype    INT NOT NULL,           -- 0 for user, 1 for admin
    PRIMARY KEY (uid), 
    FOREIGN KEY (imgid) REFERENCES image(imgid)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE product (
    pid         INT AUTO_INCREMENT, 
    pname       VARCHAR(200) NOT NULL, 
    cid         INT,  
    imgid       INT, 
    PRIMARY KEY (pid),
    FOREIGN KEY (cid) REFERENCES category(cid)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (imgid) REFERENCES image(imgid)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE review (
    uid         INT, 
    pid         INT, 
    DATE        DATETIME, 
    rate        INT NOT NULL,  
    comment     VARCHAR(300) NOT NULL, 
    PRIMARY KEY (uid, pid), 
    FOREIGN KEY (uid) REFERENCES user(uid)
        ON UPDATE CASCADE ON DELETE NO ACTION, 
    FOREIGN KEY (pid) REFERENCES product(pid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE watchList (
    uid         INT, 
    pid         INT, 
    threshold   DECIMAL(10,2), 
    PRIMARY KEY (uid, pid),
    FOREIGN KEY (uid) REFERENCES user(uid)
        ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (pid) REFERENCES product(pid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE priceHistory (
    pid         INT, 
    date        DATETIME, 
    price       DECIMAL(10,2),
    PRIMARY KEY (pid, date), 
    FOREIGN KEY (pid) REFERENCES product(pid)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE visitHistory (
    uid         INT, 
    pid         INT, 
    date        DATE,
    PRIMARY KEY (uid, pid, date),
    FOREIGN KEY (uid) REFERENCES user(uid)
        ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (pid) REFERENCES product(pid)
        ON UPDATE CASCADE ON DELETE CASCADE
);


-- Inserting rows
INSERT INTO category(cname) 
    VALUES 
    ('Electronics'), 
    ('Clothing & Apparel'), 
    ('Home & Kitchen'),
    ('Sports & Outdoors'), 
    ('Beauty & Personal Care'), 
    ('Health & Wellness'), 
    ('Toys & Games'),
    ('Books & Literature'), 
    ('Automotive & Parts'), 
    ('Jewelry & Accessories'), 
    ('Pet Supplies'),
    ('Office & Stationery'), 
    ('Furniture & Decor'), 
    ('Food & Grocery'), 
    ('Arts & Crafts');

-- INSERT INTO image needed to be done mannually on database on server. 

INSERT INTO user (uname, email, password, imgid, usertype)
    VALUES 
    ('Taii Hirano', 'taiihirano@student.ubc.ca', 'p@55w0rd', 1, 1), 
    ('Yuki Isomura', 'yukiiso@student.ubc.ca', 'p@55w0rd', 2, 1), 
    ('Adams Chen', 'adamschen@student.ubc.ca', 'p@55w0rd', 3, 1), 
    ('Arnold Anderson', 'a.anderson@gmail.com', '360Arnold!', 4, 0), 
    ('Emily Johnson', 'emily.johnson@example.com', '360Emily!', 5, 0), 
    ('Alexander Smith', 'alexander.smith@example.com', '360Alexander!', 6, 0), 
    ('Sophia Patel', 'sophia.patel@example.com', '360Sophia!', 7, 0), 
    ('Benjamin Williams', 'benjamin.williams@example.com', '360Benjamin!', 8, 0), 
    ('Olivia Garcia', 'olivia.garcia@example.com', '360Olivia!', 9, 0), 
    ('Lucas Kim', 'lucas.kim@example.com', '360Lucas!', 10, 0);

INSERT INTO product (pname, cid, imgid)
    VALUES 
    -- Category 1 Electronics
    ('Nelko Label Maker Machine with Tape, P21 Bluetooth Label Printer, Wireless Mini Label Makers with Multiple Templates for Organizing Office Home, White', 1, 11), 
    ('LISEN USB C Car Charger Adapter Fast Charge 54 W PD36W Cigarette Lighter USB Charger Fast Charging Port Car Phone Charger for iPhone 15 Pro Max Plus', 1, 12), 
    ('Solar-Charger-Power-Bank-38800mAh Portable Charger Fast Charger Dual USB Port Built-in Led Flashlight and Compass for All Cell Phone and Electronic Devices', 1, 13), 
    ('Mini Projector, VISSPL Full HD 1080P Video Projector, Portable Outdoor Projector with Tripod, Kids Gift, Home Theater Movie Phone Projector Compatible with Android/ iOS/ Windows/ TV Stick/ HDMI/ USB', 1, 14), 
    ('Meta Quest 2 — Advanced All-In-One Virtual Reality Headset — 128 GB', 1, 15), 
    -- Category 2 Clothing & Apparel
    ('Simple Joys by Carter''s Baby Boys'' 3-Pack Snug Fit Footed Cotton Pajamas, Blue Sea Life/ Navy Stripe/ White Cars, 18 Months', 2, 16), 
    ('Studio 9Thirty3 Adult Hamptons Tennis Club Oversized Sweatshirt, Vintage Tennis Sweatshirt, Preppy Sweatshirt (Medium, Black)', 2, 17), 
    ('Harley-Davidson Men''s Lightning Crest Full-Zippered Sweatshirt, Black (2XL)', 2, 18), 
    ('SATINIOR 5 Pcs Winter Hat Scarf Gloves Set Knit Beanie Pompom Hat Warm Touch Screen Gloves Earmuff Warmer Stocking for Women (Beige, Khaki)', 2, 19), 
    ('Art Solar Eclipse 2024 Totality April 8 Men Women Kids T-Shirt', 2, 20), 
    -- Category 3 Home & Kitchen
    ('AIDERLY Iron Dish Drying Rack with Drainboard Dish Drainers for Kitchen Counter Sink Adjustable Spout Dish Strainers with Utensil Holder and Knife Slots, Black', 3, 21), 
    ('Seropy Roll Up Dish Drying Rack, Over The Sink Dish Drying Rack Kitchen Rolling Dish Drainer, Foldable Sink Rack Mat Stainless Steel Wire Dish Drying Rack for Kitchen Sink Counter Storage 17.5x11.8', 3, 22), 
    ('Home Hero 20 Pcs Kitchen Knife Set with Sharpener - High Carbon Stainless Steel Knife Block Set with Ergonomic Handles (20 Pcs - Black)', 3, 23), 
    ('Dishwasher Magnet Clean Dirty Sign, Strong Universal Dirty Clean Dishwasher Magnet Indicator for Kitchen Organization, Slide Rustic Farmhouse Black and White Wood', 3, 24), 
    ('TEZZ Sponge Holder for Kitchen Sink- Stainless Steel Kitchen Sink Caddy for Organizing Sponge, Brush & Soap Dish Dispenser, Kitchen Sink Organizer Rack with Adhesive or Counter top, Black', 3, 25), 
    -- Category 4 Sports & Outdoors
    ('Under Armour Men''s Woven Vital Workout Pants, Black (001)/ Onyx White, Medium', 4, 26), 
    ('Nike Club Hoodie (Navy, Medium)', 4, 27), 
    ('Balega Hidden Comfort Performance No Show Athletic Running Socks for Men and Women (1 Pair), White, Medium', 4, 28), 
    ('Descente PJ-328 Long Sleeve Wind Jack, BLK, L', 4, 29), 
    ('KB-LOW BLK Classic Cotton Dad Hat Adjustable Plain Cap. Polo Style Low Profile (Unstructured) (Classic) Black Adjustable', 4, 30), 
    -- Category 5 Beauty & Personal Care
    ('e.l.f. Squeeze Me Lip Balm, Moisturizing Lip Balm For A Sheer Tint Of Color, Infused With Hyaluronic Acid, Vegan & Cruelty-free, Vanilla Frosting', 5, 31), 
    ('BREYLEE Aloe Vera Eye Mask– 60 Pcs - Puffy Eyes and Dark Circles Treatments – Look Younger and Reduce Wrinkles and Fine Lines Undereye, Improve and Firm eye Skin - Pure Natural Material Extraction', 5, 32), 
    ('PEAUAMIE Under Eye Patches (30 Pairs) Gold Eye Mask and Hyaluronic Acid Eye Patches for puffy eyes, Rose Eye Masks for Dark Circles and Puffiness under eye treatment skin care products...', 5, 33), 
    ('18 Pack Shower Steamers - Easter Basket Stuffers, Birthday Gifts - Shower Bombs with Lavender Mint Rose Coco Ocean Grapefruit Natural Fragrance, Self Care & Relaxation Gifts for Women and Men', 5, 34), 
    ('Tree Hut Shea Sugar Scrub Coco Colada, 18 oz, Ultra Hydrating and Exfoliating Scrub for Nourishing Essential Body Care', 5, 35), 
    -- Category 6 Health & Wellness
    ('OLLY Probiotic + Prebiotic Gummy, Digestive Support and Gut Health, 500 Million CFUs, Fiber, Adult Chewable Supplement for Men and Women, Peach, 30 Day Supply - 30 Count', 6, 36), 
    ('RENPHO Smart Scale for Body Weight, Digital Bathroom Scale BMI Weighing Bluetooth Body Fat Scale, Body Composition Monitor Health Analyzer with Smartphone App, 400 lbs - Black Elis 1', 6, 37), 
    ('Apple Cider Vinegar Gummies - 1000mg - Formulated to Support Weight Loss Efforts & Gut Health - Supports Digestion, Detox & Cleansing* - ACV Gummies W/ VIT B12, Beetroot & Pomegranate (120 Gummies)', 6, 38), 
    ('Nature''s Bounty Magnesium, Bone and Muscle Health, Whole Body Support, Tablets, 500 Mg, 200 Ct', 6, 39), 
    ('Sleep Mask for Side Sleeper, Upgraded 3D Contoured Cup Eye mask Blindfold for Man Women, Block Out Light, Eye mask with Adjustable Strap, Breathable & Soft for Sleeping, Yoga, Traveling (Black)', 6, 40), 
    -- Category 7 Toys & Games
    ('LZZAPJ Montessori Toys for 1 Year Old, Sensory Toys for Toddlers 1-3, Infant Pull String Car Seat Toys for Travel, Baby Teething Toy First Birthday Gift for Boys Girls Aged 6, 9, 12, 18 Months.', 7, 41), 
    ('2 Pack Cloud Slime Kit with Red Watermelon and Mint Charms, Scented DIY Slime Supplies for Girls and Boys, Stress Relief Toy for Kids Education, Party Favor, Gift and Birthday', 7, 42), 
    ('JOYIN Kids Bow and Arrow Set, LED Light Up Archery Toy Set with 9 Suction Cup Arrows, Target & Arrow Case, Indoor and Outdoor Hunting Play Gift Toys for Kids, Boys & Girls Ages 3-12', 7, 43), 
    ('Taco Cat Goat Cheese Pizza', 7, 44), 
    ('Spin Master Games Double Twelve Dominoes Set in Storage Tin, for Families and Kids Ages 8 and up', 7, 45), 
    -- Category 8 Books & Literature
    ('The Lost Bookshop: The most charming and uplifting novel for 2024 and the perfect gift for book lovers!', 8, 46), 
    ('The Women: A Novel', 8, 47), 
    ('The Housemaid', 8, 48), 
    ('The War Planners', 8, 49), 
    ('Foreign Deceit (David Wolf Book 1)', 8, 50), 
    -- Category 9 Automotive & Parts
    ('GOOACC 100PCS 7mm 8mm 10mm Compatible with Subaru Push Type Retainer Fasteners Rivets Clips OEM Upgrade for 90914-0007, 90913-0067 & 90914-0051 + Bonus Fastener Remover', 9, 51), 
    ('Super Loud Train Horns, Car Waterproof Durable Air Electric Snail Horn, 12V Raging Sound Air Horns Replacement Kit, Automotive Accessories Universal for Car, Motorcycle, Truck, Bike, Boat (Black)', 9, 52), 
    ('JOYCOURT Car Shift Knob Hoodie, Fashionable Gear Shift Knob Cover, Auto Interior Cute Gadgets, Universal Car Decor Accessories', 9, 53), 
    ('YANF 4Pcs Car Door Lights Compatible with Partial 3/ 4/ 5/ 6/ 7/ X/ Z/ M/ GT Series, Except G02/ 05/ 06/ 07/ 20/ 21/ 22/ 23/ 26/ 80/ 82/ 83, E39/ 46/ 53, etc', 9, 54), 
    ('Hirificing Locking Gas Cap Fuel Tank with Key, Gas Cap Lock Locking Fuel Cap Cover Compatible with Toyota 4Runner, Chevy Silverado 1500 2500 3500, Nissan GMC Honda Subaru Buick #10504 77300-47020', 9, 55), 
    -- Category 10 Jewelry & Accessories
    ('lengnoyp Premium Jewelry Stand, Earring Holder, Necklace Holder Stand, Clear 3-Tier Acrylic Large Storage Jewelry Organizer Stand & Bracelet/ Bangles Stand, 48 Earring Holes Display Stands', 10, 56), 
    ('Simple Bar Jewelry Set Vertical Bar Necklace Earrings Adjustable Cuff Bracelet (Gold)', 10, 57), 
    ('KElofoN Travel Jewelry Case and Organizer with Mirror - Gift for Women and Girls', 10, 58), 
    ('HengLiSam Jewelry Organizer, Small Jewelry Box Earring Holder for Women, Jewelry Storage Box 4-Layer Rotatable Jewelry Accessory Storage Tray with Lid for Rings Bracelets', 10, 59), 
    ('49 Pcs Women Accessories Surfer Wave string Friendship Bracelets Layered Choker Square Claw Hair Clips for Girls (Boho)', 10, 60), 
    -- Category 11 Pet Supplies
    ('AVELORA Dog Water Bottle, Portable pet Water Bottle with Food Container, Outdoor Portable Water Dispenser for Cat, Rabbit, Puppy and Other Pets for Walking, Hiking, Travel(10oz)', 11, 61), 
    ('Comotech 3PCS Dog Bath Brush | Dog Shampoo Brush | Dog Scrubber for Bath | Dog Bath Brush Scrubber | Dog Shower/ Washing Brush with Adjustable Ring Handle for Short & Long Hair (Blue Blue Blue)', 11, 62), 
    ('Pet Feeding Mat-Absorbent Pet Placemat for Food and Water Bowl, with Waterproof Rubber Backing, Quick Dry Water Dispenser Mat for Dog and Cat, 12"x20"', 11, 63), 
    ('Chom Chom Roller Pet Hair Remover and Reusable Lint Roller - ChomChom Cat and Dog Hair Remover for Furniture, Couch, Carpet, Clothing and Bedding - Portable, Multi-Surface Fur Removal Tool', 11, 64), 
    ('FurZapper Pet Hair Remover, 2 Count (Pack of 1)', 11, 65), 
    -- Category 12 Office & Stationery
    ('Better Office Products Vintage Airmail Stationery Paper Set, 100-Piece Set (50 Lined Sheets + 50 Matching Envelopes), Letter Size 8.5 x 11 inch, Double Sided & Lined Paper,', 12, 66), 
    ('Lolocor 360 Degree Rotatable Pen Holder, 5 Slots Office Desk Organizer, Pencil Holder for Desk Multi-Functional Pencil Cup Desktop Stationary Organizer Storage for Office School Home Dark Green', 12, 67), 
    ('Premium Gel Ink Pen Fine Point Pens Ballpoint Pen 0.5mm for Japanese Office School Stationery Supply 12 Packs', 12, 68), 
    ('Mr. Pen- Transparent Sticky Notes, 200 Pcs, Vintage Colors, Round Translucent Sticky Notes, Pastel Sticky Notes, See Through Sticky Notes, Sticky Notes Transparent, Bible Sticky Notes', 12, 69), 
    ('UIXJODO Gel Pens, 5 Pcs 0.5mm Black Ink Pens Fine Point Smooth Writing Pens, High-End Series Pens for Journaling Note Taking, Cute Office School Supplies Gifts for Women Men (Morandi)', 12, 70), 
    -- Category 13 Furniture & Decor
    ('OLIXIS Modern Lift Top Coffee Table Wooden Furniture with Storage Shelf and Hidden Compartment for Living Room Office (Black)', 13, 71), 
    ('WLIVE Dresser for Bedroom with 5 Drawers, Wide Chest of Drawers, Fabric Dresser, Storage Organizer Unit with Fabric Bins for Closet, Living Room, Hallway, Rustic Brown Wood Grain Print', 13, 72), 
    ('Tromlycs Couch Sofa Cushion Support for Sagging Seat Curve Furniture Seat Under Cushion Sag Repair Set of 2', 13, 73), 
    ('DEYILIAN Hanging Shoe Rack 2 Pack, Wall Mounted Shoe Rack with Sticky Hanging Mounts, Wall Shoes Holder Storage Organizer Shelf, Shoe Rack for Wall Camper and RV Shoe Storage with Hooks No Drilling', 13, 74), 
    ('Hansleep Memory Foam Twin Size Mattress Topper, Twin Cooling Mattress Pad with Deep Pocket, Breathable Air Twin Mattress Cover, 39x75 Inches, Charcoal', 13, 75),  
    -- Category 14 Food & Grocery
    ('Nongshim Gourmet Spicy Shin Instant Ramen Noodle, 20 Pack, Chunky Vegetables, Premium Microwaveable Ramen Soup Mix, Savory & Rich', 14, 76), 
    ('Samyang Buldak Spicy Ramen, Hot Chicken Ramen, Korean Stir-Fried Instant Noodle, Original, 1 Bag with 5 Pack', 14, 77), 
    ('RITZ Fresh Stacks Original Crackers, Party Size, 23.7 oz (16 Stacks)', 14, 78), 
    ('Spam Classic, 12 Ounce Can (Pack of 12', 14, 79), 
    ('Japanese populer Ramen "ICHIRAN" instant noodles tonkotsu 5 meals(Japan Import)', 14, 80),  
    -- Category 15 Arts & Crafts
    ('RMJOY Rainbow Scratch Paper Sets: 60pcs Magic Art Craft Scratch Off Papers Supplies Kits Pad for Age 3-12 Kids Girl Boy Teen Toy Game Gift for Birthday|Party Favor|DIY Activities|Painting Game Gift', 15, 81), 
    ('Water Marbling Paint for Kids - Arts and Crafts for Girls & Boys Crafts Kits Ideal Gifts for Kids Age 3-5 4-8 8-12', 15, 82), 
    ('Arcane Tinmen ApS ART12090 Dragon Shield: Brushed Art Constellations Drasmorx (100)', 15, 83), 
    ('BOHADIY DIY Horse Diamond Painting Kits for Adults Full Drill Colorful Horse Gem Art Kits with Crystal Rhinestone Sunflower Paint with Diamond for Home Wall Decor 12*16 inch', 15, 84), 
    ('Art Painting Display Easel Stand - Portable Adjustable Aluminum Metal Tripod Artist Easel with Bag, Height from 17" to 66", Extra Sturdy for Table-Top/ Floor Painting, Drawing, and Displaying, Black', 15, 85);

INSERT INTO review (uid, pid, date, rate, comment)
    VALUES
    (4, 1, '2024-02-05 08:30:00', 5, 'This item is awesome!'), 
    (5, 1, '2024-03-23 13:45:00', 4, 'Impressed with the quality and durability, but it arrived later than expected. '), 
    (6, 1, '2024-03-09 11:00:00', 3, 'It''s decent quality, but nothing extraordinary. '), 
    (7, 1, '2024-03-13 15:50:00', 1, 'Total disappointment. Product didn''t work at all. '), 
    (8, 1, '2024-03-17 09:15:00', 5, 'Highly recommend! Great product and excellent customer service. '), 
    (9, 1, '2024-03-23 16:25:00', 4, 'Happy with my purchase overall, but it arrived with a minor scratch. '), 
    (10, 1, '2024-03-01 10:00:00', 3, 'It''s okay. Does the job, but not exceptional. '),
    (5, 6, '2024-02-10 15:20:00', 2, 'The product didn''t meet my expectations. It feels cheaply made and broke after minimal use. '), 
    (5, 11, '2024-02-14 11:45:00', 5, 'Absolutely love it! Works perfectly and exceeded my expectations. '), 
    (5, 16, '2024-02-18 17:10:00', 3, 'It''s okay, nothing special. Does the job but not outstanding. '), 
    (5, 21, '2024-02-21 09:25:00', 1, 'Extremely disappointed. The item arrived damaged and customer service was unhelpful. '), 
    (5, 26, '2024-02-25 14:55:00', 4, 'Good value for money. It serves its purpose well. '), 
    (5, 31, '2024-02-28 10:40:00', 3, 'Mixed feelings about this product. It has some good features but also some drawbacks. '), 
    (5, 36, '2024-03-03 12:15:00', 4, 'Pleased with the overall performance, but the packaging was a bit excessive. '), 
    (5, 41, '2024-03-07 16:30:00', 2, 'Not what I expected. It''s flimsy and doesn''t seem very durable. '), 
    (5, 46, '2024-03-11 08:50:00', 5, 'Couldn''t be happier with my purchase! Exactly what I needed. '), 
    (5, 51, '2024-03-14 13:25:00', 3, 'It''s decent, but I''ve seen better quality for the same price. '), 
    (5, 56, '2024-03-18 18:00:00', 1, 'Terrible experience. The product arrived broken and I never received a refund. '), 
    (5, 61, '2024-03-22 11:20:00', 4, 'Impressed with the functionality, but the instructions were a bit unclear. '), 
    (5, 66, '2024-02-03 07:40:00', 3, 'Average product. Does its job, but nothing extraordinary. '), 
    (5, 71, '2024-02-08 09:55:00', 5, 'Exceeded my expectations! Works like a charm. '), 
    (5, 2, '2024-02-12 16:05:00', 2, 'Disappointed with the performance. It stopped working after a few uses.  '), 
    (6, 2, '2024-02-16 14:30:00', 4, 'Good value for the price. It''s sturdy and reliable. '), 
    (7, 2, '2024-02-20 10:10:00', 3, 'It''s okay, but I wish it had more features. '), 
    (5, 3, '2024-02-24 12:45:00', 1, 'Waste of money. Broke immediately after I started using it. '), 
    (6, 3, '2024-02-29 17:15:00', 5, 'Absolutely fantastic! Couldn''t ask for anything better. '), 
    (7, 3, '2024-03-02 08:20:00', 4, 'Satisfied with the purchase, although delivery took longer than expected. '), 
    (8, 3, '2024-03-06 13:35:00', 2, 'Not impressed. The product feels cheaply made. '); 

INSERT INTO watchList (uid, pid, threshold)
    VALUES 
    (4, 1, 18.00), 
    (5, 1, 18.00), 
    (6, 1, 18.00), 
    (7, 1, 18.00), 
    (8, 1, 18.00), 
    (9, 1, 18.00), 
    (10, 1, 18.00);

INSERT INTO priceHistory (pid, date, price) 
    VALUES 
    (1, '2024-02-01 00:00:00', 19.98), 
    (2, '2024-02-01 00:00:00', 7.97), 
    (3, '2024-02-01 00:00:00', 22.99), 
    (4, '2024-02-01 00:00:00', 49.99), 
    (5, '2024-02-01 00:00:00', 199.00), 
    (6, '2024-02-01 00:00:00', 16.62), 
    (7, '2024-02-01 00:00:00', 30.99), 
    (8, '2024-02-01 00:00:00', 60.95), 
    (9, '2024-02-01 00:00:00', 13.99), 
    (10, '2024-02-01 00:00:00', 18.89), 
    (11, '2024-02-01 00:00:00', 31.99), 
    (12, '2024-02-01 00:00:00', 6.82), 
    (13, '2024-02-01 00:00:00', 69.99), 
    (14, '2024-02-01 00:00:00', 8.79), 
    (15, '2024-02-01 00:00:00', 9.99), 
    (16, '2024-02-01 00:00:00', 32.30), 
    (17, '2024-02-01 00:00:00', 52.98), 
    (18, '2024-02-01 00:00:00', 11.30), 
    (19, '2024-02-01 00:00:00', 76.23), 
    (20, '2024-02-01 00:00:00', 9.75), 
    (21, '2024-02-01 00:00:00', 4.00), 
    (22, '2024-02-01 00:00:00', 9.99), 
    (23, '2024-02-01 00:00:00', 9.99),
    (24, '2024-02-01 00:00:00', 11.99), 
    (25, '2024-02-01 00:00:00', 7.94),
    (26, '2024-02-01 00:00:00', 12.49), 
    (27, '2024-02-01 00:00:00', 23.99),
    (28, '2024-02-01 00:00:00', 21.99), 
    (29, '2024-02-01 00:00:00', 9.58),
    (30, '2024-02-01 00:00:00', 9.97), 
    (31, '2024-02-01 00:00:00', 14.99),
    (32, '2024-02-01 00:00:00', 7.98), 
    (33, '2024-02-01 00:00:00', 19.99),
    (34, '2024-02-01 00:00:00', 9.84), 
    (35, '2024-02-01 00:00:00', 7.95),
    (36, '2024-02-01 00:00:00', 2.99), 
    (37, '2024-02-01 00:00:00', 21.65),
    (38, '2024-02-01 00:00:00', 5.99), 
    (39, '2024-02-01 00:00:00', 3.99),
    (40, '2024-02-01 00:00:00', 4.99), 
    (41, '2024-02-01 00:00:00', 8.99),
    (42, '2024-02-01 00:00:00', 13.99), 
    (43, '2024-02-01 00:00:00', 5.99),
    (44, '2024-02-01 00:00:00', 20.99), 
    (45, '2024-02-01 00:00:00', 11.99),
    (46, '2024-02-01 00:00:00', 9.99), 
    (47, '2024-02-01 00:00:00', 10.99),
    (48, '2024-02-01 00:00:00', 5.99), 
    (49, '2024-02-01 00:00:00', 7.99),
    (50, '2024-02-01 00:00:00', 21.99),
    (51, '2024-02-01 00:00:00', 14.99),
    (52, '2024-02-01 00:00:00', 8.97),
    (53, '2024-02-01 00:00:00', 9.99),
    (54, '2024-02-01 00:00:00', 27.99),
    (55, '2024-02-01 00:00:00', 12.88),
    (56, '2024-02-01 00:00:00', 12.99),
    (57, '2024-02-01 00:00:00', 9.99),
    (58, '2024-02-01 00:00:00', 12.99),
    (59, '2024-02-01 00:00:00', 5.84),
    (60, '2024-02-01 00:00:00', 8.79),
    (61, '2024-02-01 00:00:00', 54.79),
    (62, '2024-02-01 00:00:00', 55.99),
    (63, '2024-02-01 00:00:00', 37.59),
    (64, '2024-02-01 00:00:00', 18.99),
    (65, '2024-02-01 00:00:00', 42.99),
    (66, '2024-02-01 00:00:00', 36.19),
    (67, '2024-02-01 00:00:00', 11.99),
    (68, '2024-02-01 00:00:00', 5.49),
    (69, '2024-02-01 00:00:00', 33.87),
    (70, '2024-02-01 00:00:00', 27.99),
    (71, '2024-02-01 00:00:00', 6.99),
    (72, '2024-02-01 00:00:00', 13.59),
    (73, '2024-02-01 00:00:00', 14.95),
    (74, '2024-02-01 00:00:00', 7.99),
    (75, '2024-02-01 00:00:00', 17.81), 
    (1, '2024-02-03 10:15:00', 17.50), 
    (1, '2024-02-06 12:30:00', 21.20), 
    (1, '2024-02-09 09:45:00', 18.75), 
    (1, '2024-02-12 14:20:00', 20.90), 
    (1, '2024-02-15 11:05:00', 19.30), 
    (1, '2024-02-18 16:40:00', 22.15), 
    (1, '2024-02-21 08:55:00', 18.90), 
    (1, '2024-02-24 13:25:00', 21.75), 
    (1, '2024-02-27 15:50:00', 19.98), 
    (1, '2024-03-01 10:00:00', 17.60), 
    (1, '2024-03-03 10:00:00', 19.98); 

INSERT INTO  visitHistory (uid, pid, date)
    VALUES 
    (7, 32, '2024-02-05'),
    (8, 51, '2024-02-10'),
    (6, 19, '2024-02-15'),
    (9, 68, '2024-02-20'),
    (5, 45, '2024-02-25'),
    (10, 3, '2024-03-02'),
    (4, 60, '2024-03-07'),
    (8, 12, '2024-03-12'),
    (6, 72, '2024-03-17'),
    (7, 27, '2024-03-22'),
    (9, 24, '2024-02-03'),
    (6, 62, '2024-02-08'),
    (5, 11, '2024-02-13'),
    (8, 37, '2024-02-18'),
    (7, 70, '2024-02-23'),
    (10, 5, '2024-02-28'),
    (4, 56, '2024-03-04'),
    (9, 20, '2024-03-09'),
    (6, 43, '2024-03-14'),
    (5, 72, '2024-03-19'),
    (8, 8, '2024-02-02'),
    (7, 48, '2024-02-07'),
    (10, 15, '2024-02-12'),
    (4, 36, '2024-02-17'),
    (9, 68, '2024-02-22'),
    (6, 2, '2024-02-27'),
    (5, 53, '2024-03-03'),
    (8, 29, '2024-03-08'),
    (7, 64, '2024-03-13'),
    (10, 18, '2024-03-18'),
    (4, 9, '2024-02-01'),
    (9, 42, '2024-02-06'),
    (6, 75, '2024-02-11'),
    (5, 25, '2024-02-16'),
    (8, 57, '2024-02-21'),
    (7, 14, '2024-02-26'),
    (10, 31, '2024-03-02'),
    (4, 69, '2024-03-07'),
    (9, 38, '2024-03-12'),
    (6, 4, '2024-03-17'),
    (5, 55, '2024-03-22'),
    (8, 23, '2024-02-05'),
    (7, 46, '2024-02-10'),
    (10, 10, '2024-02-15'),
    (4, 35, '2024-02-20'),
    (9, 71, '2024-02-25'),
    (6, 19, '2024-03-01'),
    (5, 62, '2024-03-06'),
    (8, 27, '2024-03-11'),
    (7, 54, '2024-03-16'),
    (10, 29, '2024-03-21'),
    (4, 12, '2024-02-04'),
    (9, 63, '2024-02-09'),
    (6, 8, '2024-02-14'),
    (5, 49, '2024-02-19'),
    (8, 16, '2024-02-24'),
    (7, 41, '2024-02-29'),
    (10, 75, '2024-03-05'),
    (4, 22, '2024-03-10'),
    (9, 67, '2024-03-15'),
    (6, 1, '2024-03-20'),
    (5, 58, '2024-02-01'),
    (8, 26, '2024-02-06'),
    (7, 50, '2024-02-11'),
    (10, 7, '2024-02-16'),
    (4, 40, '2024-02-21'),
    (9, 69, '2024-02-26'),
    (6, 15, '2024-03-02'),
    (5, 33, '2024-03-07'),
    (8, 60, '2024-03-12'),
    (7, 18, '2024-03-17'),
    (10, 52, '2024-03-22'),
    (4, 4, '2024-02-03'),
    (9, 47, '2024-02-08'),
    (6, 66, '2024-02-13'),
    (5, 14, '2024-02-18'),
    (8, 44, '2024-02-23'),
    (7, 73, '2024-02-28'),
    (10, 30, '2024-03-04'),
    (4, 3, '2024-03-09'),
    (9, 61, '2024-03-14'),
    (6, 21, '2024-03-19'),
    (5, 59, '2024-02-02'),
    (8, 28, '2024-02-07'),
    (7, 53, '2024-02-12'),
    (10, 9, '2024-02-17'),
    (4, 39, '2024-02-22'),
    (9, 70, '2024-02-27'),
    (6, 16, '2024-03-03'),
    (5, 34, '2024-03-08'),
    (8, 63, '2024-03-13'),
    (7, 19, '2024-03-18'),
    (10, 51, '2024-03-23'),
    (4, 6, '2024-02-05'),
    (9, 46, '2024-02-10'),
    (6, 65, '2024-02-15'),
    (5, 13, '2024-02-20'),
    (8, 43, '2024-02-25'),
    (7, 72, '2024-03-01'),
    (10, 28, '2024-03-06'),
    (4, 2, '2024-03-11'),
    (9, 60, '2024-03-16'),
    (6, 20, '2024-03-21'),
    (5, 57, '2024-02-02'),
    (8, 25, '2024-02-07'), 
    (6, 1, '2024-02-03'),
    (9, 1, '2024-02-08'),
    (7, 1, '2024-02-13'),
    (5, 1, '2024-02-18'),
    (10, 1, '2024-02-23'),
    (4, 1, '2024-02-28'),
    (8, 1, '2024-03-04'),
    (6, 1, '2024-03-09'),
    (9, 1, '2024-03-14'),
    (7, 1, '2024-03-19'),
    (5, 1, '2024-03-24'),
    (10, 1, '2024-02-04'),
    (4, 1, '2024-02-09'),
    (8, 1, '2024-02-14'),
    (6, 1, '2024-02-19'),
    (9, 1, '2024-02-24'),
    (7, 1, '2024-02-29'),
    (5, 1, '2024-03-05'),
    (10, 1, '2024-03-10'),
    (4, 1, '2024-03-15'),
    (8, 1, '2024-03-20'),
    (6, 1, '2024-02-01'),
    (9, 1, '2024-02-06'),
    (7, 1, '2024-02-11'),
    (5, 1, '2024-02-16'),
    (10, 1, '2024-02-21'),
    (4, 1, '2024-02-26'),
    (8, 1, '2024-03-02'),
    (6, 1, '2024-03-07'),
    (9, 1, '2024-03-12');

