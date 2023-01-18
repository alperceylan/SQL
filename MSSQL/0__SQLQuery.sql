

----   Veri Tabanýmýzýn bir Kopyasýný vermek için :
--   Soldaki en üstteki 'Databases' klasörüne SAÐ Týklýyoruz ve oradan da 'Attach' butonuna týklýyoruz...

----   Bir DataBase açmak istiyorsak :
--   Soldaki en üstteki 'Databases' klasörüne SAÐ Týklýyoruz ve oradan da 'New Database' butonuna týklýyoruz.
-- Sonra da , açýlan pencerede 'Database name''yi giriyoruz. Ardýndan 'Database Files' ayarlarýný yapýyoruz.
-- Bu ayarlar da ; LOG dosyasý ve DATA dosyasýnýn büyüklüðü ile ilgili ayarlardýr...
--   SONRA da soldaki 'OPTIONS' butonuna týklýyoruz ve 'Recovery model' ayarýný yapýyoruz. Bu ayar LOG'larýn nasýl
-- tutulacaðýný ayarlýyor... Eðer biz her gün data manipülasyonu yapýyorsak her gece binlerce kaydý silip
-- güncelliyorsak bu ayarý 'FULL' tutmak daha mantýklý olabilir. 'Full' yaptýðýmýzda , LDF dosyamýzda , yani
-- Veri Tabanýnýn LOG dosyasýnda , bütün hareketlerimizin kaydý tutuluyor. Bunun handikapý da sunucumuzun limitleri
-- varsa , LDF dosyasý bazen o kadar çok yer kaplýyor ki sunucumuzda hata almamýza sebep olabiliyor...
-- Bir Data Scientist'in böyle bir þeye pek ihtiyacý olmuyor. Onun için 'SINGLE' olarak tutmak bizim için daha
-- mantýklýdýr...
--   'Compatibility level' ayarýný da ; çalýþtýðýmýz þirket hangi leveli kullanýyorsa aynýsýný yapmalýyýz...
--   Sonra da eðer istersek ve 'SCRIPT' butonuna basarsak Veri Tabanýmýzýn KOD DÝZÝSÝ oluþuyor.
--   Sonra da 'OK' butonuna týklayarak Veri Tabanýmýzý oluþturabiliyoruz...

----   KODLARI çalýþtýrmak için de :
--   Ya yukarýdaki 'Execute' butonuna týklamalýyýz veya 'F5' tuþuna basabiliriz , ya da CTRL + ENTER tuþlarýna
-- basabiliriz...
--   Çalýþtýrmak istediðimiz KODLARI seçerek , sadece o KODLARI 'Execute' edebiliriz...



--------------- Sunucudaki Veritabanlarýnýn Listelenmesi ---------------

--   'SELECT' : Hangi veri kaynaðýndan , Hangi Kolonlarý getireceðimizi gösterdiðimiz alana denir...
-- '*' iþareti de ; "o Tablodaki bütün alanlarý getir." demektir... Ama isteseydik , Kolon isimlerini virgül ile
-- ayýrarak , sadece istediðimiz Kolonlarý da getirtebilirdik... :

--   'FROM' : Hangi Tablodan okuduðumuzu gösteriyor... :

SELECT * FROM sys.databases; 



--------------- Veritabanlarýnýn Dosyalarý ve Lokasyonlarý ---------------

--   Pembe renki KODLAR , Fonksiyonlardýr... Yani mesela aþaðýda 'db_name()' fonksiyonu ; '(dbid)' deðerini Parametre
-- olarak alýyor ve bu þekilde 'db_name()' fonksiyonunu dönüyor... :
--   Yine aþaðýda 'as ColumnName' diye yazdýðýmýz KOD ile de , ayný satýrdaki öncesinde yazdýðýmýz KODA yeni bir
-- Kolon ismi vermiþ oluyoruz... Bu Kolon ismi vermek fiziksel bir deðiþiklik deðildir. Sadece arayüzde bir görüntü
-- deðiþikliði demektir... :
--   Yine aþaðýdaki ilk KOD satýrýnda 'filename' olarak 'fName' ismini atamýþýz... :
--   Bu ilk KOD satýrýný çalýþtýrdýðýmýzda gördüðümüz gibi, sadece istediðimiz '3' adet kolonu göstermiþ olduk... :
select dbid , db_name(dbid) as ColumnName , filename fName from sys.sysaltfiles

--   DEFAULT olarak hiçbir isim atamazsak da , Veri Tabanýnda nasýl bir baþlýk yazýlýysa öyle kalacaktýr... Hiçbir
-- baþlýk yazmýyorsa da '(No column name)' yazacaktýr... :
select dbid , db_name(dbid) , filename from sys.sysaltfiles

--   Yine isim atarken istersek 'as' takýsýný kullanmasak da olur... Sadece bir boþluk býrakýp istediðimiz ismi
-- yazabiliriz... :
select db_name(dbid) dbname , filename from sys.sysaltfiles

--   Bunlar fiziksel birer deðiþiklik deðildirler... Sadece arayüzde görsel bir deðiþiklik saðlarlar...



--------------- Üzerinde Çalýþýlan 'Veri Tabanýna' Ait Özellikler ---------------

--   'Üzerinde Çalýþýlan Veri Tabaný' demek : Solda bir dünya Veri Tabaný görüyoruz ama biz yazdýðýmýz sorgularý ,
-- sadece bir Veri Tabaný Seçerek yapmamýz gerekiyor demektir...


SELECT * FROM sys.database_files;



--------------- Veritabaný Oluþturma ---------------

CREATE DATABASE MEFMaster ON (FILENAME = 'D:\ITU\AdventureWorks1_Data.mdf');



--------------- Kullanýlacak Veritabaný Seçimi ---------------

--   Sol yukarýda gördüðümüz gibi biz þu an DEFAULT olarak 'master' Veri Tabanýnda çalýþýyoruz... Oraya týklayarak
-- bunu deðiþtirebiliriz... 
--   Ayrýca bunu yapmak için 'Use' KODUNU da kullanabiliriz... :
Use ITUmindset



--------------- Kullanýlacak Tablonun Varlýðýnýn Sorgulanmasý (IF) ve Varsa Silinmesi (DROP) ---------------

--   Bazen ; özellikle 'Drop' , 'Delete' , 'Update' gibi komutlarý çalýþtýrýrken , bir KONTROL yapmamýz gerekiyor...
-- Bunun için de 'IF' komutunu kullanmamýz gerekiyor...
--   Mesela aþaðýda , ITUmindset Veri Tabanýnýn içerisinde ; EÐER 'dbo.Employees' isminde bir tablo VARSA
-- (Yani o tablo boþ deðilse) o tabloyu SÝL diyoruz... Yoksa zaten bir sýkýntý da yoktur... :
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
  DROP TABLE dbo.Employees;




--------------- TABLO OLUÞTURMA ---------------

--   'CREATE TABLE' komutunu kullanarak 'Employees' isminde bir Tablo oluþturmak istiyoruz...

--	 "dbo" tablolarýn þemalarýndan biridir. Kendimiz ayrý oluþturmazsak default hali "dbo"'dur.
--   Þemalarýn iki görevi vardýr :
--   + Þema özelinde yetkilendirme yapabiliriz. Kim hangi þemayý görebilir - göremez gibi...
--   + Birbirine benzer olan tablolarý ayný þemada toplayabiliriz... dbo.car , dbo.motor , ... gibi... Ve / Veya
-- Person.age , Person.length , ... gibi ...

--   Aþaðýdaki mesela ,  "firstname VARCHAR(30) NOT NULL,"  komutu ;  " 'firstname' diye bir deðerimiz var ve
-- maksimum '30' karakter alabilir ve Boþ Deðer Geçiremez." diyor...

CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);

--    Oluþturduðumuz Tabloyu çalýþtýrdýktan sonra Soldaki 'Databases' içerisindeki 'ITUmindset' içerisindeki
-- 'Tables''de görebilmek için ; 'Tables''in üzerine gelip Sað týklayýp bi 'Refresh' butonuna týklamamýz gerekiyor...
--    Solda oluþturduðumuz 'dbo.Employees' Tablosunun da alt kýrýlýmlarýna bakarsak Tablomuzun nelerden oluþtuðunu
-- görürüz. (Columns , Keys , Constraints , Triggers , Indexes , Statistics , ... gibi ...)

--    'Columns' yapýsýna týkladýðýmýzda , yarattýðýmýz kolonlarýn isimlerini , data tiplerini , Null olup olmamasý
-- ile ilgili bilgileri ve daha nicelerini görebiliyoruz...

--    ** trigger == Harekete geçirmek , Baþlatmak , Tetik , Tetikleme. **
--    'Triggers' Yapýsý : Mesela bu tabloda belirlediðimiz Trigger'leri ; mesela X türünde bir iþlem yapýldýðýnda ,
-- baþka bir aksiyon alýnacaksa onlara 'Trigger' denir... Mesela , 'Social Security Number' deðiþtiriliyorsa ve biz
-- bunu gidip baþka bir tabloda da deðiþtirmek istiyorsak... Veya baþka bir tabloya kayýt atmak istiyorsak veya bir
-- servise tetikleyeceksek , yani bir tetikleme iþlemi varsa bu bir 'Trigger' oluyor...

--    'Indexes' ve 'Statistics' yapýlarý ise , bu tablonun yüksek performanslý çalýþmasýný saðlayan yapýlardýr...


--    Tablomuza manuel olarak deðer girmek için de , soldaki 'dbo.Employees' tablosuna Sað týklýyoruz ve
-- 'Edip Top 200 Rows' butonuna týklýyoruz...



--   Oluþturduðumuz kolonlardan biri 'employeed ID' yani 'empid' kolonuydu... Bu kolonu istersek Benzersiz ve / veya
-- Otomatik Artan hale de getirebilirdik... Böyle yapsaydýk ayný 'employeed ID''ye sahip baþka bir satýr olamazdý...


--------------- AUTO INCREMENT (OTOMATIK ARTMA) ---------------
---- Tabloda employer ID'nin otomatik artmasýný istiyoruz ----

--   Otomatik Artan Yapý : 'Integer' veya 'Guid' tipinde olabilir...

-------- GUID (NEWID) --------

--	 Sürekli rastgele bir deðer oluþturmak için 'Guid''i kullanýrýz. Her çalýþtýrdýðýmýzda yeni bir deðer oluþturur.
-- Buna GUID yapý denir... :
select NEWID()


-- Öncelikle tablomuzu tamamen silelim. Ve en baþtan , 'empid' kolonumuz Otomatik Artacak þekilde oluþturalým... :

--------------- Tabloyu Silme Ýþlemi (drop) ---------------
drop table dbo.Employees


--------------- Tablonun Tamamýný Uçurma-Silme (truncate) ---------------

--    ** truncate == Kýrpmak , Sondan kýrpma. **

TRUNCATE TABLE [ITUmindset].[dbo].[Orders]


-------- INTEGER (identity()) --------

--    ** identity == Kimlik , Özdeþlik. **
--    ** primary == Primer , Birincil , Baþlýca , Esas. **

--	  "identity()" komutu ile aritmetik sýralama yaparýz! 
--	  Mesela , "identity(1 , 2)" komutu ile ; bu komutu içerisine yazdýðýmýz kolon , "1" deðeri ile baþlayacak ve her
-- yeni girdi de, ikiþer ikiþer otomatik artacak diyoruz...
--    "primary key clustered" ile de , deðerimize "Primary Key" özelliði koyuyoruz...
--    "dbo.Employees" tablomuzu açtýðýmýzda, "empid" deðerini deðiþtiremediðimizi göreceðiz. Çünkü otomatik atama
-- yapacak!
--	  Ve soldaki "dbo.Employees" tablosunun altýndaki "Columns" klasörünün içine baktýðýmýzda, "empid" kolonumuzda
-- 'kilit iþareti' olduðunu görürüz... Bu da , "'empid' kolonumuz üzerinde bir iþlem yapamayýz , kilitli." demektir.

----    NOTE  :  'identity' içerisine hiçbir þey yazmadan direkt 'IDENTITY' yazarsak ; ilgili kolonda '1''den
----	baþlayarak sýrasý ile birer birer ilerler...

CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL identity(1905, 2) primary key clustered,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);




--------------- TABLODA BÝR SATIR SÝLME ---------------

--	 Yukarýdaki kilitli "empid" kolonu ile oluþturulan tablodan bir satýr sildiðimizde ; o satýrýn "empid" deðeri ,
-- sonradan girilen veri satýrý için KULLANILAMAZ!  Yani aþaðýda sildiðimiz , "empid" deðeri 1907 olan satýrdan
-- sonra ; yeni satýr için otomatik olarak , "empid" deðeri 1909 olan bir satýr gelir :

delete from dbo.Employees where empid = 1907



---------- Yeniden Tabloyu Silelim (drop) ----------
drop table dbo.Employees


---------- Yeniden Tablo Oluþturalým ----------
CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);




--------------- CONSTRAINT EKLEME ---------------

--------------- PRIMARY KEY EKLEME ---------------

----    **   alter == Deðiþtirmek. **
----    ** constraint == Kýsýt , Kýsýtlama. **

----	NOTE:	"Primary Key" özelliði ekleme iþlemi, yukarýdaki gibi CREATE TABLE esnasýnda , "primary key clustered"
-- ile de yapýlabilirdi...

--   "UPDATE" komutu tablodaki kolonda DEÐÝÞÝKLÝK, GÜNCELLEME yapmamýzý saðlar. Kolonun içerisindeki Veriyi ,
-- Kalýcý Þekilde deðiþtirir!

--	 "ALTER" komutu tabloda DEÐÝÞÝKLÝK, GÜNCELLEME yapmamýzý saðlar! Tablonun - Kolonun Fiziksel Yapýsýný deðiþtirir!
-- Yani Kolonun Tipini (Type) deðiþtirebiliriz... "ALTER TABLE" komutundan sonra, deðiþiklik yapmak istediðimiz
-- tablonun ismini yazarýz...
--   Mesela , 'Employees' Tablosundaki 'lastname' Kolonunun , maksimum karakter sýnýrýný arttýralým... Yani bu Kolonun
-- Fiziksel Yapýsýný deðiþtirelim :
ALTER TABLE dbo.Employees ALTER COLUMN lastname VARCHAR(40) ;

--	 "ADD" komutu tabloya bir þey EKLEMEMÝZÝ saðlar! "ADD CONSTRAINT" komutu ile bir "constraint" ekliyoruz..

--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemiþ oluruz. Sonrasýndaki yazdýðýmýz ifade ise bir
-- atamadýr. Aþaðýda; yarattýðýmýz "PK_Employees" isminde bir deðiþkene, kýsýtlamamýzý atadýk!

--	 "PRIMARY KEY()" komutu ile de, içerisine yazdýðýmýz kolona "Primary Key" özelliði eklemiþ oluruz ve o kolondaki
--her deðer "Primary Key" özelliði sayesinde birbirinden farklý olmak zorundadýr!!!

ALTER TABLE dbo.Employees				-- Üzerinde iþlem yapacaðýmýz tablonun ismi
  ADD CONSTRAINT PK_Employees_empid		-- CONSTRAINT ile kýsýtlama ekleyeceðimiz kolon için yarattýðýmýz atamanýn ismi
  PRIMARY KEY(empid);					-- Primary Key özelliðini ekleyeceðimiz kolonun ismi.

----	NOTE:	Daha önceki iþlemleri silip, bu iþlemlerden sonra tabloyu açtýðýmýzdan dolayý, "empid" deðerimizin
----	otomatik olarak atanmadýðýný, "empid" deðerini kendimizin girmesi gerektiðini gördük. Çünkü daha önceki iþlemde
----	"identity()" komutu ile otomatik olarak sýralý artmasýný istediðimiz "empid" deðerimiz için burada bir iþlem
----	yapmadýk.


---------- 'Unique' Özelliði ----------
--	 Aþaðýda, tablodaki Social Security Number "ssn" kolonunun, 'unique' yani 'benzersiz' olmasýný istiyoruz :

ALTER TABLE dbo.Employees
  ADD CONSTRAINT UNQ_Employees_ssn
  UNIQUE(ssn);


---------- 'Check' Özelliði ----------
--	 CHECK özelliði ; "ADD CONSTRAINT" komutuyla , yazýlý kolunun içerisine girdiðimiz veri deðerin 'koþullarýný
-- belirlememizi' saðlar :
--   Aþaðýda , 'salary' kolonunun minimum deðerini belirleyelim.

ALTER TABLE dbo.Employees
	ADD CONSTRAINT min_salary
	check(salary > 3000)

alter table dbo.Employees
	add constraint min_firstname
	check(len(firstname) > 1)

--	 NOTE  :  Solda, çalýþtýðýmýz tablonun içerisindeki "Constraints" dosyasýnýn içerisine baktýðýmýzda, sadece "check"
--   komutu ile yazdýðýmýz "Constraint"'leri göreceðiz... Yani kendimize koþul koyduðumuz ifadeleri göreceðiz..
--      Geri kalan 'Constraint''leri de ; Soldaki 'dbo.Employees' tablosuna Sað týklayýp , 'Script Table as'
--	 atýkladýktan sonra , 'CREATE To' ya týklayýp sonra da 'New Query Editor Window''a týklýyoruz ve orada görüyoruz...
--   Yani tablonun kendi yapýsý içerisinde saklýyor...




--------------- VERÝ GÝRÝÞÝ YAPMAK ---------------

--   INSERT INTO [Veri Giriþi Yapmak Ýstediðimiz Tablo Ýsmi]
--   ([kolon], [kolon], ...)
--	 VALUES
--	 (veri, veri, veri, ...)

INSERT INTO [Employees]
([empid], [firstname], [lastname], [hiredate], [mgrid], [ssn], [salary])
VALUES 
(1908, 'su', 'ceylan', '2016-12-01', 132, '36715774718', 10000)

INSERT INTO [Employees]
([firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1910,'koray','kocabas','2016-12-01',132,'36715774418',5000)
--	Hata aldýk! Sebebi de "unique" deðer olan "ssn" deðerini tekrarlamak istedik ama izin vermedi!

INSERT INTO [Employees]
([firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1911,'koray','kocabas','2016-12-01',132,'46715775430',100)
--	Hata aldýk! Sebebi de "salary" deðeri olarak "3000"'den küçük deðer girdik ama izin vermedi!

INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1909,'cemre','ceylan','2016-12-01',135,'36742344718',17000)

INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
('ege','ceylan','2016-12-01',135,'36741244718',9000)
--	Hata aldýk! Sebebi de "empid" deðeri girmedik ve dolayýsý ile izin vermedi!

----	NOTE  :	 Eðer daha yukarýlardaki gibi mesela "identity()" metodu ile "empid" deðerimize bir baþlangýç deðeri
----	verip otomatik artan yapsaydýk ; veri giriþi esnasýnda "[empid]" kýsmýný atlayýp boþ býrakarak diðer kolonlar
----	için olan verilerimizi girmemiz gerekecekti!!! Eðer "empid" kolonu için bir deðer girmeye çalýþsaydýk da hata
----	verecekti!!!

----	NOTE  :	 'Constraint''ler olabildiðince saðlýklý þekilde veri giriþi yapmamýzý saðlayan yapýlardýr...
----	NOTE  :	 Tabloya veri giriþi yaparken hata alýyorsak , Solda tablonun içerisindeki 'Constraint' yapýsýna
----    bakabiliriz...



--------------- FOREIGN KEY Ýçin ; Tablo Kontrolü ve Tablo Oluþturma ---------------

--    ** order == Sipariþ. **

--	  Bir "Orders" tablosu oluþturalým :

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
  DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
  orderid   INT          NOT NULL identity(1, 3) ,		-- order id     (sipariþ no)
  empid     INT          NOT NULL ,						-- employee id  (çalýþan no)
  eventid   int			 not null ,						-- event id     (olay no)
  custid    VARCHAR(10)  NOT NULL ,						-- cust id      (müþteri no)
  orderts   DATETIME2    NOT NULL ,						-- order ts     (sipariþ zamaný)
  qty       INT          NOT NULL ,						-- quantity     (miktar)
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
  --   "PK_Orders key" atamamýzý soldaki "dbo.Orders" tablomuzun içerisindeki "Keys" klasörünün içersinde görebiliriz.
  --   "Primary Key"'imizi de soldaki "dbo.Orders" tablomuzun içerisindeki "Columns" klasörünün içersinde görebiliriz.
  drop table dbo.Orders
  ----		NOTE:	"Primary Key"'i ; daha yukarýdaki "orderid" kýsmýnda da , daha önce öðrendiðimiz gibi
  ----		oluþturabilirdik... Ancak yukarýda "CONSTRAINT" ile en sonda oluþturmayý tercih ettik. Hiçbir fark YOK!
  ----		   Yani yukarýdaki KOD yapýsý ile aþaðýdaki KOD yapýsý arasýnda hiçbir fark yok !!!
  CREATE TABLE dbo.Orders
(
  orderid   INT          NOT NULL identity(1, 3) primary key clustered ,		-- order id     (sipariþ no)
  empid     INT          NOT NULL ,												-- employee id  (çalýþan no)
  eventid   int			 not null ,												-- event id     (olay no)
  custid    VARCHAR(10)  NOT NULL ,												-- cust id      (müþteri no)
  orderts   DATETIME2    NOT NULL ,												-- order ts     (sipariþ zamaný)
  qty       INT          NOT NULL ,												-- quantity     (miktar)
);



---------- Tablonun Tamamýný Uçurma-Silme (truncate) ----------

--    ** truncate == Kýrpmak , Sondan kýrpma. **

TRUNCATE TABLE [ITUmindset].[dbo].[Orders]




--------------- !!! FOREIGN KEY EKLEME !!! ---------------

----	NOTE  :  Diðer tablolar ile arasýnda bir etkileþim oluþturmak için "Foreign Key" kullanýrýz!!!
----	NOTE  :  Tablolar arasýnda baðlantý çok çok önemlidir!!!

----	NOTE  :  "Foreign Key" özelliði getireceðimiz kolona , daha öncesinde "Primary Key" özelliði getirmemiz her
----	zaman daha doðru olur... Aksi halde iþlemlerde mantýksýzlýklar görülebilir!!!
----    NOTE  :  'Foreign Key''ler , SADECE 'Primary Key''leri REFERANS edebilir...

--   "UPDATE" komutu tablodaki kolonda DEÐÝÞÝKLÝK, GÜNCELLEME yapmamýzý saðlar. Kolonun içerisindeki Veriyi ,
-- Kalýcý Þekilde deðiþtirir!
--	 "ALTER" komutu tabloda DEÐÝÞÝKLÝK, GÜNCELLEME yapmamýzý saðlar! Tablonun - Kolonun Fiziksel Yapýsýný deðiþtirir!
--	 "ALTER TABLE" komutundan sonra, deðiþiklik yapmak istediðimiz tablonun ismini yazarýz..
--	 "ADD" komutu tabloya bir þey EKLEMEMÝZÝ saðlar! "ADD CONSTRAINT" komutu ile bir "constraint" ekliyoruz..
--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemiþ oluruz. Sonrasýndaki yazdýðýmýz ifade ise bir
-- atamadýr. Aþaðýda ; yarattýðýmýz "PK_Orders_Employees" isminde bir deðiþkene , kýsýtlamamýzý atadýk!

--	 "FOREIGN KEY()" komutu ile, içerisine yazdýðýmýz kolonun "Foreign Key" özelliðinin olmasýný istiyoruz. Yani
-- referans göstereceðimiz diðer tablolarla iliþkili olsun istiyoruz...
--	 "REFERENCES" komutu ile de ; burada "FOREIGN KEY()" komutunda yazdýðýmýz 'Kolonun' , hangi Tablodaki Kolonla
-- iliþkili olmasýný istiyorsak onu yazýyoruz. "REFERENCES" komutu sonrasýnda da 'Tablonun' ve iliþkili 'Kolonunun'
-- ismini yazýyoruz.

ALTER TABLE dbo.Orders
  ADD CONSTRAINT FK_Orders_Employees
  FOREIGN KEY(empid)
  REFERENCES dbo.Employees(empid);

--	Solda, "dbo.Orders" tablosunun içerisindeki "Columns" klasörünün içerisinde "empid (FK)" Kolonumuz gümüþ renkli
--anahtar þekilnde oluþtu.


------ Tablolarýmýzý Görelim: ------
SELECT * FROM [ITUmindset].[dbo].[Employees] 
SELECT * FROM [ITUmindset].[dbo].[Orders]


------ Veri Giriþi Yapalým (Order için) ------
INSERT INTO [dbo].[Orders]
           (
		    [empid]
           ,[eventid]
           ,[custid]
           ,[orderts]
           ,[qty])
     VALUES
           (1905
           ,3
           ,'tc1354'
           ,'2020-08-09'
           ,10
		   )
GO
----	NOTE:	Yukaridaki veri giriþi için olan kodu çalýþtýrdýk ve HATA ALDIK!
----	Hata : "dbo.Employees" tablosunda olmayan bir "empid" deðerini "dbo.Orders" tablosu için girmeye çalýþýyorsun.
----	Bunu yapamazsýn diyor! Çünkü "Foreign Key" özelliðimiz ile bu iki tablodaki "empid" Kolonlarýný Birbirlerine
----	EÞLEDÝK !!!
----	REFERANS olarak verdiðimiz "Employees" tablosunda OLMAYAN hiçbir "empid" deðeri "Orders" tablosunda OLAMAZ !!!
----	REFERANS olarak verilen tablo , Kýstas Tablosudur! Yazýlan deðer ÖNCE o Tabloda olmalýdýr !!!

------	Aþaðýda Düzelterek Deneyelim :
INSERT INTO [dbo].[Orders]
           (
		   [empid]
           ,[eventid]
           ,[custid]
           ,[orderts]
           ,[qty])
     VALUES
           (1909
           ,3
           ,'tc1354'
           ,'2020-08-09'
           ,10
		   )
GO


------ Tekrar Tablolarýmýzý Görelim : ------
  SELECT * FROM [ITUmindset].[dbo].[Employees] 
SELECT * FROM [ITUmindset].[dbo].[Orders]


---------- "Foreign Key" ile Birbirlerine Ýliþkilendirilmiþ Kolondan , Bir Veri Silme ----------
delete from dbo.Employees where empid = 1909

------ VEYA ------
delete from [ITUmindset].[dbo].[Employees] where [empid] = 1909

----	NOTE  :  Çalýþtýrdýðýmýzda bir hata aldýk !!!
----	"Foreign Key" ile birbirlerine iliþkilendirdiðimiz bir kolondan veri silmemiz mümkün deðildir!!! ANCAK ,
----	o veri üzerinde bir Deðiþiklik yapabiliriz... Yani o veriyi gerekiyorsa Anonimleþtirebiliriz...
----	Gördüðümüz gibi, "Foreign Key" sayesinde veriyi korumuþ da oluyoruz !!!
----        ANCAK , illaki bir veri silmek istiyorsak ; ÖNCELÝKLE , REFERANS aldýðýmýz Tablodaki iliþkili Kolondan
----    o veriyi silmemiz gerekiyor !!!


---------- Tablolarýn Silinmesi ----------
DROP TABLE dbo.Orders , dbo.Employees ;


---------- Yeniden Tablolarý Oluþturalým ----------
CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL ,
  firstname VARCHAR(30) NOT NULL ,
  lastname  VARCHAR(30) NOT NULL ,
  hiredate  DATE        NOT NULL ,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL ,
  salary    MONEY       NOT NULL
) ;

CREATE TABLE dbo.Orders
(
  orderid   INT          NOT NULL identity(1, 3) ,		
  empid     INT          NOT NULL ,						
  eventid   int			 not null ,						
  custid    VARCHAR(10)  NOT NULL ,						
  orderts   DATETIME2    NOT NULL ,						
  qty       INT          NOT NULL ,						
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
) ;




--------------- CONSTRAINT EKLEME ---------------

--	 "ALTER" komutu tabloda DEÐÝÞÝKLÝK, GÜNCELLEME yapmamýzý saðlar! "ALTER TABLE" komutundan sonra, deðiþiklik yapmak
-- istediðimiz tablonun ismini yazarýz...
--	 "ADD" komutu tabloya bir þey EKLEMEMÝZÝ saðlar! "ADD CONSTRAINT" komutu ile bir "Constraint" ekliyoruz...
--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemiþ oluruz. Sonrasýndaki yazdýðýmýz ifade ise bir
-- atamadýr.

ALTER TABLE dbo.Employees
  ADD CONSTRAINT CHK_Employees_salary
  CHECK(salary > 2900);

  INSERT INTO [Employees]
(empid, [firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1900, 'ALPER','CEYLAN','2020-12-01',133,'36715774475',3100)


---------- Tablolarýn Silinmesi ----------
DROP TABLE dbo.Orders , dbo.Employees;


----    NOTE  :  'Constraint''leri , illaki ALTER TABLE ile yapmamýza gerek yoktur. CREATE TABLE ile de yaratabiliriz...


--------------- CONSTRAINT'lerin , Tablo Oluþturulurken Belirtilmesi ---------------

IF OBJECT_ID ('dbo.testCustomer') IS NOT NULL BEGIN        
	DROP TABLE dbo.testCustomer;    
END;
GO    


CREATE TABLE dbo.testCustomer (        
	CustomerID INT NOT NULL IDENTITY(1, 1) ,      --   Customer ID (Müþteri No)
	FirstName  VARCHAR(25) , 
	LastName   VARCHAR(25) ,        
	--Age      INT ,	  (Burayý comment hale getirdik çünkü yaþ her sene deðiþir! Onun yerine doðum tarihi tutulur) :
	BirthDate  DATE ,	  --   Günümüzden , doðum tarihi çýkarýlarak bulunur.
	isActive   bit ,	  --   Sadece , '0' veya '1' deðeri alýr.
	Gender	   CHAR(1) DEFAULT 'F' ,     --   Cinsiyet, tek bir karakter alacak (CHAR(1)) !! Deðer girilmezse "F" olacak!
	--   Bu yukarýdaki  "CHAR(1) DEFAULT 'F'"  kodu da , bir 'Constraint''dir...       
	CONSTRAINT ch_testCustomer_Gender CHECK (Gender IN ('F' , 'M' , 'U' , 'T')) ,     -- 'Gender' kolonu , her karakteri
																		--almasýn diye de , bir 'Constraint' ekliyoruz...
	CONSTRAINT PK_testCustomer PRIMARY KEY (CustomerID)
	--CONSTRAINT ch_testCustomer_Age CHECK (Age < 140) ,   (Burayý da comment hale getirdik. Çünkü 'Age' kolonunu sildik)
	) ;


IF OBJECT_ID('dbo.testOrder') IS NOT NULL 
BEGIN        
	DROP TABLE dbo.testOrder;    
END;    
GO


--------------- SELECT GETDATE() ---------------

----	NOTE  :	 "GETDATE()" komutu, bize DEFAULT olarak sunucumuzun SAATÝNÝ verir!

--	 Computed Column (Hesaplanmýþ Kolon) iþlemlerinde kullanýlýr =
--	 Veri tabanýnda bir Kolon oluþturuyoruz. Ama o Kolona bir deðer GÝREMÝYORUZ... O Kolonda sadece , baþka Kolonlar
-- arasýndaki Matematiksel iþlemleri görmek istiyoruz !

--   Aþaðýda DEFAULT haliyle yazýlmýþ olan pembe renkli 'GETDATE()' fonksiyonu bize , Sunucunun Zamanýný verir...

CREATE TABLE dbo.testOrder (
	CustomerID  INT NOT NULL,
	OrderID		INT NOT NULL IDENTITY,
	OrderDate	DATETIME DEFAULT GETDATE(),
	Price		Money NOT NULL,		    -- 5
	Qty			INT NOT NULL,		    -- 10
	LineItemTotal AS (Price * Qty),		-- 50		 -- Bu kolondaki veriyi deðiþtiremeyiz! Matematiksel iþlem kolonu!
	CONSTRAINT fk_testOrders
	FOREIGN KEY (CustomerID)
	REFERENCES dbo.testCustomer(CustomerID),
	CONSTRAINT PK_TestOrder PRIMARY KEY (OrderID)
	);
--	 Solda, "dbo.testOrder" tablomuzun "Columns" klasörüne baktýðýmýzda, "LineItemTotal(Computed,money,null)" ifadesini
-- görüyoruz. Þekli diðerlerinden farklý! Bu "LineItemTotal" kolonuna herhangi bir "insert" iþlemi yapamayýz! Yani bir
-- veri giriþi YAPAMAYIZ! Bu kolon, diðer kolonlarla ilgili matematiksel iþlemleri tutar!
-- 	Yine solda, "dbo.testOrder" tablomuza sað týklayýp "Script Table as"'a gelip "INSERT to"'ya týkladýðýmýzda, hazýr
-- "insert" komutu geliyor. O komutta da gördüðümüz gibi "LineItemTotal" kolonu YOK! Çünkü bu kolona "insert" yapýlamaz!
-- Ama diðer kolonlar için iþlemleri buradan rahatlýkla yapabiliriz..




------------------------------------------------------------------------------------------------------------------------




-------------------- 'AdventureWorks1' isimli Veri Tabanýna Geçiþ Yapalým --------------------

USE [AdventureWorks1]



--------------- FÝLTRELEME ---------------

-- 'FROM'    :  Kaynaklarýmýzý (Tablolarýmýzý) yazýyoruz.
-- 'SELECT'  :  Görmek istediðimiz Alanlarý (Kolonlarý) yazýyoruz.
-- 'WHERE'   :  Ýstediðimiz Filtreleri (Verileri) yazýyoruz.


---------- Tablodaki Tüm Kayýtlarýn Gösterilmesi ----------
SELECT * FROM AdventureWorks_Customers


---------- Tablodaki Belirli Kolonlarýn Gösterilmesi ----------
----    NOTE  :  Normalde , Kolonlarýn isimlerini yazarken ; Kolon isimlerinin aralarýnda boþluk olma ihtimalinden
----    dolayý , Kolon isimlerini Köþeli Parantez içerisinde yazmalýyýz... AMA eðer Kolon isminde bir boþluk yok
----    ise Köþeli Parantez kullanmadan direkt Kolon ismini de yazabiliriz...
SELECT CustomerKey , Prefix , FirstName , LastName , EducationLevel , HomeOwner FROM AdventureWorks_Customers;

-- Kolon ismini deðiþtirmek için de ; 'as' takýsýný kullanmalýyýz :
SELECT CustomerKey as [Customer ID] , Prefix , FirstName , LastName, EducationLevel FROM AdventureWorks_Customers;


---------- Tablodaki Ýlk 100 Kayýdýn Gösterilmesi ----------
SELECT top 100 CustomerKey , Prefix , FirstName , LastName FROM AdventureWorks_Customers;
-- ('MySQL' için  :  SELECT CustomerKey, Prefix, FirstName, LastName FROM AdventureWorks_Customers LIMIT 100 ;)


---------- Tablodaki Ýlk Yüzde Birlik (%1) Kayýtlarýn Gösterilmesi ----------
SELECT top 1 percent CustomerKey , Prefix , FirstName , LastName , EducationLevel FROM AdventureWorks_Customers;

----    NOTE  :  Yukarýdaki yaptýðýmýz Filtreleme iþlemlerinde , ÖNCE bütün Tabloyu okuyor sonra Filtreleme iþlemi
----    gerçekleþtiriyor...



--------------- 'WHERE' ile Filtreleme ---------------

-- Bütün Tabloyu GÖRMEDEN , sadece istediðimiz verileri Filtreleyip okumak istiyorsak , 'WHERE' kriterini kullanýrýz...

----	NOTE  :  Eþitlik "=" operatörü ; BÝREBÝR AYNI olan deðerleri gösterir! Yani Eþitlik sonrasýnda yazýlan deðere ,
----    TAM denk gelen deðerleri gösterir. Mesela aþaðýda "Bike Racks" yazdýðýmýzda ; baþka bir , içerisinde "Bike"
----    olan veri satýrýný göstermez..! Sadece Tam olarak "Bike Racks" yazan veri satýrlarýný gösterir...

SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey
FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  =  'Bike Racks'; 

SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  <>  'Bike Racks';		-- "<>" (Eþit Deðildir)
 ------ VEYA ------
SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  !=  'Bike Racks';		-- "!=" (Eþit Deðildir)



--------------- 'BETWEEN' Komutu ---------------
-- Ýstediðimiz , NUMERIK olan deðer veya deðerler ; Birbirlerinin ARASINDA ise 'BETWEEN' komutunu kullanabiliriz : 

SELECT OrderDate
	,StockDate
	,OrderNumber
	,ProductKey     
	,CustomerKey     
	,TerritoryKey   
	,OrderQuantity 
FROM AdventureWorks_Sales_2017

WHERE TerritoryKey  BETWEEN  5 and 7;
----	NOTE:	"BETWEEN" komutunda , mesela yukarýda '5' ile '7' deðerleri arasýný göstermesini istedik. Bu komut
----    ile kullandýðýmýzda , hem '5' hem de '7' deðerleri DAHÝL EDÝLÝYOR..!   Yani   '5' <= 'X' >= '7'   gibi...

-- VEYA , 'BETWEEN' Komutunu Kullanmadan da yapabiliriz : 
WHERE TerritoryKey >= 8  and  TerritoryKey <=10;



--------------- 'Eþit Deðildir' Filtresi ---------------
SELECT ProductSubcategoryKey, SubcategoryName, ProductCategoryKey FROM AdventureWorks_Product_Subcategories WHERE SubcategoryName <> 'Bike Racks'
---- VEYA ----
SELECT ProductSubcategoryKey, SubcategoryName, ProductCategoryKey FROM AdventureWorks_Product_Subcategories WHERE SubcategoryName != 'Bike Racks'



--------------- 'Tarih Aralýðý' Filtresi ---------------
--   Yine istersek 'BETWEEN' komutu ile yaparýz. Ýstersek de 'küçük eþittir - büyük eþittir' operatörleri ile yaparýz :
SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017
WHERE StockDate >= '1-1-2003'  AND  StockDate <= '12-30-2003';

SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017 
WHERE StockDate  BETWEEN  '1-1-2003'  AND  '12-30-2003';



--------------- 'OR (VEYA)' Kullanýmý ---------------
--   Her iki koþulun da saðlanmasý gerektiði durumlarda hep 'AND' kullandýk... AMA iki koþuldan biri saðlansa da bize
-- yeter diyorsak , 'OR' komutunu kullanýrýz...
SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017
WHERE CustomerKey >= 14000  OR  CustomerKey < 16000


--------------- 'NULL (Boþ Veri)' Kontrolu ---------------
SELECT CustomerKey , BirthDate , EmailAddress , AnnualIncome
FROM AdventureWorks_Customers
WHERE EmailAddress IS NULL
--	 BOÞ Veri kontrolü için ; "WHERE" komutu içerisinde, arama yapacaðýmýz kolon ismini ve "IS NULL" komutunu yazarýz!

SELECT CustomerKey , BirthDate , EmailAddress , AnnualIncome
FROM AdventureWorks_Customers
WHERE EmailAddress IS NOT NULL
--   BOÞ OLMAYAN Verilerin kontrolü için de ; "WHERE" komutu içerisinde, arama yapacaðýmýz kolon ismini ve "IS NOT NULL"
-- komutunu yazarýz!



------------------------------------------------------------------------------------------------------------------------
--------------- Veri Tabanlarýný ÞEMALARINA Ayýrma iþlemlerini neye göre yapýyoruz ? ---------------

--   Þirketin Veri Tabanýný hazýrlarkenki yapacaðý operasyonlara göre ayarlanabilir veya Þirketin departmanlarýna
-- göre de olabilir...
--   Mesela Veri Setini , Veri Tabanýnda HAM þekilde tutuyorsak 'DBO' Þemasýnda tutuyoruz. Ama mesela bir Data Scientist
-- o veriyi alýp manipülasyonunu yaptýktan sonra 'STAGE' diye bir Þemada saklayabiliyor. En sonunda da en nihai halini
-- aldýðýnda 'RESULT' veya 'ANALYSIS' veya 'DS' diye farklý Þemalarda basýyoruz ki bizimle çalýþanlar þunu anlýyor ; 
-- DS þemasý En Son sonucu veren Þema olarak oluþturuluyor... gibi ...
------------------------------------------------------------------------------------------------------------------------



--------------- SIRALAMA - Örnek 1 ---------------

----	NOTE  :	 "ORDER BY" komutu HER ZAMAN sorgu kodlarýmýzýn EN ALT SATIRINA , EN ALT KISMINA YAZILIR!
----	NOTE  :  "DESC" komutu, "Z"'den "A"'ya sýralar!
----	NOTE  :	 "ASC" komutu, "A"'dan "Z"'ye sýralar!

SELECT CustomerKey , LastName , FirstName , Prefix , MaritalStatus
FROM AdventureWorks_Customers
WHERE MaritalStatus IS NOT NULL
ORDER BY LastName DESC , FirstName ASC
--   Burada ; ÖNCE , 'LastName''ye göre "Z"'den "A"'ya sýraladýk ,
-- SONRA da 'FirstName''ye göre "A"'dan "Z"'ye sýraladýk!


--------------- SIRALAMA - Örnek 2 ---------------

SELECT CustomerKey , LastName , FirstName , Prefix , MaritalStatus
FROM AdventureWorks_Customers
WHERE MaritalStatus IS NOT NULL
ORDER BY 2 DESC , 3 ASC
--	 Burada da ; yukarýdaki "SELECT" komutundaki Kolon isimlerini yazdýðýmýz sýraya göre , kaçýncý sýradaki Kolona
-- göre iþlem yapacaksak , o kolonun sýrasýný yazabiliyoruz , yani Kolonlarýn sýra numaralarýný da yazabiliyoruz...
-- Mesela burada ; "SELECT" komutunda yazdýðýmýz "LastName" Kolonu '2.' sýradaki Kolon , "FirstName" Kolonu da '3.'
-- sýradaki Kolon. Bu Kolonlarýn sadece sýra numaralarýný yazarak da sorgu yapabiliyoruz!
--   Yani bir üstteki Kolon isimlerini yazarak yaptýðýmýz sýralamanýn aynýsýný yaptýk...




--------------- 'LIKE' Komutu ---------------

----	NOTE  :  Her zaman kesinlik içeren veya bir aralýk içeren sorgular yapmak zorunda deðiliz! Mesela yukarýda
----	yaptýðýmýz , kolonda "Bike Rack" yazan satýrý getir gibi , tarih aralýklarý gibi veya 14000-16000
----	aralýðýndakileri getir gibi sorgular yapmak zorunda deðiliz...
----	      Ýçerisinde þu olan , bu harf olan , ... gibi sorgumalar da yapabiliriz. Ve bunu "LIKE" komutu
----	ile  yaparýz!

----    NOTE  :  'LIKE' komutu , 'Varchar()' , 'Char()', ... gibi 'STRING' deðerler alan yerlerde sorgulanabilir...

----	NOTE  :	 "LIKE" komutunda, içerisine yazdýðýmýz harf veya kelimenin büyük veya küçük yazýlmasýnýn bir önemi YOK!

----	NOTE  :	 "LIKE" komutunu kullanmanýn bir handikapý vardýr! Özellikle Canlý Veritabanýnda kullanýyorsak ve Satýr
----	Sayýsý da çok fazlaysa , "LIKE" komutu tabloyu okumamýzda bir yavaþlýða sebep olur! Çünkü "LIKE" komutu ,
----	yaptýðýmýz aramada Tüm Tabloyu Scan Eder (Tarar) ve sonra sonucu verir...


---------- LIKE 1 ----------

--	Bu sorguda diyoruz ki; "AdventureWorks_Customers" tablosuna git, "LastName" ve "FirstName" kolonlarýný göster ve
--"LastName" kolonunda yazýlý veriler içerisinde "G" harfi ile BÝTEN satýrlarý göster!

----	NOTE  :	 '%G' = "G" harfi ile BÝTEN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers   
WHERE LastName LIKE '%G' ;   


---------- LIKE 2 ----------

----	NOTE  :	 't%' = "t" harfi ile BAÞLAYAN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers   
WHERE FirstName LIKE 't%';   


---------- LIKE 3 ----------

----	NOTE  :	 '%ang%' = ÝÇERÝSÝNDE "ang" harf dizisi GEÇEN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers     
WHERE LastName LIKE '%aNg%';


---------- LIKE 4 ----------

----	NOTE  :	 NOT LIKE '%ang%';  =  ÝÇERÝSÝNDE "ang" harf dizisi GEÇMEYEN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers     
WHERE LastName NOT LIKE '%ang%';




--------------- 'CONCAT' Fonksiyonu ---------------

SELECT Prefix , FirstName , LastName
FROM AdventureWorks_Customers; 

----	NOTE  :	 Yukarýdaki kod satýrlarý ile "AdventureWorks_Customers" tablomuzdaki "Prefix , FirstName , LastName"
----	kolonlarýný gösterdik. Bu kolonlarý TEK bir kolon haline getirmek için iki farklý yöntem kullanýrýz.
----	Birincisi, "+" operatörünü kullanarak kolonlarý birleþtirir ve tek kolon haline getiririz. "AS" komutunu ile
----    de , birleþtirilmiþ haldeki kolona istediðimiz Ýsmi veririz...
----	Ýkincisi de , "CONCAT" fonksiyonunu kullanýrýz.

----	NOTE  :	 "CONCAT" kullanmamýzýn en önemli sebeplerinden birisi de, "Type Casting" yani "Tip Dönüþtürme"
----	yapmamýz gerektiðinde , yani datalarýn tiplerinin deðiþtirilmesi gerektiðinde "CONCAT" Fonksiyonu bunu
----    baþka bir þey gerekmeden kendi kendine yapýyor!


---------- Ýlk Yöntem ----------
SELECT Prefix + ' ' + FirstName + ' ' + LastName + ' ' AS FullName
FROM AdventureWorks_Customers; 



---------- Ýkinci Yöntem ----------
SELECT Prefix , FirstName , LastName ,
CONCAT (Prefix , ' (' , FirstName , ' ' , LastName,')') AS [FULL NAME]
FROM AdventureWorks_Customers ; 

------ VEYA ------
SELECT Prefix , CONCAT('(' , FirstName , ' ' , LastName , ')') AS [FULL NAME]
FROM AdventureWorks_Customers; 

------ VEYA ------
SELECT Prefix + CONCAT('(' , FirstName , ' ' , LastName , ')') AS [FULL NAME]
FROM AdventureWorks_Customers; 

------ VEYA ------
SELECT CONCAT(Prefix , ' (' , FirstName , ' ' , LastName , ')') as FN
FROM AdventureWorks_Customers 




--------------- !!! Boþ Kayýt Fonksiyonu (ISNULL()) !!! ---------------

--	Tablomuzdaki "CustomerKey" kolonunda Boþ bir satýr varsa onu görmek için kullandýðýmýz kod:
SELECT * FROM AdventureWorks_Sales_2017 WHERE CustomerKey IS NULL;

----	NOTE  :	 "NULL" olan deðerlerin yerine baþka bir deðer vermek istiyorsak "ISNULL" fonksiyonunu kullanýrýz!!

----	NOTE  :	 "ISNULL" fonksiyonumuzun içerisindeki ilk parametresi ; görmek istediðimiz kolonun boþ olup
----    olmadýðýný sorgular. Virgülden sonraki olan ikinci parametresi ise eðer hücre boþ ise ; yerine DEFAULT
----    olarak ne yazýlmasý gerektiðini gösterir! Sonrasýnda da "AS" komutu ile kolonumuza yeni isim verebiliriz..

----	NOTE  :	 "ISNULL" fonksiyonumuzu kullanmamýzýn temel sebebi, son kullanýcýnýn tabloya baktýðýnda daha kolay
----	anlamasýný saðlamaktýr...

SELECT OrderNumber , ISNULL(CustomerKey , 'No Customer ID') AS [Customer ID] , TerritoryKey , OrderQuantity
FROM AdventureWorks_Sales_2017;  


---------- Hücre Bazlý Hesaplama ----------

----	NOTE  :  "VARCHAR()" deðerleri içinde herhangi bir matematiksel iþlem yapamayýz!

----    NOTE  :  Hücresel bazlý hesaplamalarda eðer Tabloyu CREATE ederken yapýyorsak , mesela iki kolon arasýndaki
----    aritmetik operatörü koyup (artý , eksi , çarpý , bölme , ... gibi) orada bir Computed Column (Hesaplanmýþ Kolon)
----    iþlemi yapabiliriz. Ve biz ona 'insert' deðeri girmeden program otomatik kendisi hesaplamasýný yapar...

----	NOTE  :	 Özellikle "NULL" ifadesi ; çarpma , bölme ve çýkarma iþlemlerinde büyük problem çýkartýr! Bu
----    problemi çözmek için de "ISNULL()" fonksiyonu kullanýlabilir...

--   Sorgu bazýnda bir iþlem yapmak istersek de "ISNULL" fonksiyonunu kullanabiliriz :

----    NOTE  :  Aþaðýdaki mesela "ISNULL(ProductKey , 0)" komutunda ; 'ProductKey' kolonundaki deðer BOÞ deðer ise
----    yerine '0' koy demiþiz...

SELECT OrderNumber , (ProductKey + CustomerKey) AS PCK ,
	   ISNULL(ProductKey , 0) + ISNULL(CustomerKey , 0) AS PCK2
FROM AdventureWorks_Sales_2017 ; 

----    NOTE  :  Yukarýdaki "(ProductKey + CustomerKey)" yapýsý ile ISNULL(ProductKey , 0) + ISNULL(CustomerKey , 0)
----    yapýsýnýn normalde hiçbir farký yok gibi görünüyor AMA 'ISNULL()' fonksiyonunu kullanarak yapmamýzýn sebebi ;
----    Eðer ki ilk hesaplamada kolonlardan en az biri NULL deðer ise , sonuç direkt NULL çýkýyor... Ama biz o NULL
----    deðeri o þekilde görmek istemiyoruz , onun yerine '0' yazmasýný istiyoruz... Onun için de 'ISNULL()'
----    fonksiyonunu kullanýyoruz...

--	 Aþaðýdaki kod satýrýndaki "ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1)" kýsmýnda :
--	 BÖLME iþleminde Payda "0" olamayacaðý için ; "CustomerKey" deðerimiz "0" ÝSE onu "1" yap , DEÐÝLSE "CustomerKey"
-- deðerini ayný þekilde tut demiþiz... Sonrasýnda da 'ISNULL()' fonksiyonu ile , bu
-- "(IIF(CustomerKey=0 , 1 , CustomerKey))" deðerinin içerisinde "NULL" deðeri VARSA , onu da "1" olarak tut demiþiz...
-- Yani kontrol etmek için ; "ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1)" komutunu yazmýþýz...
SELECT OrderNumber , ISNULL(ProductKey, 0) / ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1) AS PCK2
FROM AdventureWorks_Sales_2017 




--------------- 'IN' Komutu ---------------

----	NOTE  :	 Bir filtreleme iþleminde BÝRDEN FAZLA filtreleme yapacaksak "IN" komutunu kullanabiliriz...

----	NOTE  :	 "IN" komutunun içerisine yazacaðýmýz ifadelerin Tam ve Doðru olmasý gerekir. En ufak yanlýþlýkta
----	aradýðýmýz satýrlarý göremeyiz...

----    NOTE  :  Ama , 'büyük - küçük harf' uyumuna uyulmasýna gerek yok...

----	NOTE  :	 Arama yaparken,  ""  iþareti KULLANAMAYIZ...  ''  iþaretini KULLANMALIYIZ...

select *  FROM AdventureWorks_Customers
WHERE Occupation IN ('bachelors' , 'graduate Degree')


--------------- Diðer Yöntemler ---------------

---------- 'NOT IN' ----------

select *  FROM AdventureWorks_Customers
WHERE Occupation NOT IN ('Bachelors' , 'Graduate Degree')


---------- 'OR' ----------

WHERE Occupation = 'Bachelors'  OR  Occupation = 'Graduate Degree'

----	NOTE  :	 "OR" metodu da çok tavsiye edilen bir yöntem deðildir. Bu da "LIKE" metodu gibi sistemi yavaþlatýr...




--    ** condition == Koþul , Durum , Þart. **


--------------- !!! 'IIF' Fonksiyonu !!! ---------------

----	NOTE  :	 "IIF" fonksiyonunu içerisine ÝLK ÖNCE 'condition''u yazacaðýz...

----	NOTE  :	 Bu "IIF" fonksiyonunu , daha çok NUMERÝK OLMAYAN verileri NUMERÝK hale dönüþtürmek için kullanýrýz...

--	  Aþaðýdaki kod satýrýnda ;
-- "Occupation" kolunundaki "Graduate Degree" verisini içerenleri "1" yap , diðerlerini "0" yap diyoruz ve o kolunun
-- adýný da 'OCCUPATION' yap diyoruz... :

SELECT CustomerKey , FirstName , LastName , IIF([Occupation] LIKE 'Graduate Degree' , 1 , 0) AS OCCUPATION
FROM AdventureWorks_Customers


----    NOTE  :  Bu bölümde yaptýklarýmýzýn tamamý , Data Çekme iþlemleri ile ilgiliydi...



------------------------------------------------------------------------------------------------------------------------





-------------------- FONKSÝYONLAR ve DEÐÝÞKEN TANIMLAMA --------------------

---------- Bir "email" Örneði Yapalým : ----------

----    NOTE  :  Mesela 'C++''da bir deðiþken tanýmlamak istiyorsak direkt "int x = 3;" yazabiliriz... 'x' artýk
----    bir integer deðiþkendir... 'SQL''de ise Deðiþken tanýmlamak için 'DECLARE' komutunu kullanmamýz gerekir...
----    'DECLARE' komutu ile bir DEÐÝÞKEN yaratýrýz... 'SET' komutu ile de o Deðiþkene , DEÐER atarýz...
----    NOTE  :  'SET' komutunu Kullanmadan da DEÐER atayabilirdik... MEsela aþaðýda direkt ,
----    " DECLARE @email VARCHAR(50) = 'alperceylan009@itu.edu' "  yazsaydýk , yine DEÐERÝ atayabilmiþ olurduk...

----    NOTE  :  Aþaðýlardaki 'SELECT' komutlu KODLARI çalýþtýrýrken , Muhakkak beraberinde ayný anda 'DECLARE'
----     komutlu satýrlarýn da çalýþtýrýlmasý gerekiyor... Yoksa 'SELECT' komutu , Yarattýðýmýz Atamayý bulamaz...

-- "VARCHAR(50)" Türünde , "@email" Ýsminde bir DEÐÝÞKEN yarat :
DECLARE @email VARCHAR(50)
SET @email = 'alperceylan009@itu.edu.tr'
----	+ Veri Setimizdeki bir kiþinin , okul 'email''i olup olmadýðýný öðrenmeye çalýþalým :

--	Eðer "@" iþaretinden sonra ".edu" ifadesi geçiyorsa , bu bir okul mail adresidir...

SELECT @email AS [Mail Address] ,
	IIF(@email LIKE '%.edu.%' , 1 , 0) AS is_University ,
	--	Yukarýdaki kod ile, okul maili ise "1" deðilse "0" dönsün istiyoruz...


    ---------- LEN() Fonksiyonu ----------
	--	Ýçerisine yazdýðýmýz ifadenin uzunluðunu bulur :
	LEN(@email) AS [LEN(@email)] ,


    ---------- LEFT() ----------
	--	"@email" atamamýzýn içerisindeki ifadede , ÝLK iki karakteri görmek istiyorsak :
	LEFT(@email , 3) AS [LEFT(@email , 3)] ,


    ---------- RIGHT() ----------
	--	"@email" atamamýzýn içerisindeki ifadede SON dört karakteri görmek istiyorsak :
	RIGHT(@email , 4) AS [RIGHT(@email , 4)] ,


	---------- SUBSTRING() Fonksiyonu ----------
	--	 "@email" atamamýzýn içerisindeki '3.' karakterden BAÞLA ve dört karakter ÝLERÝ doðru git ve bunlarýn hepsini
	-- gör demek istiyorsak :
	----	NOTE  :	 Saymaya da "0"'dan DEÐÝL , "1"'den baþlar!
	SUBSTRING(@email , 3 , 4) AS [SUBSTRING(@email , 3 , 4)] ,


	---------- CHARINDEX() Fonksiyonu ----------
	--	 "CHARINDEX" fonksiyonu da ; içerisine virgülden önceki yazdýðýmýz ifadenin , virgülden sonraki yazýlan
	-- ifadenin içinde , KAÇINCI SIRADA olduðunu söylüyor... Yani INDEX'ini söylüyor...
	-- Yani , CHARINDEX() Fonksiyonu ; içerisinde virgülden ÖNCE yazdýðýmýz ifadeyi , virgülden SONRAKÝ Kolonda
    -- arar... Ve o ifadeyi Kaçýncý Index'te bulduysa , O index'i de döner... (Saymaya da '1''den baþlar...!)
	----	NOTE  :	 Saymaya da "0"'dan DEÐÝL , "1"'den baþlar!
	CHARINDEX('@' , @email) AS [CHARINDEX('@' , @email)] ,

---- Step 1 ----
SELECT CustomerKey , CHARINDEX('5' , CustomerKey) as [INDEX]
FROM AdventureWorks_Sales_2017 ;

---- Step 2 ----
SELECT EmailAddress ,
	SUBSTRING(EmailAddress , CHARINDEX('-', EmailAddress) + 1 , 25) AS MailProvider
FROM AdventureWorks_Customers ;
		
		

	---------- 'Email Provider (DOMAIN)''i Bulalým : ----------

	--    ** provider == Saðlayan , Saðlayýcý , Karþýlayan. **

	--	 "CHARINDEX" ile "@" ifadesinin , kaçýncý karakterde olduðunu bulup , o kadar karakteri bütün metnin
	-- uzunluðundan kesersek , "domain"'imizi buluruz... Yani "alperceylan009@itu.edu.tr" metninin karakter
	-- uzunluðundan , "@" ifadesine kadar olan kýsmý tamamen kesersek sadece "@" sonrasý ifade kalýr... :

	--	 RIGHT (@email , METNÝN TAMAMI Eleman sayýsý  -  '@' VE ÖNCESÝNÝN Eleman sayýsý)   Yani ; 25 - 15 = 10
	RIGHT (@email , LEN(@email) - CHARINDEX('@' , @email)) as ["@"'den Sonrasý] ,

	CHARINDEX('.' ,  RIGHT (@email , LEN(@email) - CHARINDEX('@' , @email))) as [Noktanýn Sýrasý (Index'i)] ,

	LEFT(RIGHT(@email, LEN(@email) - CHARINDEX('@', @email))  ,  CHARINDEX('.', RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))) - 1) as Email_Provider_Domain ,


	--	 'Public Provider' mi? Diye de bakalým :
	IIF(LEFT(RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))  ,  CHARINDEX('.', RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))) - 1)
	IN ('gmail' , 'hotmail' , 'yahoo' , 'mynet' , 'outlook' , 'microsoft') , 1 , 0) AS is_Puclic_Provider ,


select * from AdventureWorks_Customers



	---------- LOWER() Fonksiyonu ----------
	--	 Hepsini küçük harf haline getirir :
	LOWER(@email) AS [LOWER(@email)] ,


	---------- UPPER() Fonksiyonu ----------
	--	 Hepsini büyük harf haline getirir :
	UPPER(@email) AS [UPPER(@email)] ,


	---------- RTRIM() Fonksiyonu ----------
	--	 Saðdaki(right) boþluklarý kaldýrýr :
	RTRIM(@email) AS [R-TRIM(@email)] ,
	

	---------- LTRIM() Fonksiyonu ----------
	--   Soldaki(left) boþluklarý kaldýrýr :
	LTRIM(@email) AS [L-TRIM(@email)] ,
	

	---------- REPLACE() Fonksiyonu ----------
	--	 "REPLACE" fonksiyonu ; içerisindeki ikinci deðeri , üçüncü deðer ile deðiþtirir :
	REPLACE(@email , '@' , '_') AS [REPLACE(@email , '@' , '_')] ;


----	NOTE  :	 Hazýr "String" Fonksiyonlarý , Solda Sýrasý ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	içerisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak Ýçin de Yukarýda Sýrasý ile :
----	View - Template Browser - Function -

----    NOTE  :  Boþ zamanlarýmýzda , Fonksiyon yaratma egzersizleri yapmamýzýn bize büyük katkýlarý olacaktýr..!

----------------------------------------------------------------------------------------------------------------------




-------------------- TARÝH FONKSÝYONLARI --------------------


----    NOTE  :  Programýmýzýn DÝLÝNÝ 'TÜRKÇE' yapmak istersek :
SET LANGUAGE TURKISH


----    'GETDATE()' Fonksiyonu ; TAM þu anýn Tarih ve Saatini verir...

----    'YEAR()' Fonksiyonu ; içerisine yazdýðýmýz atamanýn SADECE Yýlýný gösterir...

----    'DATEPART()' Fonksiyonu ; Bu fonksiyonun içerisine , Date'nin Hangi Parçasýný görmek istiyorsak onu yazýyoruz...

----    'DATENAME()' Fonksiyonu ; içerisine Date'nin Hangi Parçasýný yazarsak , o Date bilgisinin 'String' yazýlýþýný
---- gösteriyor...

----    'DATEDIFF()' Fonksiyonu ; iki TARÝH arasýndaki farký almak istiyorsak kullanýyoruz. Bu fonksiyonda
---- önemli olan þey ; iki Tarihin Hangi Parçalarýnýn Farkýný almak istiyorsak belirtmemiz gerektiðidir... Mesela
---- iki Tarihin aylarýnýn farkýný mý? Günlerinin farkýný mý? vb...
----    Mesela ;  " DATEDIFF(YEAR , ilk tarih , ikinci tarih) "  gibi... Mesela bunu hesaplayarak YAÞI
---- bulabiliyoruz...

----    'CONVERT()' Fonksiyonu ; Tarih Fonksiyonuna baktýðýmýzda , mesela 'GETDATE()' fonksiyonu
---- "yýl-ay-gün-saat-saniye..." þeklinde sýralýyor... Ama bu tüm Formatlarda bu þekilde sýralanmaz... Ülke ülke
---- bile deðiþiyor... Bu tarz farklýlýklarý düzenlemek için çeþitli FORMATLAR vardýr. Bunu da CONVERT() Fonksiyonu
---- ile yapýyoruz... Bu fonksiyon ; Ýki farklý date tipini , birbirleri ile yer deðiþtirir...
---- ('Yýl' ile 'Gün' bilgilerinin yer deðiþtirmesi gibi...)
----    CONVERT(Data TÝPÝ , Deðiþtirilecek DATE , FORMAT)

----    'DATEADD()' Fonksiyonu ; içerisine yazdýðýmýz Tarihler üzerinde matematiksel iþlemler yapmamýzý saðlar...
----    DATEADD(Date Yapýsý , Matematiksel Ýþlem , Tarih Bilgisi) AS DATE

----    'CAST()' Fonksiyonu ; DATE Tiplerinde çalýþýrken ; içerisine yazdýðýmýz Tarihin , Saat bilgilerini siler
---- sadece "Yýl-Ay-Gün" bilgilerini gösterir...

----    NOTE  :  Aþaðýdaki 'CONVERT()' Fonksiyonunun içerisindeki '104' sayýsý da , Tarihin sýralanmasýyla ilgili
----    FORMATLARDAN birinin gösterimidir... Bu FORMAT Komutlarýnýn listesi de :
----    https://www.sqlshack.com/sql-convert-date-functions-and-formats/   linkinde mevcuttur...


SELECT * FROM AdventureWorks_Customers
SELECT * FROM AdventureWorks_Returns
SELECT * FROM AdventureWorks_Sales_2017


DECLARE @BirthDate DATE = '1992-10-31'

SELECT
	GETDATE() AS [GETDATE( )] ,
	@BirthDate as [BirthDate] ,
	YEAR(@BirthDate) as [YEAR( )] , 
	DATEPART(YEAR , @BirthDate) as [DATEPART( )] ,
	DATEPART(MONTH , @BirthDate) as [DATEPART( )] ,
	MONTH(@BirthDate) as [MONTH( )] ,
	DATENAME(MONTH , @BirthDate) as [DATENAME( )] ,
	DATEDIFF(YEAR , @BirthDate , GETDATE()) as [DATEDIFF( )] ,
	CONVERT(VARCHAR(10) , @BirthDate , 104) as [CONVERT( )] ,
	CONVERT(VARCHAR(30) , GETDATE() , 114) as [CONVERT( )] ,
	CONVERT(VARCHAR(30) , GETDATE()) as [CONVERT( )] ,
	DATEADD(Day , -5 , GETDATE()) ,
	CAST(DATEADD(DAY , -5 , GETDATE()) AS DATE) ,
	CAST(DATEADD(YEAR , +3 , @BirthDate) AS DATE)


SELECT 
	GETDATE() ,
	DATEADD(DAY , + 2 , GETDATE()) ,
	DATEADD(MONTH , - 1 , GETDATE()) ,
	DATEDIFF(YEAR , '1980-01-01' , GETDATE()) ,
	DATENAME(dw , GETDATE()) ,
	CONVERT(VARCHAR(20) , GETDATE() , 104)


--------------- Veri Tabaný ile Tarih Farklýlýðý Fonksiyonu ---------------

----    NOTE  :  'DATEDIFF()' Fonksiyonu ; iki tarih arasýndaki farký almak istiyorsak kullanýyoruz. Bu fonksiyonda
----    önemli olan þey ; iki tarihin Hangi Parçalarýnýn Farkýný almak istiyorsak belirtmemiz gerekiyor... Mesela
----    iki tarihin aylarýnýn farkýný mý? Günlerinin farkýný mý? vb.
----    Mesela ;  " DATEDIFF(YIL , ilk tarihin yýlý , ikinci tarihin yýlý) "  gibi... Mesela bunu hesaplayarak YAÞI
----    bulabiliyoruz...

--   Aþaðýda , 'OrderDate' ile 'StockDate' arasýndaki gün farkýný bulmak istiyoruz ve Farkýn '4850' günden fazla
-- olduðu satýrlarý Filtreleyip döndürmek istiyoruz... :
SELECT CustomerKey , StockDate , OrderDate ,      
	DATEDIFF(day , StockDate , OrderDate) AS NumberOfDays 
FROM AdventureWorks_Sales_2017
WHERE DATEDIFF(DAY , StockDate , OrderDate) > 4850 ;


--------------- Tarih Gösterim Formatlarý ---------------
----    https://www.sqlshack.com/sql-convert-date-functions-and-formats/

SELECT   
	CONVERT(VARCHAR(12), GETDATE(), 111) AS DATE_1,
	CONVERT(VARCHAR(12), GETDATE(), 104) AS DATE_2,
	CONVERT(VARCHAR(20), GETDATE(), 114) AS DATE_3





-------------------- TABLO ÝÇERÝSÝNDE MATEMATÝKSEL HESAPLAMALAR --------------------

--    ** aggregate == Yýðýþým , Kümelenmek , Toplanmak , Hepsi , Topluluk. **

----	NOTE  :	 Hazýr Ýstatistiksel Ýþlem Fonksiyonlarý , Solda Sýrasý ile :
----	Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions - System Functions -
----    Aggregate Functions...  Ýçerisindedir...


--------------- 'RANDOM' SAYI ---------------

--    'RAND()' Fonksiyonu ile ; her çalýþtýrmamýzda bize Rastgele bir sayý üretiyor...

SELECT CAST(RAND() * 10 AS INT) + 1;



SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

--------------- Aggregation (Toplama , Kümeleme , Birleþtirme) 1 ---------------

--   TOPLAM Müþteri sayýmýza bakalým... Yani SAYDIRALIM... Bunun için 'COUNT()' Fonksiyonunu kullanabiliriz... :
SELECT COUNT(*) AS CustometKey
FROM AdventureWorks_Customers;


--    ** territory == Faaliyet alaný , Yetki alaný , Alan , Bölge. **

--    'DISTINCT()' Fonksiyonu ; içerisine yazdýðýmýz Kolonun BENZERSÝZ elemanlarýný bulur...

--   'TerritoryKey' Kolonunun deðerlerini, BENZERSÝZ bir þekilde SAYDIRMAK istiyorsak da 'DISTINCT()' Fonksiyonunu
-- kullanacaðýz... :

SELECT DISTINCT(Occupation) From AdventureWorks_Customers

SELECT COUNT(DISTINCT(Occupation)) FROM AdventureWorks_Customers

SELECT COUNT(DISTINCT(TerritoryKey)) FROM AdventureWorks_Sales_2017



--------------- Aggregation (Toplama , Kümeleme , Birleþtirme) 2 ---------------

--    'CAST()' Fonksiyonu ; Data Tiplerinin (Type) deðiþimini bu fonksiyon ile yapabiliriz... KOD'un sonunda hangi
-- Data Tipini istediðimizi yazmalýyýz...
--    'CONVERT()' Fonksiyonu ; Data Tiplerinin (Type) deðiþimini bu fonksiyon ile de yapabiliriz... Ýçerisinde ilk
-- önce , hangi Data Tiðini istediðimizi yazmalýyýz...

--    ** round == Yuvarlak , Devir. **

--    'ROUND()' Fonksiyonu ; Bu fonksiyon , içerisine yazdýðýmýz NUMERÝK deðeri , Ýstediðimiz Yere (Basamaða) Kadar
-- YUVARLAMAMIZI saðar.

--    'SUM()' Fonksiyonu ; bir deðerin TOPLAMINI almak istiyorsak 'SUM()' Fonksiyonunu kullanýrýz...

----    NOTE  :  'SUM()' Fonksiyonunu kullanabilmemiz için , içerisine yazdýðýmýz deðerin NUMERIK olmasý ÞARTTIR !
----    Bunun için de burada öncelikle 'OrderQuantity' Kolonunun Tipini deðiþtireceðiz... :
ALTER TABLE AdventureWorks_Sales_2017 ALTER COLUMN OrderQuantity INT


--   Sonra da , 'OrderQuantity' Tablomda kaç kayýt var? Ve buna karþýlýk TOPLAM 'OrderQuantity' adeti nedir? Bakalým :
-- Yani , KAÇ Sipariþe karþýlýk KAÇ adet Ürün satýlmýþ? Bakalým : 
SELECT COUNT(*) , SUM(OrderQuantity) , cast(SUM(OrderQuantity) AS VARCHAR(10))
FROM AdventureWorks_Sales_2017 ;

--   Her sipariþte ORTALAMADA kaç tane ürün gitmiþ bakalým :
SELECT COUNT(*) , SUM(OrderQuantity) , SUM(OrderQuantity) / COUNT(*)  AS TotalProductsOrdered
FROM AdventureWorks_Sales_2017 ;
----    NOTE  :  Yukarýdaki iþlemden sonra sonuç olarak '1' döndürdü... Çünkü INTEGER Tipinde bir iþlem yaptýðý için
----    TAMSAYI bir sonuç verdi... Ama biz böyle bir sonuç istemiyoruz... Bunun için 'ROUND()' Fonksiyonu
----    kullanýlabilir :
SELECT COUNT(*) , SUM(OrderQuantity) , ROUND(CAST(SUM(OrderQuantity) AS FLOAT) / CAST(COUNT(*) AS FLOAT) , 4)
FROM AdventureWORKS_Sales_2017 ;


--------------- Aggregation (Toplama , Kümeleme , Birleþtirme) 3 ---------------

----    NOTE  :  'MAX()' - 'MIN()' - ... vb. Ýstatistiki Fonksiyonlarýný bir Kolon üzerinde kullanabilmek için ;
----    o Kolonun verilerinin TAMAMEN NUMERÝK veri içeriyor olmasý gerekiyor...
----    BURAYA GERÝ DÖNÜP BU PROBLEMÝ TEKRAR ÇÖZMEMÝZ GEREKECEK... Çünkü aþaðýda DOLAR iþaretini kaldýrmamýz gerekiyor...

--   En Pahalý ürünü bulmak için de 'MAX()' Fonksiyonunu kullanabiliriz...
SELECT MAX(AnnualIncome) AS MostExpensivePrice    
FROM AdventureWorks_Customers; 


--------------- Aggregation (Toplama , Kümeleme , Birleþtirme) 4 ---------------

--    ** freight == Nakliye. **

SELECT AVG(AnnualIncome) AS AverageAnnualIncome 
FROM AdventureWorks_Customers;  


----    NOTE  :  Þimdiye kadarki hesaplamalarýn tamamýnda hep TEK Satýrlýk sonuçlar döndürdük... AMA bu hesaplamalarý
----    belli bir Filtreye göre yapmak istiyorsak ; Þehirlere Göre , Ürünlere Göre , Zamana Göre , ... Bir þeye Göre ...
----    yapmak istiyorsak , 'GROUP BY' komutunu kullanmamýz gerekiyor... Yani bu hesaplamalarý Neye Göre yapmasýný
----    istediðimizi belirtmemiz gerekiyor...
----    Yani 'Aggregate' Fonksiyonlar kullanýrken , "Baþka Bir Deðere Göre" bir hesaplama yapmak istiyorsak , muhakkak
----    'GROUP BY' ile yazmamýz gerekiyor...


------------------------- GROUP BY -------------------------

SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

--------------- Aggregation (Toplama , Kümeleme , Birleþtirme) 5 ---------------

ALTER TABLE AdventureWorks_Customers ALTER COLUMN CustomerKey INT

----    NOTE  :  Yukarýdaki gibi Ýstatistiki ve / veya Matematiksel hesaplamalarý belli bir FÝLTREYE göre yapmak
----    istiyorsak (Þehirlere göre, Ürünlere göre, müþteri yaþýna göre, Zamana göre, ... vb...) ve ayný zamanda hepsini
---- BÝR ARADA görmek istiyorsak ; 'GROUP BY' Komutunu kullanýyoruz...

----    NOTE  :  'GROUP BY' Komutunu kullanmazsak bir hata alýyoruz... Bunun da sebebi SQL'in çok da akýllý
----    olmamasýndandýr... Program ; bu hesaplamalarý neye göre yapacaðýný bilmiyor... Bu Aritmetik hesaplamanýn
----    dýþýndaki (çevresindeki) alanýmýzý , 'GROUP BY' ile tanýmlamamýz gerekiyor...

----    NOTE  :  KOD Bloðunda yazdýðýmýz KAÇINCI Ýfadeye göre sýralamak istiyorsak , onu da 'ORDER BY' Komutu ile
---     belirliyoruz...

SELECT 
	LastName ,
	MIN(CustomerKey) AS Minimum ,        
	MAX(CustomerKey) AS Maximum ,        
	AVG(CustomerKey) AS Average    
FROM AdventureWorks_Customers
GROUP BY LastName
ORDER BY 2 DESC



------------------------- HAVING -------------------------

----    NOTE  :  Filtrelemelerde 'FROM''dan sonra WHERE komutunu yazarak mesela , Þehir Ankara'ya eþit ise þunu þunu
----    yap , Deðilse de þunu þunu yap gibi þeyler yazabiliyorduk... HESAPLAMALARDA bir Filtreleme yapmak istiyorsak da,
----    'HAVING' komutunu kullanýyoruz...

--    Mesela , Eðitim Seviyelerine göre Toplam kaç tane müþteri var görmek istiyoruz :
SELECT COUNT(*) AS CountOfEducationLevel , EducationLevel
FROM AdventureWorks_Customers
GROUP BY EducationLevel;

--    --    Mesela , Eðitim Seviyelerine göre , Toplamda 3000'den fazla müþteri olan Eðitim Seviyelerini görmekistiyoruz :
SELECT COUNT(*) AS CountOfEducationLevel , EducationLevel
FROM AdventureWorks_Customers
group by EducationLevel
HAVING count(*) > 3000 


--------------- HAVING COUNT(*) > 3 ; ---------------

---------- Benzersiz (Unique) Sayým ----------
SELECT COUNT(DISTINCT CustomerKey) AS CountOfCustomerKey , EducationLevel    
FROM AdventureWorks_Customers    
GROUP BY EducationLevel;



------------------------- IF CLAUSE -------------------------

----    NOTE  :  Hatýrlarsak "IIF" fonksiyonunu TEK SATIRDA yazabiliyorduk... Ýçerisindeki ilk eleman ile koþulumuzu
----    belirtiyorduk. O koþul Doðru ise Ýkinci elemanda , yapýlmasý gerekeni yazýyorduk. O koþul Yalnýþ ise de
----    Üçüncü elemanda , yapýlmasý gerekeni yazýyorduk...

--    Öncelikle , Bugün günlerden ne? Ona bakalým :
SELECT DATENAME(weekday, GETDATE())


--    Aþaðýda , EÐER bugün günlerden 'Saturday' veya 'Sunday' ÝSE 'Weekend' döndür ; DEÐÝLSE 'Weekday' döndür diyoruz...
SELECT IIF(DATENAME(weekday, GETDATE()) IN ('Saturday', 'Sunday') , 'Weekend' , 'Weekday') AS TODAY


----    NOTE  :  Özellikle Parametre olarak iþlem yaptýðýmýzda ; Birden Fazla Satýr ve / veya Birden Fazla Koþul
----    belirttiðimiz zamanlarda  "IF  -  ELSE  -  ELSE IF"  komutlarýný kullanýyoruz...

IF DATENAME(weekday, GETDATE()) IN ('Saturday', 'Sunday')
       SELECT 'Weekend' AS TODAY;
ELSE 
       SELECT 'Weekday'AS TODAY;



SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

------------------------- CASE - WHEN (DURUM - ZAMAN) Örneði 1 -------------------------

--    ** odd == Tek sayý , Acayip , Garip , Tuhaf. **
--    ** even == Çift sayý , Düzgün , Pürüzsüz , Eþit , Bile. **

----    NOTE  :  Çok fazla Koþulumuz varsa da ; her defasýnda 'ELSE - IF' kullanmak yerine "CASE - WHEN" komutlarýný
----    kullanabiliyoruz...

SELECT TerritoryKey ,
	CASE TerritoryKey % 2
	WHEN 0 THEN 'Even' ELSE 'Odd' END
FROM AdventureWorks_Sales_2017 ;


------------------------- CASE - WHEN (DURUM - ZAMAN) Örneði 2 -------------------------

SELECT CustomerKey , ProductKey ,
	CASE
	WHEN ProductKey BETWEEN 0 AND 99 THEN 'Under 100'
	WHEN ProductKey BETWEEN 100 AND 199 THEN '100-199'
	WHEN ProductKey BETWEEN 200 AND 299 THEN '200-299'
	WHEN ProductKey BETWEEN 300 AND 399 THEN '300-399'
	WHEN ProductKey BETWEEN 400 AND 499 THEN '400-499'
	ELSE '500 and over' end AS range
FROM AdventureWorks_Sales_2017 ;


--   'AdventureWorks_Customers' Tablomuzun ÝLK 10 Satýrýný gösterelim :
Select TOP 10 * FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
--   OR :
SELECT TOP 10 * FROM AdventureWorks_Customers


--   Müþterilerimizi , Yaþ Daðýlýmýna göre sýnýflandýralým :
SELECT
	CASE
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 0 AND 20 THEN 'Under 20'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
		ELSE '70 +'
	END AS AgeGroup , COUNT(*)
FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
GROUP BY
	CASE
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 0 AND 20 THEN 'Under 20'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
		WHEN DATEDIFF(YEAR, [BirthDate], GETDATE()) BETWEEN 61 AND 70 THEN '61-70'
		ELSE '70 +'
	END
--    NOTE  :  Yukarýda , 'GROUP BY' komutunu kullanmamýzýn sebebi , COUNT() iþlemi gerçekleþtirmemizdir...



--    ** horoscope == Burç. **

--    Burç Bulma iþlemi yapabiliriz :

----    NOTE  :  Burada iþ biraz deðiþiyor. Çünkü Burç dediðimiz þeylerin Tarih Aralýklarý sabit deðil... Bunun için
----    de 'CAST()' iþlemi yapmak gerekiyor... Çünkü , Tarih iþlemlerinde CAST() fonksiyonunu kullanabiliyoruz...
----    Ve ayrýca burç hesapladýðýmýz için, 'Yýlý' bir kenara býrakýp kullanmamak istiyoruz...
----    Aslýnda hepsinin Yýlýný sabitlemeye çalýþacaðýz... Bunu da , '1900' yýlýna sabitleyerek yapalým... Çünkü
----    bildiðimiz gibi Burçlarýn sabit tarihleri var ama hep birbirlerinden farklý aralýklardalar. Ve bundan dolayý
----    Yýl Geçiþlerinde problemler çýkabilir... Bu yüzden Yýlý ekarte etmek için tüm doðum yýllarýný mesela '1900'
----    yýlýna sabitleyeceðiz...

----    NOTE  :  Tam Þu Anýn Tarihinden , 01/01/1900 Tarihini çýkarmak istiyoruz... Matematiksel bir iþlem yapmak
----    istediðimiz için 'DATEADD()' fonksiyonunu kullanacaðýz :
SELECT DATEDIFF(YEAR , '19000101' , GETDATE())
SELECT DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', GETDATE()) , GETDATE())

SELECT CAST('19000321' AS DATETIME)

SELECT TOP (1000) [CustomerKey] , [Prefix] , [FirstName] , [LastName] , [BirthDate] ,
	CASE 
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000321' AS DATETIME) AND CAST('19000419' AS DATETIME) THEN 'Ares'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000420' AS DATETIME) AND CAST('19000520' AS DATETIME) THEN 'Taurus'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000521' AS DATETIME) AND CAST('19000620' AS DATETIME) THEN 'Gemini'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000621' AS DATETIME) AND CAST('19000722' AS DATETIME) THEN 'Cancer'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000723' AS DATETIME) AND CAST('19000822' AS DATETIME) THEN 'Leo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000823' AS DATETIME) AND CAST('19000922' AS DATETIME) THEN 'Virgo'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000923' AS DATETIME) AND CAST('19001022' AS DATETIME) THEN 'Libra'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001023' AS DATETIME) AND CAST('19001121' AS DATETIME) THEN 'Scorpio'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001122' AS DATETIME) AND CAST('19001221' AS DATETIME) THEN 'Sagittarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19010101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19001222' AS DATETIME) AND CAST('19010119' AS DATETIME) THEN 'Capricorn'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000120' AS DATETIME) AND CAST('19000219' AS DATETIME) THEN 'Aquarius'
		WHEN DATEADD(YEAR , -DATEDIFF(YEAR, '19000101', [BirthDate]) , [BirthDate]) BETWEEN CAST('19000220' AS DATETIME) AND CAST('19000320' AS DATETIME) THEN 'Pisces'
	END AS [Horoscope]
  FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
  WHERE YEAR([BirthDate]) > 1940

----    NOTE  :  DATA ÇEKME kýsmý buraya kadardý...

----    NOTE  :  Sýk sýk alýþtýrmalar yapmamýz gerekiyor... Bunun için KAGGLE sitesini kullanabiliriz... Oradaki
----    Data Setlerine girip Filtreleyerek istediðimiz bir Data Seti indirebiliriz... Ve bu Data Setin üzerinde
----    çalýþabiliriz...

----    NOTE  :  Mesela 'CSV' dosyalarýný 'SQL Server''de açabilmek için bir çok yöntem vardýr... Bunlarý 'Youtube''de
----    aratarak da bulabiliriz... 'Youtube''ye; "CSV import SQL Server'" yazýp aratabiliriz...
----    NOTE  :  'CSV' dosyalarýný SQL Server'de açabilmek için bir yöntem ;
----    Mesela Soldaki 'AdventureWorks1' Veri Tabanýna SAÐ Týklayýp , 'Tasks''a gelip , 'Import Flat Files''e týklayýp ,
----    'CSV' dosyalarýný yükleyebiliriz... 'CSV''lerin içerisindeki her bir Satýra , INSERT INTO komutunu
----    hazýrlayabiliriz...





------------------------- JOIN -------------------------

--------------- Inner Join (Ýç Birleþim)---------------

--   Þimdiye kadar tüm hesaplamalarý da , filtrelemeleri de TEK BÝR Tablo üzerinde yaptýk... Ama Ýliþkisel Veri
-- Tabanlarýnda veriyi tutma amacýmýz , Parçalara bölmek ve bir yerde 'Primary Key''ler diðer yerde 'Foreign Key''ler
-- ile datalarý sonrasýnda birleþtirmek üzerine bir mentalitemiz vardý... Buna da NORMALÝZASYON yöntemi deniyordu...

-- Veri Ambarlarýndaki asýl amaç ise veriyi saklamak deðil de Analiz etmek olduðu için , orada da tam tersi olarak
-- DENORMALÝZE diye bir yöntem vardýr...


SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

--   Mesela yukarýda , daha önce bölünen iki tane Tablomuz vardýr... Bu iki Tabloyu birbirine baðlayarak bir Data Set
-- oluþturmak isteyebiliriz... Bu iþlemleri 'JOIN' metodu ile yapýyoruz... Eðer sadece 'JOIN' yazarak iþlem yaparsak ,
-- sunucu DEFAULT olarak 'INNER JOIN' kullanýyor...

--   INNER JOIN  :  Eðer iki Tablonun (Kümenin) Sadece KESÝÞÝM (ORTAK) KOLONLARINI getirmek istiyorsak kullanýrýz...

--   LEFT JOIN  :  Eðer SOLDAKÝ Kümenin (Tablonun) TAMAMINI Kapsasýn istiyorsak kullanýrýz...

--   RIGHT JOIN  :  Eðer SAÐDAKÝ Kümenin (Tablonun) TAMAMINI Kapsasýn istiyorsak kullanýrýz...

--   CROSS JOIN  :  TÜM Kümeleri (Tablolarý) Kapsasýn istiyorsak kullanýrýz... Ama bu metod pek kullanýlmaz...


----    NOTE  :  'FROM' komutundan sonra yazdýðýmýz Tablo ismine Kýsa Bir Ýsim vermek istersek , Sonrasýnda 'AS'
----    komutunu kullanarak bunu yapabiliriz... Mesela Aþaðýda "AdventureWorks_Customers" Tablomuza kýsaca 'C' ismini
----    veriyoruz...

----    NOTE  :  'FROM' komutundan sonraki yazdýðýmýz Tablo , LEFT Tablomuz oluyor...
----	NOTE  :  'JOIN' metodundan sonraki yazdýðýmýz Tablo da , RIGHT Tablomuz oluyor...

--   'ON'  Komutu  :  Mesela , INNER JOIN kullanarak iki Tablonun Kesiþim Kümesini almak istiyoruz... AMA bu iþlemi
-- NEYE GÖRE (Hangi Kolon veya Kolonlara Göre) yapacaðýmýzý belirlemek için de  'ON'  komutunu kullanýyoruz...

SELECT C.CustomerKey , BirthDate , FirstName , LastName
FROM AdventureWorks_Customers AS C
INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey ;

--   Yukarýda , "AdventureWorks_Customers" Tablomuzun 'CustomerKey' Kolonu ile , "AdventureWorks_Sales_2017"
-- Tablomuzun 'CustomerKey' Kolonunu ; INNER JOIN Türünde birbirlerine baðladýk... Yani sadece KESÝÞÝM KÜMELERÝNÝ aldýk.

----    NOTE  :  Yukarýdaki iki tabloda da Ayný Ýsme sahip Kolonlar olduðu için , Tablolardaki birleþtirmek istediðimiz
-- Kolonlardan SADECE birini SELECT komutu içerisinde yazabiliyoruz. Biz 'C.CustomerKey' Kolonunu yazdýk...
-- Diðer Kolonlar için böyle bir þey yapmamamýzýn sebebi , o kolonlarýn SADECE "AdventureWorks_Customers" Tablosunda
-- var olmasýdýr...


--   Aþaðýda , RIGHT JOIN metodu ile "AdventureWorks_Sales_2017" Tablosunun TAMAMINI getir diyoruz. Ve beraberinde
-- "AdventureWorks_Customers" Tablosunun Sadece KESÝÞENLERÝNÝ görmek istiyoruz... Ve bu iþlemi yaparken 'CustomerKey'
-- Kolonlarýna göre bir birleþtirme (Join) yapmak istiyoruz...
SELECT S.* , BirthDate , FirstName , LastName
FROM AdventureWorks_Customers AS C
RIGHT JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey ;


----    NOTE  :  Mesela bir örnek vermek gerekirse ; Trendyol'un 10m kullanýcýsý 150m da sipariþi var. Bu 150m sipariþi
----    'COUNT Listing' ile saydýrarak ; 10m kullanýcýdan 8m tanesinin sipariþ vermiþ olduðunu görürüz... 2m kullanýcý
----    hiç sipariþ vermemiþ... Bu tüm kullanýcýlarýn olduðu Tablo ile sadece sipariþ veren kullanýcýlarýn olduðu Tabloyu
----    INNER JOIN yaparak kullanýcýlarý saydýrýrsak bu bize 8m kiþiyi verir... Eðer LEFT JOIN yaparak sipariþleri
----    saydýrýrsak bu bize 10m kiþiyi verir ve aradaki 2m sipariþ vermeyen kullanýnýn yanýnda da sipariþ sayýsý olarak
----    NULL deðer döner...


----    NOTE  :  Çok fazla tablo olduðunda , istediðimiz tabloyu bulmakta zorlanýyorsak Filtreleyerek bulabiliriz...
----    Bunun için de ; Veri Setimizin (AdventureWorks1) içerisindeki  'Tables'  klasörüne Sað týklayýp , sonrasýnda
----    'Filter''e  týklayýp , sonrasýnda da  'Filter Settings''e  týklayabiliriz. Açýlan pencerede de ne tarz bir
----    Filtreleme yapmak istiyorsak o 'Property''in 'Value' kýsmýna týklayýp yazabiliriz...

--    ** property == Özellik **





--------------- ???  Multiple Inner Join (Çoklu Ýç Birleþtirme)  ??? ---------------

-- Video 1.8 , 23.30 dakikadan itibaren... -->

-- Bunu baþka Veri Seti ile çalýþ..! Þu an kullandýðýmýz Veri Seti ile olmadý... Aþaðýsý yanlýþ...

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;
SELECT * FROM AdventureWorks_Returns ;

SELECT S.CustomerKey , S.TerritoryKey , C.FirstName , C.LastName , 
	COUNT(DISTINCT(S.ProductKey))

FROM AdventureWorks_Sales_2017 AS S    
	INNER JOIN AdventureWorks_Customers AS C  ON C.CustomerKey = S.ProductKey
INNER JOIN AdventureWorks_Returns AS R  ON R.ProductKey = S.ProductKey
---- Filtreleme -->
WHERE
	(C.FirstName LIKE '%a%')
	OR
	(C.Prefix = 'MR' AND YEAR(R.ReturnDate)>1/1/2010)

GROUP BY S.CustomerKey, S.OrderNumber, S.TerritoryKey,        
	C.FirstName, C.Prefix,        
	C.LastName
---- Filtreleme -->
HAVING COUNT(DISTINCT(S.ProductKey))>150

----    NOTE  :  Eðer 'COUNT' gibi bir Fonksiyon kullanýyorsak, göstermek istediðimiz alanlara göre 'GROUP BY'
----    kullanmamýz gerekir...

SELECT 
FirstName, COUNT(*) 
FROM [dbo].[DimCustomer] 
GROUP BY FirstName
HAVING COUNT(*) > 15




--------------- Left Join (Sol Yönden Katýlým) ---------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

-- INNER JOIN ile yapalým :
SELECT 
C.CustomerKey , C.LastName , S.OrderNumber , COUNT(DISTINCT(ProductKey)) AS Unique_ProductKey_Count
FROM AdventureWorks_Customers AS C
INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
GROUP BY C.CustomerKey , C.LastName , S.OrderNumber
HAVING COUNT(DISTINCT(ProductKey)) < 5

-- LEFT JOIN ile yapalým :
SELECT 
C.CustomerKey , C.LastName , S.OrderNumber , COUNT(DISTINCT(ProductKey)) AS Unique_ProductKey_Count
FROM AdventureWorks_Customers AS C
LEFT JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
GROUP BY C.CustomerKey , C.LastName , S.OrderNumber
HAVING COUNT(DISTINCT(ProductKey)) < 5

----    NOTE  :  Yukarýda gördüðümüz gibi , LEFT JOIN ile yaptýðýmýzda 'NULL' deðerler de döndü...



--------------- Cross Join (Çapraz Birleþtirme) ---------------
SELECT C.CustomerKey , C.LastName , S.OrderNumber
FROM AdventureWorks_Customers AS C
CROSS JOIN AdventureWorks_Sales_2017 AS S;





SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

----    NOTE  :  Sorgularýmýzýn içerisinde mutlak bir deðer vermek veya LIKE gibi komutlarý kullanmak yerine ,
----    baþka bir sorgumuzu da Filtre olarak kullanabiliriz... :

--------------- Özel Sorgu Sonucunun Filtrelenmesi 1 ---------------

-- Aþaðýda , Sadece 'sipariþ veren' CustomerKey'leri görmek istiyoruz...
----    NOTE  :  INNER JOIN ile ayný iþlemi yapýyor ama Yapýsal olarak Farklý çalýþýyor...

SELECT CustomerKey , LastName
FROM AdventureWorks_Customers
WHERE CustomerKey IN
	(SELECT DISTINCT CustomerKey FROM AdventureWorks_Sales_2017);



--------------- Özel Sorgu Sonucunun Filtrelenmesi 2 ---------------

-- Aþaðýda , Sadece 'sipariþ vermeyen' CustomerKey'leri görmek istiyoruz...

SELECT CustomerKey , LastName
FROM AdventureWorks_Customers
WHERE CustomerKey NOT IN (
	SELECT CustomerKey
	FROM AdventureWorks_Sales_2017
	WHERE CustomerKey IS NOT NULL ) ;



--------------- Ýki Farklý Veri Setinin Birleþtirilmesi ---------------

--    'UNION' Komutu  ::  Ýki tabloyu , TEK bir tablo olarak göstermek istiyorsak ; 'UNION' komutu ile bu iki tabloyu
-- birbirlerine baðlýyoruz...
-- Yani ilk yazýlan Kolon isminin altýnda , her iki kolonu alt alta sýralýyoruz...

SELECT DISTINCT OrderNumber
FROM AdventureWorks_Sales_2017
UNION ALL
SELECT EmailAddress
FROM AdventureWorks_Customers ;

----    NOTE  :  Burada rastgele bir birleþtirme iþlemi yaptým ama mesela , genellikle bazý þirketlerde 'Person'
----    tablosu ile 'Customer' tablosu ayrý ayrý tablolarda olabiliyor... Bu iki tabloyu birleþtirmek için bu
----    'UNION' komutunu kullanabiliyoruz...





----    NOTE  :  Þimdiye kadar hep FROM komutundan sonra bir Tablo ismi verdik ve Tabloyu okuttuk...
----		FROM içerisinde ; bizim için önemli olan bir Sorguyu , Tablo gibi de kullanabiliriz...
----		Yani bütün tablolarý tek tek okutmak yerine , bir Sorguyu Filtreleyerek elimizde bir Data Set oluþturup ,
----    bu Data Seti de tekrar Tablo gibi davrandýrtmak istiyorsak ; FROM komutundan sonra Parantez içerisinde
----    Sorgumuzu yazmamýz gerekiyor... :

SELECT DISTINCT Q.[OrderNumber]
FROM
(
	SELECT OrderNumber
	FROM AdventureWorks_Sales_2017
	UNION ALL
	SELECT EmailAddress
	FROM AdventureWorks_Customers
	
) AS Q ;


SELECT * FROM AdventureWorks_Product_Categories;
SELECT * FROM AdventureWorks_Product_Subcategories;

select * from
	AdventureWorks_Product_Categories as cate inner join AdventureWorks_Product_Subcategories as sub
		on cate.ProductCategoryKey = sub.ProductCategoryKey


select * from
	sales.SalesOrderHeader as s inner join
		(
			SELECT * FROM sales.SalesOrderDetail where LineTotal>1000
		) as x
			on s.SalesOrderID = x.SalesOrderID





SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

--------------- Derived Table (Türetilmiþ Tablo) ---------------

-- Fiziksel bir Tablo deðil de , bir Sorguyu Tablo gibi davrandýrtma iþlemine Drived Table deniyor...

-- Derived Table de , günlük hayatta sýklýkla kullanacaðýmýz iþlemlerden birisidir...

SELECT C.LastName , C.BirthDate , C.CustomerKey
FROM AdventureWorks_Customers AS C
INNER JOIN (
	SELECT OrderNumber , CustomerKey
	FROM AdventureWorks_Sales_2017 where CustomerKey>15000 
		   ) AS SLS
				ON C.CustomerKey = SLS.CustomerKey ;





----------------------------------------------------------------------------------------------------------------------





--------------- Custom Query (Özel Sorgu) ---------------
SELECT COUNT(*) AS CountOfOrders, FirstName,        
	MiddleName, LastName    
FROM Person.Person AS P    
INNER JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID    
INNER JOIN Sales.SalesOrderHeader        
	AS SOH ON C.CustomerID = SOH.CustomerID    
GROUP BY FirstName, MiddleName, LastName; 




--------------- Hücresel Sýralama 1 ---------------
SELECT ProductID, ProductSubcategoryID, Name
	,ROW_NUMBER() OVER(ORDER BY ProductID desc) AS RowNum    
FROM Production.Product    
WHERE ProductSubcategoryID IS NOT NULL;  

SELECT 
ROW_NUMBER() OVER(ORDER BY ListPrice DESC) AS Rank,*
FROM Production.Product    
WHERE ProductSubcategoryID IS NOT NULL;  


SELECT 
ROW_NUMBER() OVER(PARTITION BY Color ORDER BY ListPrice DESC) AS Rank,*
FROM Production.Product    
WHERE ProductSubcategoryID IS NOT NULL;  




--------------- Hücresel Sýralama 2 ---------------
SELECT Mef.*
FROM
(
SELECT ProductID, ProductSubcategoryID, Name,      
	ROW_NUMBER() OVER(PARTITION BY ProductSubCategoryID    
		ORDER BY ProductID) AS RowNum    
FROM Production.Product    
WHERE ProductSubcategoryID IS NOT NULL
) AS Mef  
ORDER BY Mef.RowNum


SELECT SUB.Name AS [SubCategory Name],        
	P.Name AS [Product Name], ProductID, Color    
FROM Production.Product P    
JOIN Production.ProductSubcategory SUB        
	ON P.ProductSubcategoryID = SUB.ProductSubcategoryID    
WHERE (SUB.Name LIKE '%mountain%' OR P.name like '%mountain%')        
	AND Color = 'Silver';   

-- CREATE TABLE MefRemote (FirstName VARCHAR(4000) , LastName CHAR(20) , Comment TEXT)

--------------- Contains 1 ---------------
SELECT ProductID, Comments    
FROM Production.ProductReview    
WHERE CONTAINS(Comments,'anger');   

--------------- Contains 2 ---------------
SELECT Title, FileName    
FROM Production.Document    
WHERE CONTAINS(*,'reflector');   


--------------- Contains 3 ---------------
SELECT Title, FileName    
FROM Production.Document    
WHERE CONTAINS(*,'reflector AND NOT seat');  


--------------- Deðiþken Tanýmlama 1 ---------------
DECLARE @myInt INT = 10;    
PRINT @myInt;   

--------------- Deðiþken Tanýmlama 2 ---------------
DECLARE @myString VARCHAR(20) = 'This is a test';    
PRINT @myString;   


--------------- Deðiþkenlere Sorgu Sonucundan Deðer Atama ---------------
DECLARE @MaxID INT, @MinID INT;

    
SELECT @MaxID = MAX(SalesOrderID),        
	@MinID = MIN(SalesOrderID)    
FROM Sales.SalesOrderHeader; 

SELECT @MinID, @MaxID
   
PRINT CONCAT('Max: ', @MaxID);    
PRINT CONCAT('Min: ', @MinID); 

--    2018 yýlýnda kaç spor içeriði üretmiþim ?
SELECT COUNT(*)
FROM [Content].[dbo].[All_Content]
WHERE 
	[Is_Spor] = 1 AND
	YEAR([CreatedDate]) = 2018

--------------- AYLARA GORE ICERIK SAYISI ---------------
SELECT 
	MONTH([CreatedDate]) AS MonthN, 
	DATENAME(MONTH,[CreatedDate]) AS MonthName, 
	COUNT(*) AS ContentCount
FROM [Content].[dbo].[All_Content]
WHERE 
	[Is_Spor] = 1 AND
	YEAR([CreatedDate]) = 2018
GROUP BY MONTH([CreatedDate]),DATENAME(MONTH,[CreatedDate])



SELECT 
	MONTH(C.[CreatedDate]) AS MonthN, 
	DATENAME(MONTH,C.[CreatedDate]) AS MonthName, 
	COUNT(*) AS FTContentCount,
	Q.ContentCount AS TotalContent
FROM [Content].[dbo].[All_Content] AS C 
INNER JOIN
(
	SELECT 
		MONTH([CreatedDate]) AS MonthN, 
		DATENAME(MONTH,[CreatedDate]) AS MonthName, 
		COUNT(*) AS ContentCount
	FROM [Content].[dbo].[All_Content]
	WHERE 
		[Is_Spor] = 1 AND
		YEAR([CreatedDate]) = 2018
	GROUP BY MONTH([CreatedDate]),DATENAME(MONTH,[CreatedDate])
) AS Q
ON MONTH(C.[CreatedDate]) = Q.[MonthN]
WHERE 
	C.[Is_Spor] = 1 AND
	YEAR(C.[CreatedDate]) = 2018 AND
	(C.[Title] LIKE '%Fatih%Terim%' OR C.[Ancestors_Title] LIKE '%Fatih%Terim%')
GROUP BY MONTH(C.[CreatedDate]),DATENAME(MONTH,C.[CreatedDate]), Q.ContentCount


SELECT 
	MONTH(C.[CreatedDate]) AS MonthN, 
	DATENAME(MONTH,C.[CreatedDate]) AS MonthName, 
	COUNT(*) AS ContentCount,
	SUM(IIF(C.[Title] LIKE '%Fatih%Terim%' OR C.[Ancestors_Title] LIKE '%Fatih%Terim%',1,0)) AS FTContent,
	SUM(IIF(C.[Title] LIKE '%galatasa%' OR C.[Ancestors_Title] LIKE '%galatasa%',1,0)) AS GSContent,
	SUM(IIF(C.[Title] LIKE '%fenerbah%' OR C.[Ancestors_Title] LIKE '%fenerbah%',1,0)) AS FBContent
FROM [Content].[dbo].[All_Content] AS C
WHERE 
	C.[Is_Spor] = 1 AND
	YEAR(C.[CreatedDate]) = 2018
GROUP BY MONTH(C.[CreatedDate]),DATENAME(MONTH,C.[CreatedDate])




SELECT *, 
ROUND(CAST(Result.FTContent AS FLOAT) / CAST(Result.GSContent AS FLOAT),2) AS FTRatio,
ROUND(CAST(Result.FBContent AS FLOAT) / CAST(Result.ContentCount AS FLOAT),2) AS FBRatio,
ROUND(CAST(Result.GSContent AS FLOAT) / CAST(Result.ContentCount AS FLOAT),2) AS FBGSRatio
FROM 
(
	SELECT 
		MONTH(C.[CreatedDate]) AS MonthN, 
		DATENAME(MONTH,C.[CreatedDate]) AS MonthName, 
		COUNT(*) AS ContentCount,
		SUM(IIF(C.[Title] LIKE '%Fatih%Terim%' OR C.[Ancestors_Title] LIKE '%Fatih%Terim%',1,0)) AS FTContent,
		SUM(IIF(C.[Title] LIKE '%galatasa%' OR C.[Ancestors_Title] LIKE '%galatasa%',1,0)) AS GSContent,
		SUM(IIF(C.[Title] LIKE '%fenerbah%' OR C.[Ancestors_Title] LIKE '%fenerbah%',1,0)) AS FBContent
	FROM [Content].[dbo].[All_Content] AS C
	WHERE 
		C.[Is_Spor] = 1 AND
		YEAR(C.[CreatedDate]) = 2018
	GROUP BY MONTH(C.[CreatedDate]),DATENAME(MONTH,C.[CreatedDate])
) AS Result
ORDER BY 1 ASC



------------------- FONKSÝYONLAR -------------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile iþlem yaptýðýmýz için, Birebirlik bir
													-- deðer döndüðünü biliyoruz.
		FROM AdventureWorks_Sales_2017  AS S



----	NOTE  :	 Hazýr "String" Fonksiyonlarý , Solda Sýrasý ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	içerisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak Ýçin de MSSQL ekranýnda Yukarýda Sýrasý ile :
----	View - Template Browser - Function -


--    FUNCTION :: Bir veya birden fazla parametre alýp bize sonuç dönen yapýlara FONKSÝYON denir.

--    SCALAR - VALUED FUNCTION :: Bir veya birden fazla parametre alýp bize sadece BÝR deðer dönen yapýlara
-- SCALAR - VALUED FUNCTION denir.

--    INLINE TABLE - VALUED FUNCTUON ::  Eðer Fonksiyonumuz 1'e N'lik , N'e 1'lik veya N'e N'lik bir TABLO sonucu
-- dönüyorsa buna INLINE FUNCTION denir.

--    MULTI - STATEMENT TABLE - VALUED FUNCTION :: Eðer bir sorgu sonucumuz yoksa , içeride hesaplamalar yapýp
-- deðiþkenleri bir Tabloya atýp sanal bir Tablo ile döndürüyorsa buna da MULTI - STATEMENT FUNCTION denir.

----    NOTE  :  Solda ; Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions -
----    Scalar-valued Functions'a gelip sað týkladýðýmýzda , 'New Scalar-valued Function' imlecini görürüz. Buna
----    týkladýðýmýzda bize yazmamýz gereken Template , yeni bir çalýþma sayfasýnda gönderiliyor...

--    ** template == Þablon. **

----    NOTE  :  Fonksiyonlarda ; deðiþtirme , silme , güncelleme , ... gibi iþlemler yoktur. Fonksiyonlarýn tek amacý
----    var ; parametreyi aldýktan sonra , datanýn hesaplanýp bir çýktý vermesidir...

----    NOTE  :  Deðiþtirme , Silme , Güncelleme , ... gibi iþlemler için  'STORED PROCEDURE (Saklý Yordam)'
----    kullanacaðýz...

----    NOTE  :  Bir KOD bloðunu tamamen Comment (Yorum) bloðu haline getirmek için ; TÜM bloðu seçip ,
----    'CTRL + k + c' tuþlarýna basmak gerekiyor...


--    NOTE  :  Mesela bu yaptýðýmýz adýmlarý nasýl takip edebiliriz ? Hangi adýmda ne olduðunu nasýl görebiliriz ?
--    Bunun için  "BREAK POINT"  koymamýz gerekiyor...



--    Bütün iþlemlerimizi bitirip , Data Manipülasyonumuzu da yapýp , Fonksiyonlarý ve Saklý Yordamlarý da yarattýktan
-- sonra ; sorgumuzun bizden baðýmsýz olarak günlük çalýþmasýný istiyoruz... Bunun için Solda EN ALTTAKÝ
-- 'SQL Server Agent''in  içinde  "JOBS"  klasörü vardýr... O "JOB"'larý , tanýmlayarak çalýþtýrýyoruz...
--    O "JOB"'lar , her gece çalýþmasý gereken yapýlarý gösterir... Oradan , özelliklerini ve arka-planda nasýl
-- çalýþtýðýný görmek istediðimiz bir "JOB"'a Sað týklayýp , sonrasýnda da  'Properties'  butonuna týklamalýyýz...
--    'Properties''e týkladýktan sonra karþýmýza o JOB'un özellikleri çýkýyor. Oradan  "Steps"  butonuna týklayýp ,
-- her bir Stepte nasýl iþlemler yapýldýðýný görebiliyoruz... Herhangi bir iþlemin ayrýntýlý Kodlarýný görmek için de,
-- o Stepe Çift Týklýyoruz ve açýyoruz... Açýlan sayfada , çalýþan Sorgunun Kodlarýný görebiliriz...
--    Ýçerisine girdiðimiz Stepin Ýleri özelliklerini görmek için de ; bu sayfanýn içerisinde soldaki  'Advanced'
-- butonuna týklýyoruz... 'Advanced''de ; eðer bu Step Baþarýlý ise , o Stepten sonra hangi Step'e geçmesi gerektiðini
-- seçebiliyoruz... Ayný þekilde , Baþarýsýz ise de o Stepten sonra hangi Step'e geçmesi gerektiðini seçebiliyoruz...
-- Ayrýca Baþarýsýz olursa , Baþarýlý olmak için ;Ý hangi Interval'de Kaç Kez daha denemesi gerektiðini de
-- seçebiliyoruz... Son olarak 'Hata Dosyasý' oluþturacaksak da  "Output File:"  dosyasýnýn adýnýn ne olacaðýný da
-- yazabiliyoruz...
--    Bunlarýn hepsini yaparak "JOB"'umuzun adýmlarýný belirleyebiliyoruz...
--    Þimdi de Yine "JOB"'umuzun içerisinde Solda  "Schedules"  butonuna týklýyoruz. Burada da "JOB"'umuzun Hangi
-- Periyotta çalýþmasý gerektiði talebini belirtiyoruz... Mesela her gün saat kaçta çalýþmasý gerektiðini
-- belirtiyoruz (Sabah saat 08.15 gibi...). Bunu belirttikten sonra da aþaðýdaki  'Edit'  butonuna týklýyoruz...
--    'Edit'  butonuna týkladýktan sonra da ;  'Schedule Type'  ,  'Frequency'  ,  'Daily frequency'  ve  'Duration'
-- triklerini belirtiyoruz... Ve sonrasýnda da  'OK'  butonuna basarak çalýþtýrýyoruz...

--    Bir defa ana kurguyu tasarladýktan sonra eðer bir Veri Tabanýmýz varsa , mesela "SQL Server"'imiz varsa burada
-- bir  "SQL Server Agent"  içinde  "JOB"  tanýmlýyoruz. Veya  'Open Source'  bir kütüphane kullanacaksak da mesela
-- "APACHE Airflow" kullanýyoruz... Bu tip yerlerde  "Schedules"  iþlemlerimizi gerçekleþtiriyoruz... Ondan sonra da
-- artýk Datalarýmýz temiz geliyor. Hatta Data Science Modelimizi kurup "Python Script"'leri de buraya baðladýðýmýzda,
-- sonuçlarý da almýþ oluyoruz ve artýk sonrasýnda bir iþlem yapmýyoruz. Sadece monitörüze ediyoruz.



--------------- Deðiþken Üzerinden 'IF' Kontrolu ---------------

DECLARE @Count INT;    
SELECT @Count = (SELECT COUNT(*) FROM Sales.SalesOrderDetail)
  
IF @Count > 100000 
BEGIN        
	PRINT 'Over 100,000';    
END    
ELSE BEGIN        
	PRINT '100,000 or less.';    
END;

SELECT IIF(@Count > 100000,'Over 100,000','100,000 or less.')


CREATE FUNCTION fx_Customer_Order_Count
(
	@CustomerID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @Result INT
	
	SET @Result = (SELECT COUNT(*)
				   FROM [AdventureWorks2014].[Sales].[SalesOrderHeader]
				   WHERE [CustomerID] = @CustomerID)

	RETURN @Result

END
GO


SELECT DISTINCT CustomerID FROM [AdventureWorks2014].[Sales].[SalesOrderHeader] 

SELECT TOP (1000) 
	   [CustomerID]
      ,[PersonID]
	  ,[dbo].[fx_Customer_Order_Count]([CustomerID])
FROM [AdventureWorks2014].[Sales].[Customer]
WHERE [dbo].[fx_Customer_Order_Count]([CustomerID]) != 0 



CREATE FUNCTION fx_Customer_RFM
(	
	@CustomerID INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		[CustomerID], 
		MIN([OrderDate]) AS FirstOrderDate, 
		MAX([OrderDate]) AS LastOrderDate,
		COUNT(*) AS OrderCount,
		SUM([SubTotal]) AS TotalAmount,
		IIF(COUNT(*) != 0, ROUND(SUM([SubTotal]) / COUNT(*),2),0) AS BasketSize,
		DATEDIFF(MONTH,MAX([OrderDate]),GETDATE()) AS IdleTime,
		IIF(COUNT(*) != 0, ROUND(CAST(COUNT(*) AS FLOAT)/ CAST(DATEDIFF(MONTH,MIN([OrderDate]),MAX([OrderDate])) AS FLOAT),2),0) AS OrderPeriod
	FROM [AdventureWorks2014].[Sales].[SalesOrderHeader]
	WHERE [CustomerID] = @CustomerID
	GROUP BY [CustomerID]
)
GO

SELECT TOP (1000) 
	   C.[CustomerID]
      ,C.[PersonID]
	  ,FX.*
FROM [AdventureWorks2014].[Sales].[Customer] AS C
INNER JOIN
[AdventureWorks2014].[Sales].[SalesOrderHeader] AS S
ON C.[CustomerID] = S.[CustomerID]
CROSS APPLY
[AdventureWorks2014].[dbo].[fx_Customer_RFM] (C.[CustomerID]) AS FX

--------------- Döngü ---------------
DECLARE @i INT = 1;    
DECLARE @j INT;   

WHILE @i <= 100 BEGIN        
SET @j = 1;        
WHILE @j <= 5 BEGIN            
	PRINT @i * @j;            
	SET @j += 1;        
	END;        
	SET @i += 1;    
END;   

--------------- Temp Table ---------------
CREATE TABLE #CustomerInfo(        
	CustomerID INT, FirstName NVARCHAR(50),        
	LastName NVARCHAR(50),CountOfSales INT,        
	SumOfTotalDue MONEY); 

GO    
INSERT INTO #CustomerInfo(CustomerID,FirstName,LastName,        
	CountOfSales, SumOfTotalDue)    
SELECT C.CustomerID, FirstName, LastName,COUNT(*),SUM(TotalDue)    
FROM Sales.Customer AS C    
INNER JOIN Person.Person AS P ON C.CustomerID = P.BusinessEntityID    
INNER JOIN Sales.SalesOrderHeader        
AS SOH ON C.CustomerID = SOH.CustomerID    
GROUP BY C.CustomerID, FirstName, LastName; 

drop table #CustomerInfo

--------------- Transaction (Ýþlem , Hareket , Faaliyet) ---------------
IF OBJECT_ID('dbo.Demo') IS NOT NULL BEGIN           
	DROP TABLE dbo.Demo;    
END;    
GO    
CREATE TABLE dbo.Demo(ID INT PRIMARY KEY, Name VARCHAR(25)); 

BEGIN TRAN        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES (1,'Test1');           
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES(2,'Test2');    
COMMIT TRAN;  

BEGIN TRAN        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES(3,'Test3');        
	INSERT INTO dbo.Demo(ID,Name)        
	VALUES('a','Test4');    
COMMIT TRAN;    
GO    
SELECT ID,Name    
FROM dbo.Demo;   
  




--------------- Exception (Ýstisna , Olaðandýþýlýk , Olaðandýþý durum) ---------------
BEGIN TRY        
	INSERT INTO HumanResources.Department
		( Name, GroupName, ModifiedDate)        
		VALUES ('Engineerings','Research and Development', GETDATE());    
END TRY    
BEGIN CATCH        
	SELECT ERROR_NUMBER() AS ErrorNumber, 
		ERROR_MESSAGE() AS ErrorMessage,            
		ERROR_SEVERITY() AS ErrorSeverity;    
END CATCH;   



BEGIN TRY        
INSERT INTO            
	HumanResources.Department(               
	Name, GroupName, ModifiedDate)        
	VALUES ('Engineering',            
		'Research and Development',           
		GETDATE());       
END TRY    
BEGIN CATCH        
	IF ERROR_NUMBER() = 2627 BEGIN            
		RAISERROR(               
			'You attempted to insert a duplicate!',  16, 1);       
	END;
END CATCH;  

 
 
SELECT C.CustomerID, C.StoreID, C.TerritoryID,        
	P.FirstName,  
	P.LastName, 
	COUNT(DISTINCT(S.SalesOrderID)) AS OrderCount
INTO #ITU_DS
FROM Sales.Customer AS C    
	INNER JOIN Person.Person AS P        
ON C.PersonID = P.BusinessEntityID    
INNER JOIN Sales.SalesOrderHeader AS S        
	ON S.CustomerID = C.CustomerID
WHERE 
	(P.FirstName LIKE '%a%')
	OR
	(P.Title = 'Engineer' AND YEAR(S.ShipDate)>2010)

GROUP BY C.CustomerID, C.StoreID, C.TerritoryID,        
	P.FirstName, P.MiddleName,        
	P.LastName
HAVING COUNT(DISTINCT(S.SalesOrderID))>15


SELECT I.*, FX.[BasketSize]
FROM #ITU_DS AS I
CROSS APPLY [AdventureWorks2014].[dbo].[fx_Customer_RFM] (I.[CustomerID]) AS FX


DROP TABLE #ITU_DS

--------------- Views (Görünümler) ---------------
IF OBJECT_ID('dbo.vw_Products') IS NOT NULL BEGIN       
	DROP VIEW dbo.vw_Products;    
END;    
GO    
CREATE VIEW dbo.vw_Products AS (        
	SELECT P.ProductID, P.Name, P.Color,            
	P.Size, P.Style,            
	H.StandardCost, H.EndDate, H.StartDate        
	FROM Production.Product AS P        
	INNER JOIN Production.ProductCostHistory AS H            
	ON P.ProductID = H.ProductID);    
GO    
SELECT ProductID, Name, Color, Size, Style,        
	StandardCost, EndDate, StartDate    
FROM dbo.vw_Products;  

--------------- Scalar (Skaler , Yönsüz , Sayýsal) Functions 1 ---------------
IF OBJECT_ID('dbo.fn_AddTwoNumbers')        
	IS NOT NULL BEGIN        
	DROP FUNCTION dbo.fn_AddTwoNumbers;    
END;    
GO    
CREATE FUNCTION dbo.fn_AddTwoNumbers        
	(@NumberOne INT, @NumberTwo INT)    
RETURNS INT AS BEGIN        
	RETURN @NumberOne + @NumberTwo;    
END;    
GO    
SELECT dbo.fn_AddTwoNumbers(1,2);


--------------- Scalar (Skaler , Yönsüz , Sayýsal) Functions 2 ---------------
IF OBJECT_ID('dbo.Trim') IS NOT NULL BEGIN        
	DROP FUNCTION dbo.Trim;    
END    
GO    
CREATE FUNCTION dbo.Trim        
	(@Expression VARCHAR(250))       
RETURNS VARCHAR(250) AS BEGIN        
	RETURN LTRIM(RTRIM(@Expression));    
END;    
GO    
SELECT '*' + dbo.Trim('  test  ') + '*';

--------------- Scalar (Skaler , Yönsüz , Sayýsal) Functions 3 ---------------
IF OBJECT_ID('dbo.fn_RemoveNumbers')        
	IS NOT NULL BEGIN        
	DROP FUNCTION dbo.fn_RemoveNumbers;    
END;    
GO    
CREATE FUNCTION dbo.fn_RemoveNumbers        
	(@Expression VARCHAR(250))    
	RETURNS VARCHAR(250) AS BEGIN       
	RETURN REPLACE( REPLACE (REPLACE (REPLACE( REPLACE( REPLACE( REPLACE( REPLACE( REPLACE(          
		REPLACE( @Expression,'1', ''),'2', ''),'3', ''),'4', ''),'5', ''),'6', ''),'7', ''),              
		'8', ''),'9', ''),'0', '');    
END;    
GO    
SELECT dbo.fn_RemoveNumbers        
('abc 123 this is a test');

--------------- Scalar (Skaler , Yönsüz , Sayýsal) Functions 4 ---------------
IF OBJECT_ID('dbo.fn_FormatPhone') IS NOT NULL    
BEGIN        
	DROP FUNCTION dbo.fn_FormatPhone;    
END;    
GO    
CREATE FUNCTION dbo.fn_FormatPhone        
	(@Phone VARCHAR(10))    
RETURNS VARCHAR(14) AS BEGIN        
	DECLARE @NewPhone VARCHAR(14);        
	SET @NewPhone = '(' + SUBSTRING(@Phone,1,3)            
		+ ') ';        
	SET @NewPhone = @NewPhone +            
		SUBSTRING(@Phone, 4, 3) + '-';        
	SET @NewPhone = @NewPhone +            
		SUBSTRING(@Phone, 7, 4);        
	RETURN @NewPhone;    
END;    
GO    
SELECT dbo.fn_FormatPhone('5555551234'); 


SELECT C.[CustomerID], C.[StoreID], C.[AccountNumber], FX.*
FROM Sales.Customer AS C
CROSS APPLY [dbo].[fx_Customer_RFM] (C.[CustomerID]) AS FX
WHERE StoreID BETWEEN 100 AND 500
AND FX.[IdleTime]> 60
ORDER BY 10 DESC

--------------- Stored Procedures (Saklý Yordamlar - Prosedürler) ---------------
IF OBJECT_ID('dbo.usp_CustomerTotals')        
	IS NOT NULL BEGIN        
	DROP PROCEDURE dbo.usp_CustomerTotals;    
END;    
GO    

SELECT C.[CustomerID], C.[StoreID], C.[AccountNumber]
FROM Sales.Customer AS C
WHERE StoreID BETWEEN @Param1 AND @Param2


CREATE PROCEDURE dbo.usp_CustomerTotals AS        
	SELECT C.CustomerID,            
		YEAR(OrderDate) AS OrderYear,            
		MONTH(OrderDate) AS OrderMonth,            
		SUM(TotalDue) AS TotalSales        
	FROM Sales.Customer AS C        
	INNER JOIN Sales.SalesOrderHeader            
	AS SOH ON C.CustomerID = SOH.CustomerID        
	GROUP BY C.CustomerID, YEAR(OrderDate),            
	MONTH(OrderDate);    
GO   
 
EXEC dbo.usp_CustomerTotals;   


--------------- Stored Procedures (Saklý Yordamlar - Prosedürler) ---------------
IF OBJECT_ID('dbo.usp_ProductSales')        
	IS NOT NULL BEGIN        
	DROP PROCEDURE dbo.usp_ProductSales;    
END;    
GO    
CREATE PROCEDURE dbo.usp_ProductSales        
		@ProductID INT,        
		@TotalSold INT = NULL OUTPUT AS           
	SELECT @TotalSold = SUM(OrderQty)        
	FROM Sales.SalesOrderDetail        
	WHERE ProductID = @ProductID;    
GO    
DECLARE @TotalSold INT;    
EXEC dbo.usp_ProductSales @ProductID = 776,        
	@TotalSold =  @TotalSold OUTPUT;    
PRINT @TotalSold;    


----    Adventure works read xml
----    Adventure works read json


DECLARE @json NVARCHAR(4000)
SET @json = 
N'{
    "info":{  
      "type":1,
      "address":{  
        "town":"Bristol",
        "county":"Avon",
        "country":"England"
      },
      "tags":["Sport", "Water polo"]
   },
   "type":"Basic"
}'

--------------- Using 'JSON_VALUE' Function ---------------
SELECT
  JSON_VALUE(@json, '$.type') a,
  JSON_VALUE(@json, '$.info.type') b,
  JSON_VALUE(@json, '$.info.address.town') c,
  JSON_VALUE(@json, '$.info.tags[0]') d

--------------- Using 'ISJSON' Function ---------------
SELECT
  ISJSON(@json) AS json1,
  ISJSON(JSON_QUERY(@json, '$.info')) AS json2,
  ISJSON(JSON_VALUE(@json, '$.info.type')) AS not_json

--------------- Using 'JSON_QUERY' Function ---------------
SELECT
  JSON_QUERY(@json, '$') as [object],
  JSON_QUERY(@json, '$.info') as info,
  JSON_QUERY(@json, '$.info.address') as address,
  JSON_QUERY(@json, '$.info.tags') as tags

--------------- Using 'OPENJSON' Function with Default Schema ---------------
SELECT [key] as property, value
FROM OPENJSON(@json, '$.info.address')

SELECT [key] as i, value
FROM OPENJSON(@json, '$.info.tags')

--------------- Using 'OPENJSON' Function with Explicitly Defined Schema ---------------

--    ** explicitly == Açýkça , Açýk bir þekilde. **

SELECT *
FROM OPENJSON(@json, '$.info')
WITH ( type int,
       town nvarchar(50) '$.address.town',
       country nvarchar(50) '$.address.country'
     )
GO