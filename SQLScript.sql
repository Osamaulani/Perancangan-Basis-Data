-- KELOMPOK 2 DS-45-03--
-- Widha Dwiyanti (1305213019) & Osa Nastiar Maulani (1305210055) --

--DDL
CREATE SCHEMA `airport_management` ;

CREATE TABLE `airport_management`.`pegawai` (
  `idpegawai` INT UNSIGNED NOT NULL,
  `namapegawai` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpegawai`),
  UNIQUE INDEX `idpegawai_UNIQUE` (`idpegawai` ASC) VISIBLE);

ALTER TABLE `airport_management`.`pegawai` 
CHANGE COLUMN `idpegawai` `idpegawai` VARCHAR(45) NOT NULL ;

CREATE TABLE `airport_management`.`jenis_maskapai` (
  `IDpesawat` INT UNSIGNED NOT NULL,
  `nama_maskapai` VARCHAR(45) NOT NULL,
  `tipe_pesawat` VARCHAR(45) NOT NULL,
  `IDpegawai` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDpesawat`),
  UNIQUE INDEX `idpesawat_UNIQUE` (`IDpesawat` ASC) VISIBLE);

CREATE TABLE `airport_management`.`jenis_maskapai` (
  `IDpesawat` INT UNSIGNED NOT NULL,
  `nama_maskapai` VARCHAR(45) NOT NULL,
  `tipe_pesawat` VARCHAR(45) NOT NULL,
  `IDpegawai` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDpesawat`),
  UNIQUE INDEX `idpesawat_UNIQUE` (`IDpesawat` ASC) VISIBLE);

CREATE TABLE `airport_management`.`penumpang` (
  `IDticket_penumpang` VARCHAR(45) NOT NULL,
  `nama_penumpang` VARCHAR(45) NOT NULL,
  `umur_penumpang` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`IDticket_penumpang`),
  UNIQUE INDEX `IDticket_penumpang_UNIQUE` (`IDticket_penumpang` ASC) VISIBLE);

ALTER TABLE `airport_management`.`jenis_maskapai` 
ADD COLUMN `IDticket_penumpang` VARCHAR(45) NOT NULL AFTER `IDpegawai`;

ALTER TABLE `airport_management`.`jenis_maskapai` 
ADD INDEX `fk_penumpang_to_jenismaskapai_idx` (`IDticket_penumpang` ASC) VISIBLE;
;
ALTER TABLE `airport_management`.`jenis_maskapai` 
ADD CONSTRAINT `fk_penumpang_to_jenismaskapai`
  FOREIGN KEY (`IDticket_penumpang`)
  REFERENCES `airport_management`.`penumpang` (`IDticket_penumpang`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `airport_management`.`wifi` (
  `IDwifi` INT UNSIGNED NOT NULL,
  `nama_jaringan` VARCHAR(45) NOT NULL,
  `kecepatan_wifi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDwifi`),
  UNIQUE INDEX `IDwifi_UNIQUE` (`IDwifi` ASC) VISIBLE);

CREATE TABLE `airport_management`.`ruang_tunggu` (
  `IDruang_tunggu` INT NOT NULL,
  `IDticket_penumpang` VARCHAR(45) NOT NULL,
  `IDwifi` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDruang_tunggu`));

ALTER TABLE `airport_management`.`wifi` 
CHANGE COLUMN `IDwifi` `IDwifi` VARCHAR(45) NOT NULL ;

ALTER TABLE `airport_management`.`ruang_tunggu` 
CHANGE COLUMN `IDruang_tunggu` `IDruang_tunggu` VARCHAR(45) NOT NULL ;

ALTER TABLE `airport_management`.`ruang_tunggu` 
ADD INDEX `fk_penumpang_to_ruangtunggu_idx` (`IDticket_penumpang` ASC) VISIBLE,
ADD INDEX `fk_wifi_to_ruangtunggu_idx` (`IDwifi` ASC) VISIBLE;
;
ALTER TABLE `airport_management`.`ruang_tunggu` 
ADD CONSTRAINT `fk_penumpang_to_ruangtunggu`
  FOREIGN KEY (`IDticket_penumpang`)
  REFERENCES `airport_management`.`penumpang` (`IDticket_penumpang`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_wifi_to_ruangtunggu`
  FOREIGN KEY (`IDwifi`)
  REFERENCES `airport_management`.`wifi` (`IDwifi`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `airport_management`.`jadwal_penerbangan` (
  `IDpenerbangan` VARCHAR(45) NOT NULL,
  `tanggal_penerbagan` DATE NOT NULL,
  `IDpesawat` VARCHAR(45) NOT NULL,
  `IDpenumpang` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDpenerbangan`),
  UNIQUE INDEX `IDpenerbangan_UNIQUE` (`IDpenerbangan` ASC) VISIBLE);

ALTER TABLE `airport_management`.`jenis_maskapai` 
CHANGE COLUMN `IDpesawat` `IDpesawat` VARCHAR(45) NOT NULL ;

ALTER TABLE `airport_management`.`jadwal_penerbangan` 
ADD INDEX `fk_pesawat_jadwalpenerbangan_idx` (`IDpesawat` ASC) VISIBLE,
ADD INDEX `fk_penumpang_to_jadwalpenerbangan_idx` (`IDpenumpang` ASC) VISIBLE;
;

ALTER TABLE `airport_management`.`jadwal_penerbangan` 
ADD CONSTRAINT `fk_pesawat_jadwalpenerbangan`
  FOREIGN KEY (`IDpesawat`)
  REFERENCES `airport_management`.`jenis_maskapai` (`IDpesawat`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,

ADD CONSTRAINT `fk_penumpang_to_jadwalpenerbangan`
  FOREIGN KEY (`IDpenumpang`)
  REFERENCES `airport_management`.`penumpang` (`IDticket_penumpang`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `airport_management`.`landasan_pacu` (
  `IDlandasan_pacu` VARCHAR(45) NOT NULL,
  `IDpenerbangan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDlandasan_pacu`),
  UNIQUE INDEX `IDlandasan_pacu_UNIQUE` (`IDlandasan_pacu` ASC) VISIBLE);

ALTER TABLE `airport_management`.`landasan_pacu` 
ADD INDEX `fk_penerbangan_to_landasanpacu_idx` (`IDpenerbangan` ASC) VISIBLE;
;
ALTER TABLE `airport_management`.`landasan_pacu` 
ADD CONSTRAINT `fk_penerbangan_to_landasanpacu`
  FOREIGN KEY (`IDpenerbangan`)
  REFERENCES `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `airport_management`.`pramugara` (
  `IDpegawai` VARCHAR(45) NOT NULL,
  `jamkerja` VARCHAR(45) NOT NULL,
  `gaji` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDpegawai`),
  UNIQUE INDEX `IDpramugara_UNIQUE` (`IDpegawai` ASC) VISIBLE);

ALTER TABLE `airport_management`.`pramugara` 
ADD CONSTRAINT `fk_pegawai_to_pramugara`
  FOREIGN KEY (`IDpegawai`)
  REFERENCES `airport_management`.`pegawai` (`idpegawai`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `airport_management`.`pramugari` (
  `IDpegawai` INT NOT NULL,
  `gaji` INT UNSIGNED NOT NULL,
  `jamkerja` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IDpegawai`));

ALTER TABLE `airport_management`.`pramugari` 
CHANGE COLUMN `IDpegawai` `IDpegawai` VARCHAR(45) NOT NULL ;
ALTER TABLE `airport_management`.`pramugari` 
ADD CONSTRAINT `fk_pegawai_to_pramugari`
  FOREIGN KEY (`IDpegawai`)
  REFERENCES `airport_management`.`pegawai` (`idpegawai`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `airport_management`.`pegawai` 
CHANGE COLUMN `idpegawai` `IDpegawai` VARCHAR(45) NOT NULL ;

--DML 

INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1234', 'Jesse Kaivan', '21');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1235', 'Keiza Levronka', '22');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1112', 'Iram Athena', '19');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1211', 'Nada Anisa', '35');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1236', 'Rendi Alexander', '25');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1237', 'Kanisa Renanda', '40');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1238', 'Emily Rezatta', '20');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1239', 'Renatta Malik', '18');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1230', 'Eliza Emran', '26');
INSERT INTO `airport_management`.`penumpang` (`IDticket_penumpang`, `nama_penumpang`, `umur_penumpang`) VALUES ('IT1220', 'Oliver Swan', '27');

INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1234', 'Widha Dwiyanti ');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1235', 'Osa Nastiar ');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP1236', 'Imam Akbar');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP1237', 'Andi Roger');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1238', 'Thalia Gunawan');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP1239', 'Melvino Fatan');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP1230', 'Komar Adly');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1233', 'Latifa Firdaus');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1232', 'Egi Dhea');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP1231', 'Gavin Jovan');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW7896', 'Hasna Raihana');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW3005', 'Gabriella Diedra');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW1712', 'Kanaya Mevana');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW2002', 'Faradilla Chen');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GW2003', 'Tazkia Joana ');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP5676', 'Jefri Nicho');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP8978', 'Rizki Wira');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP0090', 'Alfredo Shein');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP0098', 'Daffa Iram ');
INSERT INTO `airport_management`.`pegawai` (`IDpegawai`, `namapegawai`) VALUES ('GP7666', 'Hafizh Alexa ');

ALTER TABLE `airport_management`.`pramugara` 
CHANGE COLUMN `gaji` `gaji` INT UNSIGNED NOT NULL ;

INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP1236', '5', '11000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP1237', '7', '13000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP1239', '4', '10000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP1230', '5', '11000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP1231', '8', '14000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP5676', '11', '17000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP8978', '9', '15000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP0090', '4', '10000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP0098', '5', '11000000');
INSERT INTO `airport_management`.`pramugara` (`IDpegawai`, `jamkerja`, `gaji`) VALUES ('GP7666', '6', '12000000');

INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1234', '12000000', '6');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1235', '12000000', '6');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1238', '10000000', '4');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1233', '11000000', '5');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1232', '13000000', '7');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW7896', '13000000', '7');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW3005', '14000000', '8');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW1712', '15000000', '9');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW2002', '11000000', '5');
INSERT INTO `airport_management`.`pramugari` (`IDpegawai`, `gaji`, `jamkerja`) VALUES ('GW2003', '18000000', '12');

ALTER TABLE `airport_management`.`jenis_maskapai` 
DROP FOREIGN KEY `fk_penumpang_to_jenismaskapai`;
ALTER TABLE `airport_management`.`jenis_maskapai` 
CHANGE COLUMN `IDticket_penumpang` `IDticket_penumpang` VARCHAR(45) NULL ;
ALTER TABLE `airport_management`.`jenis_maskapai` 
ADD CONSTRAINT `fk_penumpang_to_jenismaskapai`
  FOREIGN KEY (`IDticket_penumpang`)
  REFERENCES `airport_management`.`penumpang` (`IDticket_penumpang`);


INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('GI300523', 'Garuda Indonesia', 'Boeing737', 'GW1234', 'IT1234');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('QA130511', 'Qatar Airways', 'Boeing737', 'GW1235', 'IT1235');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('SA609089', 'Singapore Airlanes', 'Boeing777', 'GP1236', 'IT1112');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('EM569875', 'Emirates', 'AirbusA330', 'GP1237', 'IT1211');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('ET222890', 'Etihad Airways', 'AirbusA321', 'GW3005', 'IT1236');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('CT456789', 'Citilink', 'Boeing787', 'GW1712', 'IT1237');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('SJ674523', 'Super Air Jet', 'ATR72', 'GW2002', 'IT1238');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('AA980798', 'Air Asia', 'AirbusA330', 'GP0090', 'IT1239');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`, `IDticket_penumpang`) VALUES ('HA778899', 'Hainan Airlanes', 'Boeing777', 'GP0098', 'IT1230');
INSERT INTO `airport_management`.`jenis_maskapai` (`IDpesawat`, `nama_maskapai`, `tipe_pesawat`, `IDpegawai`) VALUES ('LA171202', 'Lion Air', 'AirbusA330', 'GP7666');

ALTER TABLE `airport_management`.`wifi` 
CHANGE COLUMN `kecepatan_wifi` `kecepatan_wifi` VARCHAR(45) NULL ;

INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('NT234000', 'Net', '5mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('FH900987', 'Fisrthost', '2mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('MN898211', 'Mynet', '10mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('IM877765', 'Indimedia', '2mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('IH200111', 'Indihome', '5mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('MT100222', 'Mytsel', '10mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('BY233345', 'Byu', '2mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('MA600657', 'Mediaalexa', '2mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`, `kecepatan_wifi`) VALUES ('RQ218789', 'Requel', '10mbps');
INSERT INTO `airport_management`.`wifi` (`IDwifi`, `nama_jaringan`) VALUES ('FM000999', 'Firstmedia');

ALTER TABLE `airport_management`.`ruang_tunggu` 
DROP FOREIGN KEY `fk_wifi_to_ruangtunggu`;
ALTER TABLE `airport_management`.`ruang_tunggu` 
CHANGE COLUMN `IDwifi` `IDwifi` VARCHAR(45) NULL ;
ALTER TABLE `airport_management`.`ruang_tunggu` 
ADD CONSTRAINT `fk_wifi_to_ruangtunggu`
  FOREIGN KEY (`IDwifi`)
  REFERENCES `airport_management`.`wifi` (`IDwifi`);

INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR123', 'IT1234', 'NT234000');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR124', 'IT1235', 'FH900987');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR125', 'IT1112', 'MN898211');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR126', 'IT1211', 'IM877765');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR127', 'IT1236', 'IH200111');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR128', 'IT1237', 'MT100222');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR129', 'IT1238', 'BY233345');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR130', 'IT1239', 'MA600657');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('IR131', 'IT1230', 'RQ218789');
INSERT INTO `airport_management`.`ruang_tunggu` (`IDruang_tunggu`, `IDticket_penumpang`, `IDwifi`) VALUES ('RI132', 'IT1220', 'FM000999');


ALTER TABLE `airport_management`.`jadwal_penerbangan` 
DROP FOREIGN KEY `fk_penumpang_to_jadwalpenerbangan`;
ALTER TABLE `airport_management`.`jadwal_penerbangan` 
CHANGE COLUMN `IDpenumpang` `IDpenumpang` VARCHAR(45) NULL ;
ALTER TABLE `airport_management`.`jadwal_penerbangan` 
ADD CONSTRAINT `fk_penumpang_to_jadwalpenerbangan`
  FOREIGN KEY (`IDpenumpang`)
  REFERENCES `airport_management`.`penumpang` (`IDticket_penumpang`);

ALTER TABLE `airport_management`.`jadwal_penerbangan` 
ADD UNIQUE INDEX `IDpesawat_UNIQUE` (`IDpesawat` ASC) VISIBLE;
;

INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('111GRI', '2022-12-18', 'GI300523', 'IT1234');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('211QTA', '2022-12-20', 'QA130511', 'IT1235');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('212SGA', '2022-12-21', 'SA609089', 'IT1112');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('908EMR', '2022-12-22', 'EM569875', 'IT1211');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('888ETA', '2022-12-23', 'ET222890', 'IT1236');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('655CTL', '2022-12-24', 'CT456789', 'IT1237');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('877SJA', '2022-12-25', 'SJ674523', 'IT1238');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('999AAA', '2022-12-26', 'AA890798', 'IT1239');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`, `IDpenumpang`) VALUES ('343HNA', '2022-12-27', 'HA778899', 'IT1230');
INSERT INTO `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`, `tanggal_penerbagan`, `IDpesawat`) VALUES ('777LNA', '2022-12-28', 'LA171202');

ALTER TABLE `airport_management`.`landasan_pacu` 
DROP FOREIGN KEY `fk_penerbangan_to_landasanpacu`;
ALTER TABLE `airport_management`.`landasan_pacu` 
CHANGE COLUMN `IDpenerbangan` `IDpenerbangan` VARCHAR(45) NULL ;
ALTER TABLE `airport_management`.`landasan_pacu` 
ADD CONSTRAINT `fk_penerbangan_to_landasanpacu`
  FOREIGN KEY (`IDpenerbangan`)
  REFERENCES `airport_management`.`jadwal_penerbangan` (`IDpenerbangan`);

INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1231', '111GRI');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1232', '211QTA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1233', '212SGA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1234', '908EMR');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1235', '888ETA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1236', '655CTL');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1237', '877SJA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1238', '999AAA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1239', '343HNA');
INSERT INTO `airport_management`.`landasan_pacu` (`IDlandasan_pacu`, `IDpenerbangan`) VALUES ('IL1240', '777LNA');



select * from jadwal_penerbangan;
select * from jenis_maskapai;
select * from penumpang;

select MAX(gaji) AS gaji_tertinggi_pramugara
from pramugara

select MIN(gaji) AS gaji_terendah_pramugari
from pramugari

select COUNT(*) AS jumlah_pegawai
from pegawai 

SELECT * FROM pramugara WHERE gaji <= (SELECT MAX(gaji) FROM pramugara)
SELECT * FROM pramugara WHERE jamkerja < (SELECT AVG(jamkerja) FROM pramugara)

select * from jadwal_penerbangan
inner join penumpang on jadwal_penerbangan.IDpenumpang=penumpang.IDticket_penumpang

select * from jenis_maskapai
inner join pegawai on jenis_maskapai.IDpegawai=pegawai.IDpegawai

--DCL

CREATE USER 'widha'@'%' IDENTIFIED BY '1305213019';
GRANT SELECT on airport_management.pegawai TO 'widha'@'%';
FLUSH PRIVILEGES;

REVOKE SELECT on airport_management.pegawai FROM 'widha'@'%';
FLUSH PRIVILEGES;