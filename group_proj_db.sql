drop database grp_proj;
create database grp_proj;
use grp_proj;
CREATE TABLE candidates-- --------------------------------------------
(
    ph_no BIGINT primary key,
    email varchar(50),
    exp varchar(100),
    name varchar(50) not null,
    addr varchar(50) not null,
    CHECK (ph_no BETWEEN 1000000000 AND 9999999999)
);

-- 0 for not selected in that round and 1 for selected
CREATE TABLE media_Table (
    link VARCHAR(255),-- primary key cuz link is unique
    ph_no bigint,-- to see who uploaded
    type enum('audio','video'),-- audio or video
    PRIMARY KEY (link),
    FOREIGN KEY (ph_no) REFERENCES candidates(ph_no)
);
CREATE TABLE channels (
    channel_id INT PRIMARY KEY,
    name VARCHAR(50)
);
CREATE TABLE submission (
    ph_no BIGINT primary key,
    round1 enum('0','1'),
    round2 enum('0','1'),
    channel_id INT,
    
    FOREIGN KEY (ph_no) REFERENCES candidates(ph_no),
    FOREIGN KEY (channel_id) REFERENCES channels(channel_id)
);

CREATE TABLE grps (
    gp_id INT PRIMARY KEY,
    genre VARCHAR(50),
    director_id BIGINT,
    FOREIGN KEY (director_id) REFERENCES candidates(ph_no)
);

CREATE TABLE selected_for_grps (
    ph_no BIGINT ,
    gp_id INT,
    primary key (ph_no,gp_id),
    FOREIGN KEY (ph_no) REFERENCES submission(ph_no),
    FOREIGN KEY (gp_id) REFERENCES grps(gp_id)
);
CREATE TABLE panel (
    ph_no BIGINT primary key,
    name VARCHAR(50),
    experience VARCHAR(100),
    association VARCHAR(100)
);

CREATE TABLE album (
    al_id INT PRIMARY KEY,
    price DECIMAL(10, 2),
    album_type enum("audio","video"),
    gp_id INT,
    
    album_name VARCHAR(50),
    trailer_link VARCHAR(50),
    release_date date,
    like_count INT,
    dislike_count INT,
    visits INT,
    
    FOREIGN KEY (gp_id) REFERENCES grps(gp_id)
);
CREATE TABLE distributor (
    db_id INT PRIMARY KEY,
    buy_price DECIMAL(10, 2),
    sell_price DECIMAL(10, 2)
);
CREATE TABLE download (
    download_id INT PRIMARY KEY,
    incoming_url VARCHAR(255),
    al_id INT,
    date DATE,
    download_status enum("success","failure"),
    FOREIGN KEY (al_id) REFERENCES album(al_id)
);

CREATE TABLE incoming_url_map (
    incoming_url VARCHAR(255) PRIMARY KEY,
    al_id INT,
    db_id INT,
    download_count INT,
    FOREIGN KEY (al_id) REFERENCES album(al_id),
    FOREIGN KEY (db_id) REFERENCES distributor(db_id)
);

CREATE TABLE alt_nos (-- ------------------------------
    alt_no BIGINT primary key,
    ph_no BIGINT,
    FOREIGN KEY (ph_no) REFERENCES candidates(ph_no),
    CHECK (alt_no BETWEEN 1000000000 AND 9999999999)
);



-- Populate Candidates
INSERT INTO candidates (ph_no, email, exp, name, addr)
VALUES
  (9876543210, 'john.doe@example.com', '3 years', 'John Doe', 'Mumbai'),
  (8765432109, 'jane.smith@example.com', '2 years', 'Jane Smith', 'Delhi'),
  (7654321098, 'sam.jones@example.com', '5 years', 'Sam Jones', 'Bangalore'),
  (6543210987, 'priya.sharma@example.com', '4 years', 'Priya Sharma', 'Chennai'),
  (5432109876, 'rahul.verma@example.com', '1 year', 'Rahul Verma', 'Kolkata'),
  (4567890123, 'alex.white@example.com', '2 years', 'Alex White', 'Pune'),
  (3456789012, 'emily.jones@example.com', '3 years', 'Emily Jones', 'Hyderabad'),
  (2345678901, 'michael.clark@example.com', '1 year', 'Michael Clark', 'Ahmedabad'),
  (1234567890, 'sara.khan@example.com', '4 years', 'Sara Khan', 'Jaipur'),
  (2345678902, 'kunal.shah@example.com', '2 years', 'Kunal Shah', 'Lucknow'),
  (3456789123, 'adam.smith@example.com', '3 years', 'Adam Smith', 'New York'),
  (4567891234, 'lisa.johnson@example.com', '2 years', 'Lisa Johnson', 'Los Angeles'),
  (5678912345, 'kevin.miller@example.com', '4 years', 'Kevin Miller', 'Chicago'),
  (6789123456, 'emma.davis@example.com', '5 years', 'Emma Davis', 'Houston'),
  (7891234567, 'ryan.wilson@example.com', '1 year', 'Ryan Wilson', 'Philadelphia'),
  (8912345678, 'sophia.brown@example.com', '3 years', 'Sophia Brown', 'Phoenix'),
  (9123456789, 'jacob.moore@example.com', '2 years', 'Jacob Moore', 'San Antonio'),
  (9876543211, 'olivia.taylor@example.com', '4 years', 'Olivia Taylor', 'San Diego'),
  (8765432100, 'ethan.jackson@example.com', '1 year', 'Ethan Jackson', 'Dallas'),
  (7654321090, 'ava.thomas@example.com', '2 years', 'Ava Thomas', 'San Jose'),
  (6543210980, 'noah.hill@example.com', '3 years', 'Noah Hill', 'Austin'),
  (5432109870, 'mia.anderson@example.com', '4 years', 'Mia Anderson', 'Jacksonville'),
  (4321098765, 'william.white@example.com', '1 year', 'William White', 'San Francisco'),
  (3210987654, 'emily.taylor@example.com', '2 years', 'Emily Taylor', 'Indianapolis'),
  (2109876543, 'james.moore@example.com', '3 years', 'James Moore', 'Columbus'),
  (1098765432, 'emma.johnson@example.com', '4 years', 'Emma Johnson', 'Fort Worth'),
  (9988776655, 'lucas.martin@example.com', '2 years', 'Lucas Martin', 'Charlotte'),
  (8877665544, 'mia.thompson@example.com', '3 years', 'Mia Thompson', 'Detroit'),
  (7766554433, 'oliver.lewis@example.com', '1 year', 'Oliver Lewis', 'El Paso');

-- Populate Media Table with Multiple Entries for Some Candidates
INSERT INTO media_Table (link, ph_no, type)
VALUES	
  ('audio_link_1', 9876543210, 'audio'),
  ('video_link_6', 9876543210, 'video'),
  ('video_link_2', 8765432109, 'video'),
  ('audio_link_3', 7654321098, 'audio'),
  ('video_link_4', 6543210987, 'video'),
  ('audio_link_5', 5432109876, 'audio'),
  ('audio_link_7', 5432109876, 'audio'),
  ('audio_link_8', 4567890123, 'audio'),
  ('video_link_9', 4567890123, 'video'),
  ('audio_link_10', 3456789012, 'audio'),
  ('audio_link_11', 3456789012, 'audio'),
  ('video_link_12', 2345678901, 'video'),
  ('audio_link_13', 1234567890, 'audio'),
  ('video_link_14', 2345678902, 'video'),
  ('audio_link_15', 3456789123, 'audio'),
  ('video_link_16', 4567891234, 'video'),
  ('audio_link_17', 5678912345, 'audio'),
  ('video_link_18', 6789123456, 'video'),
  ('audio_link_19', 7891234567, 'audio'),
  ('video_link_20', 8912345678, 'video'),
  ('audio_link_21', 9123456789, 'audio'),
  ('video_link_22', 9876543211, 'video'),
  ('audio_link_23', 8765432100, 'audio'),
  ('video_link_24', 7654321090, 'video'),
  ('audio_link_25', 6543210980, 'audio'),
  ('video_link_26', 5432109870, 'video'),
  ('audio_link_27', 4321098765, 'audio'),
  ('video_link_28', 3210987654, 'video'),
  ('audio_link_29', 2109876543, 'audio'),
  ('video_link_30', 1098765432, 'video'),
  ('audio_link_31', 9988776655, 'audio'),
  ('video_link_32', 8877665544, 'video'),
  ('audio_link_33', 7766554433, 'audio');

-- Populate Channels
INSERT INTO channels (channel_id, name)
VALUES
  (1, 'Print Media'),
  (2, 'Digital Media'),
  (3, 'Television'),
  (4, 'Radio');

-- Populate Submission with Half Elimination in Each Round
INSERT INTO submission (ph_no, round1, round2, channel_id)
VALUES
  (9876543210, '1', '1', 1),
  (8765432109, '1', '1', 2),
  (7654321098, '1', '1', 3),
  (6543210987, '1', '1', 4),
  (5432109876, '1', '1', 1),
  (4567890123, '1', '0', 2),
  (3456789012, '1', '1', 3),
  (2345678901, '1', '0', 4),
  (1234567890, '1', '1', 1),
  (2345678902, '1', '1', 2),
  (3456789123, '0', '0', 3),
  (4567891234, '1', '1', 4),
  (5678912345, '1', '1', 1),
  (6789123456, '1', '1', 2),
  (7891234567, '1', '1', 3),
  (8912345678, '0', '0', 4),
  (9123456789, '0', '0', 1),
  (9876543211, '0', '0', 2),
  (8765432100, '0', '0', 3),
  (7654321090, '0', '0', 4),
  (6543210980, '0', '0', 1),
  (5432109870, '0', '0', 2),
  (4321098765, '1', '0', 3),
  (3210987654, '1', '0', 4),
  (2109876543, '1', '0', 1),
  (1098765432, '1', '0', 2),
  (9988776655, '1', '0', 3),
  (8877665544, '1', '0', 4),
  (7766554433, '1', '0', 1);



INSERT INTO grps (gp_id, genre, director_id)
VALUES
  (1, 'Pop', 7654321098),
  (2, 'Classic', 2345678902),
  (3, 'Leisure', 5432109876),
  (4, 'Evergreen', 4567891234),
  (5, 'Rock', 1234567890),
  (6, 'Jazz', 3456789012),
  (7, 'Country', 8765432109),
  (8, 'R&B', 5678912345),
  (9, 'Hip Hop', 6789123456),
  (10, 'Reggae', 6543210987);

-- Populate Selected for Groups with Random Members
INSERT INTO selected_for_grps (ph_no, gp_id)
VALUES
  (7654321098, 1),
  (2345678902, 2),
  (5432109876, 3),
  (5432109876, 4),
  (4567891234, 4),
  (1234567890, 5),
  (3456789012, 6),
  (8765432109, 7),
  (7891234567, 3),
  (5678912345, 8),
  (6789123456, 9),
  (9876543210, 1),
  (9876543210, 2),
  (6543210987, 10);


-- Populate Panel with Random Members
INSERT INTO panel (ph_no, name, experience, association)
VALUES
  (1111111111, 'Panelist 1', '10 years', 'Music Industry Association'),
  (2222222222, 'Panelist 2', '8 years', 'Music Critics Association'),
  (3333333333, 'Panelist 3', '12 years', 'McM Company'),
  (4444444444, 'Panelist 4', '5 years', 'Music Academy'),
  (5555555555, 'Panelist 5', '7 years', 'Record Label');

-- Populate Album with Random Data
INSERT INTO album (al_id, price, album_type, gp_id, album_name, trailer_link, release_date, like_count, dislike_count, visits)
VALUES
  (1, 199.99, 'audio', 1, 'Pop Sensation', 'pop_trailer_link', '2020-03-01', 1000, 50, 5000),
  (2, 249.99, 'video', 2, 'Classic Harmony', 'classic_trailer_link', '2020-03-15', 1200, 30, 6000),
  (3, 179.99, 'audio', 3, 'Leisure Groove', 'leisure_trailer_link', '2024-04-01', 800, 20, 4000),
  (4, 299.99, 'video', 3, 'Evergreen Beats', 'evergreen_trailer_link', '2024-04-15', 1500, 70, 7000),
  (5, 209.99, 'audio', 5, 'Rock Fusion', 'rock_trailer_link', '2024-05-01', 1100, 40, 5500),
  (6, 189.99, 'video', 6, 'Jazz Groove', 'jazz_trailer_link', '2024-05-15', 900, 60, 6500),
  (7, 219.99, 'audio', 7, 'Country Melodies', 'country_trailer_link', '2024-06-01', 1300, 35, 7500),
  (8, 259.99, 'video', 8, 'R&B Sensation', 'rnb_trailer_link', '2024-06-15', 1400, 45, 8000),
  (9, 169.99, 'audio', 9, 'Hip Hop Beats', 'hiphop_trailer_link', '2024-07-01', 950, 25, 6000),
  (10, 289.99, 'video', 10, 'Reggae Vibes', 'reggae_trailer_link', '2024-07-15', 1600, 55, 8500);

-- Populate Distributor with Random Data
INSERT INTO distributor (db_id, buy_price, sell_price)
VALUES
  (1, 150.00, 199.99),
  (2, 180.00, 249.99),
  (3, 130.00, 179.99),
  (4, 250.00, 299.99),
  (5, 190.00, 209.99),
  (6, 170.00, 189.99),
  (7, 200.00, 219.99),
  (8, 230.00, 259.99),
  (9, 160.00, 169.99),
  (10, 270.00, 289.99);

-- Populate Download with Random Data
INSERT INTO download (download_id, incoming_url, al_id, date, download_status)
VALUES
  (1, 'download_url_1', 1, '2024-05-02', 'success'),
  (2, 'download_url_2', 2, '2024-05-03', 'success'),
  (3, 'download_url_3', 3, '2024-05-04', 'failure'),
  (4, 'download_url_4', 4, '2024-05-05', 'success'),
  (5, 'download_url_5', 5, '2024-05-06', 'success'),
  (6, 'download_url_6', 6, '2024-05-07', 'success'),
  (7, 'download_url_7', 7, '2024-05-08', 'failure'),
  (8, 'download_url_8', 8, '2024-05-09', 'success'),
  (9, 'download_url_9', 9, '2024-05-10', 'success'),
  (10, 'download_url_10', 10, '2024-05-11', 'success');

-- Populate Incoming URL Map with Random Data
INSERT INTO incoming_url_map (incoming_url, al_id, db_id, download_count)
VALUES
  ('download_url_1', 1, 1, 500),
  ('download_url_2', 2, 2, 600),
  ('download_url_3', 3, 3, 400),
  ('download_url_4', 4, 4, 700),
  ('download_url_5', 5, 5, 800),
  ('download_url_6', 6, 6, 550),
  ('download_url_7', 7, 7, 350),
  ('download_url_8', 8, 8, 750),
  ('download_url_9', 9, 9, 850),
  ('download_url_10', 10, 10, 900);

-- Populate Alternative Numbers with Random Data
INSERT INTO alt_nos (alt_no, ph_no)
VALUES
  (9999999999, 9876543210),
  (8888888888, 8765432109),
  (7777777777, 7654321098),
  (6666666666, 6543210987),
  (5555555555, 5432109876),
  (4444444444, 4567890123),
  (3333333333, 3456789012),
  (2222222222, 2345678901),
  (1111111111, 1234567890),
  (2222222223, 2345678902),
  (3333333334, 3456789123),
  (4444444445, 4567891234),
  (5555555556, 5678912345),
  (6666666667, 6789123456),
  (7777777778, 7891234567),
  (8888888889, 8912345678),
  (9999999990, 9123456789),
  (1234567891, 9876543211),
  (2345678903, 8765432100),
  (3456789013, 7654321090),
  (4567890124, 6543210980),
  (5678912346, 5432109870),
  (6789123457, 4321098765),
  (7891234568, 3210987654),
  (8912345679, 2109876543),
  (9123456780, 1098765432),
  (9988776656, 9988776655),
  (8877665545, 8877665544),
  (7766554434, 7766554433);



-- QUERIES --------------------------------------------------------------------
  
SELECT c.name
FROM candidates c
INNER JOIN selected_for_grps sfg ON c.ph_no = sfg.ph_no
GROUP BY c.ph_no
HAVING COUNT(sfg.gp_id) > 1;
  
  
select album_name from album 
where album_type="audio" and year(release_date)="2020";
  


SELECT c.name
FROM candidates c
INNER JOIN selected_for_grps sfg ON c.ph_no = sfg.ph_no
INNER JOIN grps g ON sfg.gp_id = g.gp_id
WHERE g.genre = 'Pop'
AND c.ph_no NOT IN (SELECT ph_no FROM selected_for_grps WHERE gp_id <> g.gp_id);


SELECT c.name
FROM candidates c
JOIN media_Table m ON c.ph_no = m.ph_no
GROUP BY c.ph_no
HAVING COUNT(DISTINCT m.type) > 1;



SELECT ch.name AS channel_name, COUNT(s.ph_no) AS submission_count
FROM channels ch
LEFT JOIN submission s ON ch.channel_id = s.channel_id
GROUP BY ch.name
ORDER BY submission_count DESC
LIMIT 1;