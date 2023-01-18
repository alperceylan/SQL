

----   Veri Taban�m�z�n bir Kopyas�n� vermek i�in :
--   Soldaki en �stteki 'Databases' klas�r�ne SA� T�kl�yoruz ve oradan da 'Attach' butonuna t�kl�yoruz...

----   Bir DataBase a�mak istiyorsak :
--   Soldaki en �stteki 'Databases' klas�r�ne SA� T�kl�yoruz ve oradan da 'New Database' butonuna t�kl�yoruz.
-- Sonra da , a��lan pencerede 'Database name''yi giriyoruz. Ard�ndan 'Database Files' ayarlar�n� yap�yoruz.
-- Bu ayarlar da ; LOG dosyas� ve DATA dosyas�n�n b�y�kl��� ile ilgili ayarlard�r...
--   SONRA da soldaki 'OPTIONS' butonuna t�kl�yoruz ve 'Recovery model' ayar�n� yap�yoruz. Bu ayar LOG'lar�n nas�l
-- tutulaca��n� ayarl�yor... E�er biz her g�n data manip�lasyonu yap�yorsak her gece binlerce kayd� silip
-- g�ncelliyorsak bu ayar� 'FULL' tutmak daha mant�kl� olabilir. 'Full' yapt���m�zda , LDF dosyam�zda , yani
-- Veri Taban�n�n LOG dosyas�nda , b�t�n hareketlerimizin kayd� tutuluyor. Bunun handikap� da sunucumuzun limitleri
-- varsa , LDF dosyas� bazen o kadar �ok yer kapl�yor ki sunucumuzda hata almam�za sebep olabiliyor...
-- Bir Data Scientist'in b�yle bir �eye pek ihtiyac� olmuyor. Onun i�in 'SINGLE' olarak tutmak bizim i�in daha
-- mant�kl�d�r...
--   'Compatibility level' ayar�n� da ; �al��t���m�z �irket hangi leveli kullan�yorsa ayn�s�n� yapmal�y�z...
--   Sonra da e�er istersek ve 'SCRIPT' butonuna basarsak Veri Taban�m�z�n KOD D�Z�S� olu�uyor.
--   Sonra da 'OK' butonuna t�klayarak Veri Taban�m�z� olu�turabiliyoruz...

----   KODLARI �al��t�rmak i�in de :
--   Ya yukar�daki 'Execute' butonuna t�klamal�y�z veya 'F5' tu�una basabiliriz , ya da CTRL + ENTER tu�lar�na
-- basabiliriz...
--   �al��t�rmak istedi�imiz KODLARI se�erek , sadece o KODLARI 'Execute' edebiliriz...



--------------- Sunucudaki Veritabanlar�n�n Listelenmesi ---------------

--   'SELECT' : Hangi veri kayna��ndan , Hangi Kolonlar� getirece�imizi g�sterdi�imiz alana denir...
-- '*' i�areti de ; "o Tablodaki b�t�n alanlar� getir." demektir... Ama isteseydik , Kolon isimlerini virg�l ile
-- ay�rarak , sadece istedi�imiz Kolonlar� da getirtebilirdik... :

--   'FROM' : Hangi Tablodan okudu�umuzu g�steriyor... :

SELECT * FROM sys.databases; 



--------------- Veritabanlar�n�n Dosyalar� ve Lokasyonlar� ---------------

--   Pembe renki KODLAR , Fonksiyonlard�r... Yani mesela a�a��da 'db_name()' fonksiyonu ; '(dbid)' de�erini Parametre
-- olarak al�yor ve bu �ekilde 'db_name()' fonksiyonunu d�n�yor... :
--   Yine a�a��da 'as ColumnName' diye yazd���m�z KOD ile de , ayn� sat�rdaki �ncesinde yazd���m�z KODA yeni bir
-- Kolon ismi vermi� oluyoruz... Bu Kolon ismi vermek fiziksel bir de�i�iklik de�ildir. Sadece aray�zde bir g�r�nt�
-- de�i�ikli�i demektir... :
--   Yine a�a��daki ilk KOD sat�r�nda 'filename' olarak 'fName' ismini atam���z... :
--   Bu ilk KOD sat�r�n� �al��t�rd���m�zda g�rd���m�z gibi, sadece istedi�imiz '3' adet kolonu g�stermi� olduk... :
select dbid , db_name(dbid) as ColumnName , filename fName from sys.sysaltfiles

--   DEFAULT olarak hi�bir isim atamazsak da , Veri Taban�nda nas�l bir ba�l�k yaz�l�ysa �yle kalacakt�r... Hi�bir
-- ba�l�k yazm�yorsa da '(No column name)' yazacakt�r... :
select dbid , db_name(dbid) , filename from sys.sysaltfiles

--   Yine isim atarken istersek 'as' tak�s�n� kullanmasak da olur... Sadece bir bo�luk b�rak�p istedi�imiz ismi
-- yazabiliriz... :
select db_name(dbid) dbname , filename from sys.sysaltfiles

--   Bunlar fiziksel birer de�i�iklik de�ildirler... Sadece aray�zde g�rsel bir de�i�iklik sa�larlar...



--------------- �zerinde �al���lan 'Veri Taban�na' Ait �zellikler ---------------

--   '�zerinde �al���lan Veri Taban�' demek : Solda bir d�nya Veri Taban� g�r�yoruz ama biz yazd���m�z sorgular� ,
-- sadece bir Veri Taban� Se�erek yapmam�z gerekiyor demektir...


SELECT * FROM sys.database_files;



--------------- Veritaban� Olu�turma ---------------

CREATE DATABASE MEFMaster ON (FILENAME = 'D:\ITU\AdventureWorks1_Data.mdf');



--------------- Kullan�lacak Veritaban� Se�imi ---------------

--   Sol yukar�da g�rd���m�z gibi biz �u an DEFAULT olarak 'master' Veri Taban�nda �al���yoruz... Oraya t�klayarak
-- bunu de�i�tirebiliriz... 
--   Ayr�ca bunu yapmak i�in 'Use' KODUNU da kullanabiliriz... :
Use ITUmindset



--------------- Kullan�lacak Tablonun Varl���n�n Sorgulanmas� (IF) ve Varsa Silinmesi (DROP) ---------------

--   Bazen ; �zellikle 'Drop' , 'Delete' , 'Update' gibi komutlar� �al��t�r�rken , bir KONTROL yapmam�z gerekiyor...
-- Bunun i�in de 'IF' komutunu kullanmam�z gerekiyor...
--   Mesela a�a��da , ITUmindset Veri Taban�n�n i�erisinde ; E�ER 'dbo.Employees' isminde bir tablo VARSA
-- (Yani o tablo bo� de�ilse) o tabloyu S�L diyoruz... Yoksa zaten bir s�k�nt� da yoktur... :
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
  DROP TABLE dbo.Employees;




--------------- TABLO OLU�TURMA ---------------

--   'CREATE TABLE' komutunu kullanarak 'Employees' isminde bir Tablo olu�turmak istiyoruz...

--	 "dbo" tablolar�n �emalar�ndan biridir. Kendimiz ayr� olu�turmazsak default hali "dbo"'dur.
--   �emalar�n iki g�revi vard�r :
--   + �ema �zelinde yetkilendirme yapabiliriz. Kim hangi �emay� g�rebilir - g�remez gibi...
--   + Birbirine benzer olan tablolar� ayn� �emada toplayabiliriz... dbo.car , dbo.motor , ... gibi... Ve / Veya
-- Person.age , Person.length , ... gibi ...

--   A�a��daki mesela ,  "firstname VARCHAR(30) NOT NULL,"  komutu ;  " 'firstname' diye bir de�erimiz var ve
-- maksimum '30' karakter alabilir ve Bo� De�er Ge�iremez." diyor...

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

--    Olu�turdu�umuz Tabloyu �al��t�rd�ktan sonra Soldaki 'Databases' i�erisindeki 'ITUmindset' i�erisindeki
-- 'Tables''de g�rebilmek i�in ; 'Tables''in �zerine gelip Sa� t�klay�p bi 'Refresh' butonuna t�klamam�z gerekiyor...
--    Solda olu�turdu�umuz 'dbo.Employees' Tablosunun da alt k�r�l�mlar�na bakarsak Tablomuzun nelerden olu�tu�unu
-- g�r�r�z. (Columns , Keys , Constraints , Triggers , Indexes , Statistics , ... gibi ...)

--    'Columns' yap�s�na t�klad���m�zda , yaratt���m�z kolonlar�n isimlerini , data tiplerini , Null olup olmamas�
-- ile ilgili bilgileri ve daha nicelerini g�rebiliyoruz...

--    ** trigger == Harekete ge�irmek , Ba�latmak , Tetik , Tetikleme. **
--    'Triggers' Yap�s� : Mesela bu tabloda belirledi�imiz Trigger'leri ; mesela X t�r�nde bir i�lem yap�ld���nda ,
-- ba�ka bir aksiyon al�nacaksa onlara 'Trigger' denir... Mesela , 'Social Security Number' de�i�tiriliyorsa ve biz
-- bunu gidip ba�ka bir tabloda da de�i�tirmek istiyorsak... Veya ba�ka bir tabloya kay�t atmak istiyorsak veya bir
-- servise tetikleyeceksek , yani bir tetikleme i�lemi varsa bu bir 'Trigger' oluyor...

--    'Indexes' ve 'Statistics' yap�lar� ise , bu tablonun y�ksek performansl� �al��mas�n� sa�layan yap�lard�r...


--    Tablomuza manuel olarak de�er girmek i�in de , soldaki 'dbo.Employees' tablosuna Sa� t�kl�yoruz ve
-- 'Edip Top 200 Rows' butonuna t�kl�yoruz...



--   Olu�turdu�umuz kolonlardan biri 'employeed ID' yani 'empid' kolonuydu... Bu kolonu istersek Benzersiz ve / veya
-- Otomatik Artan hale de getirebilirdik... B�yle yapsayd�k ayn� 'employeed ID''ye sahip ba�ka bir sat�r olamazd�...


--------------- AUTO INCREMENT (OTOMATIK ARTMA) ---------------
---- Tabloda employer ID'nin otomatik artmas�n� istiyoruz ----

--   Otomatik Artan Yap� : 'Integer' veya 'Guid' tipinde olabilir...

-------- GUID (NEWID) --------

--	 S�rekli rastgele bir de�er olu�turmak i�in 'Guid''i kullan�r�z. Her �al��t�rd���m�zda yeni bir de�er olu�turur.
-- Buna GUID yap� denir... :
select NEWID()


-- �ncelikle tablomuzu tamamen silelim. Ve en ba�tan , 'empid' kolonumuz Otomatik Artacak �ekilde olu�tural�m... :

--------------- Tabloyu Silme ��lemi (drop) ---------------
drop table dbo.Employees


--------------- Tablonun Tamam�n� U�urma-Silme (truncate) ---------------

--    ** truncate == K�rpmak , Sondan k�rpma. **

TRUNCATE TABLE [ITUmindset].[dbo].[Orders]


-------- INTEGER (identity()) --------

--    ** identity == Kimlik , �zde�lik. **
--    ** primary == Primer , Birincil , Ba�l�ca , Esas. **

--	  "identity()" komutu ile aritmetik s�ralama yapar�z! 
--	  Mesela , "identity(1 , 2)" komutu ile ; bu komutu i�erisine yazd���m�z kolon , "1" de�eri ile ba�layacak ve her
-- yeni girdi de, iki�er iki�er otomatik artacak diyoruz...
--    "primary key clustered" ile de , de�erimize "Primary Key" �zelli�i koyuyoruz...
--    "dbo.Employees" tablomuzu a�t���m�zda, "empid" de�erini de�i�tiremedi�imizi g�rece�iz. ��nk� otomatik atama
-- yapacak!
--	  Ve soldaki "dbo.Employees" tablosunun alt�ndaki "Columns" klas�r�n�n i�ine bakt���m�zda, "empid" kolonumuzda
-- 'kilit i�areti' oldu�unu g�r�r�z... Bu da , "'empid' kolonumuz �zerinde bir i�lem yapamay�z , kilitli." demektir.

----    NOTE  :  'identity' i�erisine hi�bir �ey yazmadan direkt 'IDENTITY' yazarsak ; ilgili kolonda '1''den
----	ba�layarak s�ras� ile birer birer ilerler...

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




--------------- TABLODA B�R SATIR S�LME ---------------

--	 Yukar�daki kilitli "empid" kolonu ile olu�turulan tablodan bir sat�r sildi�imizde ; o sat�r�n "empid" de�eri ,
-- sonradan girilen veri sat�r� i�in KULLANILAMAZ!  Yani a�a��da sildi�imiz , "empid" de�eri 1907 olan sat�rdan
-- sonra ; yeni sat�r i�in otomatik olarak , "empid" de�eri 1909 olan bir sat�r gelir :

delete from dbo.Employees where empid = 1907



---------- Yeniden Tabloyu Silelim (drop) ----------
drop table dbo.Employees


---------- Yeniden Tablo Olu�tural�m ----------
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

----    **   alter == De�i�tirmek. **
----    ** constraint == K�s�t , K�s�tlama. **

----	NOTE:	"Primary Key" �zelli�i ekleme i�lemi, yukar�daki gibi CREATE TABLE esnas�nda , "primary key clustered"
-- ile de yap�labilirdi...

--   "UPDATE" komutu tablodaki kolonda DE����KL�K, G�NCELLEME yapmam�z� sa�lar. Kolonun i�erisindeki Veriyi ,
-- Kal�c� �ekilde de�i�tirir!

--	 "ALTER" komutu tabloda DE����KL�K, G�NCELLEME yapmam�z� sa�lar! Tablonun - Kolonun Fiziksel Yap�s�n� de�i�tirir!
-- Yani Kolonun Tipini (Type) de�i�tirebiliriz... "ALTER TABLE" komutundan sonra, de�i�iklik yapmak istedi�imiz
-- tablonun ismini yazar�z...
--   Mesela , 'Employees' Tablosundaki 'lastname' Kolonunun , maksimum karakter s�n�r�n� artt�ral�m... Yani bu Kolonun
-- Fiziksel Yap�s�n� de�i�tirelim :
ALTER TABLE dbo.Employees ALTER COLUMN lastname VARCHAR(40) ;

--	 "ADD" komutu tabloya bir �ey EKLEMEM�Z� sa�lar! "ADD CONSTRAINT" komutu ile bir "constraint" ekliyoruz..

--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemi� oluruz. Sonras�ndaki yazd���m�z ifade ise bir
-- atamad�r. A�a��da; yaratt���m�z "PK_Employees" isminde bir de�i�kene, k�s�tlamam�z� atad�k!

--	 "PRIMARY KEY()" komutu ile de, i�erisine yazd���m�z kolona "Primary Key" �zelli�i eklemi� oluruz ve o kolondaki
--her de�er "Primary Key" �zelli�i sayesinde birbirinden farkl� olmak zorundad�r!!!

ALTER TABLE dbo.Employees				-- �zerinde i�lem yapaca��m�z tablonun ismi
  ADD CONSTRAINT PK_Employees_empid		-- CONSTRAINT ile k�s�tlama ekleyece�imiz kolon i�in yaratt���m�z ataman�n ismi
  PRIMARY KEY(empid);					-- Primary Key �zelli�ini ekleyece�imiz kolonun ismi.

----	NOTE:	Daha �nceki i�lemleri silip, bu i�lemlerden sonra tabloyu a�t���m�zdan dolay�, "empid" de�erimizin
----	otomatik olarak atanmad���n�, "empid" de�erini kendimizin girmesi gerekti�ini g�rd�k. ��nk� daha �nceki i�lemde
----	"identity()" komutu ile otomatik olarak s�ral� artmas�n� istedi�imiz "empid" de�erimiz i�in burada bir i�lem
----	yapmad�k.


---------- 'Unique' �zelli�i ----------
--	 A�a��da, tablodaki Social Security Number "ssn" kolonunun, 'unique' yani 'benzersiz' olmas�n� istiyoruz :

ALTER TABLE dbo.Employees
  ADD CONSTRAINT UNQ_Employees_ssn
  UNIQUE(ssn);


---------- 'Check' �zelli�i ----------
--	 CHECK �zelli�i ; "ADD CONSTRAINT" komutuyla , yaz�l� kolunun i�erisine girdi�imiz veri de�erin 'ko�ullar�n�
-- belirlememizi' sa�lar :
--   A�a��da , 'salary' kolonunun minimum de�erini belirleyelim.

ALTER TABLE dbo.Employees
	ADD CONSTRAINT min_salary
	check(salary > 3000)

alter table dbo.Employees
	add constraint min_firstname
	check(len(firstname) > 1)

--	 NOTE  :  Solda, �al��t���m�z tablonun i�erisindeki "Constraints" dosyas�n�n i�erisine bakt���m�zda, sadece "check"
--   komutu ile yazd���m�z "Constraint"'leri g�rece�iz... Yani kendimize ko�ul koydu�umuz ifadeleri g�rece�iz..
--      Geri kalan 'Constraint''leri de ; Soldaki 'dbo.Employees' tablosuna Sa� t�klay�p , 'Script Table as'
--	 at�klad�ktan sonra , 'CREATE To' ya t�klay�p sonra da 'New Query Editor Window''a t�kl�yoruz ve orada g�r�yoruz...
--   Yani tablonun kendi yap�s� i�erisinde sakl�yor...




--------------- VER� G�R��� YAPMAK ---------------

--   INSERT INTO [Veri Giri�i Yapmak �stedi�imiz Tablo �smi]
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
--	Hata ald�k! Sebebi de "unique" de�er olan "ssn" de�erini tekrarlamak istedik ama izin vermedi!

INSERT INTO [Employees]
([firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1911,'koray','kocabas','2016-12-01',132,'46715775430',100)
--	Hata ald�k! Sebebi de "salary" de�eri olarak "3000"'den k���k de�er girdik ama izin vermedi!

INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1909,'cemre','ceylan','2016-12-01',135,'36742344718',17000)

INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
('ege','ceylan','2016-12-01',135,'36741244718',9000)
--	Hata ald�k! Sebebi de "empid" de�eri girmedik ve dolay�s� ile izin vermedi!

----	NOTE  :	 E�er daha yukar�lardaki gibi mesela "identity()" metodu ile "empid" de�erimize bir ba�lang�� de�eri
----	verip otomatik artan yapsayd�k ; veri giri�i esnas�nda "[empid]" k�sm�n� atlay�p bo� b�rakarak di�er kolonlar
----	i�in olan verilerimizi girmemiz gerekecekti!!! E�er "empid" kolonu i�in bir de�er girmeye �al��sayd�k da hata
----	verecekti!!!

----	NOTE  :	 'Constraint''ler olabildi�ince sa�l�kl� �ekilde veri giri�i yapmam�z� sa�layan yap�lard�r...
----	NOTE  :	 Tabloya veri giri�i yaparken hata al�yorsak , Solda tablonun i�erisindeki 'Constraint' yap�s�na
----    bakabiliriz...



--------------- FOREIGN KEY ��in ; Tablo Kontrol� ve Tablo Olu�turma ---------------

--    ** order == Sipari�. **

--	  Bir "Orders" tablosu olu�tural�m :

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
  DROP TABLE dbo.Orders;

CREATE TABLE dbo.Orders
(
  orderid   INT          NOT NULL identity(1, 3) ,		-- order id     (sipari� no)
  empid     INT          NOT NULL ,						-- employee id  (�al��an no)
  eventid   int			 not null ,						-- event id     (olay no)
  custid    VARCHAR(10)  NOT NULL ,						-- cust id      (m��teri no)
  orderts   DATETIME2    NOT NULL ,						-- order ts     (sipari� zaman�)
  qty       INT          NOT NULL ,						-- quantity     (miktar)
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
  --   "PK_Orders key" atamam�z� soldaki "dbo.Orders" tablomuzun i�erisindeki "Keys" klas�r�n�n i�ersinde g�rebiliriz.
  --   "Primary Key"'imizi de soldaki "dbo.Orders" tablomuzun i�erisindeki "Columns" klas�r�n�n i�ersinde g�rebiliriz.
  drop table dbo.Orders
  ----		NOTE:	"Primary Key"'i ; daha yukar�daki "orderid" k�sm�nda da , daha �nce ��rendi�imiz gibi
  ----		olu�turabilirdik... Ancak yukar�da "CONSTRAINT" ile en sonda olu�turmay� tercih ettik. Hi�bir fark YOK!
  ----		   Yani yukar�daki KOD yap�s� ile a�a��daki KOD yap�s� aras�nda hi�bir fark yok !!!
  CREATE TABLE dbo.Orders
(
  orderid   INT          NOT NULL identity(1, 3) primary key clustered ,		-- order id     (sipari� no)
  empid     INT          NOT NULL ,												-- employee id  (�al��an no)
  eventid   int			 not null ,												-- event id     (olay no)
  custid    VARCHAR(10)  NOT NULL ,												-- cust id      (m��teri no)
  orderts   DATETIME2    NOT NULL ,												-- order ts     (sipari� zaman�)
  qty       INT          NOT NULL ,												-- quantity     (miktar)
);



---------- Tablonun Tamam�n� U�urma-Silme (truncate) ----------

--    ** truncate == K�rpmak , Sondan k�rpma. **

TRUNCATE TABLE [ITUmindset].[dbo].[Orders]




--------------- !!! FOREIGN KEY EKLEME !!! ---------------

----	NOTE  :  Di�er tablolar ile aras�nda bir etkile�im olu�turmak i�in "Foreign Key" kullan�r�z!!!
----	NOTE  :  Tablolar aras�nda ba�lant� �ok �ok �nemlidir!!!

----	NOTE  :  "Foreign Key" �zelli�i getirece�imiz kolona , daha �ncesinde "Primary Key" �zelli�i getirmemiz her
----	zaman daha do�ru olur... Aksi halde i�lemlerde mant�ks�zl�klar g�r�lebilir!!!
----    NOTE  :  'Foreign Key''ler , SADECE 'Primary Key''leri REFERANS edebilir...

--   "UPDATE" komutu tablodaki kolonda DE����KL�K, G�NCELLEME yapmam�z� sa�lar. Kolonun i�erisindeki Veriyi ,
-- Kal�c� �ekilde de�i�tirir!
--	 "ALTER" komutu tabloda DE����KL�K, G�NCELLEME yapmam�z� sa�lar! Tablonun - Kolonun Fiziksel Yap�s�n� de�i�tirir!
--	 "ALTER TABLE" komutundan sonra, de�i�iklik yapmak istedi�imiz tablonun ismini yazar�z..
--	 "ADD" komutu tabloya bir �ey EKLEMEM�Z� sa�lar! "ADD CONSTRAINT" komutu ile bir "constraint" ekliyoruz..
--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemi� oluruz. Sonras�ndaki yazd���m�z ifade ise bir
-- atamad�r. A�a��da ; yaratt���m�z "PK_Orders_Employees" isminde bir de�i�kene , k�s�tlamam�z� atad�k!

--	 "FOREIGN KEY()" komutu ile, i�erisine yazd���m�z kolonun "Foreign Key" �zelli�inin olmas�n� istiyoruz. Yani
-- referans g�sterece�imiz di�er tablolarla ili�kili olsun istiyoruz...
--	 "REFERENCES" komutu ile de ; burada "FOREIGN KEY()" komutunda yazd���m�z 'Kolonun' , hangi Tablodaki Kolonla
-- ili�kili olmas�n� istiyorsak onu yaz�yoruz. "REFERENCES" komutu sonras�nda da 'Tablonun' ve ili�kili 'Kolonunun'
-- ismini yaz�yoruz.

ALTER TABLE dbo.Orders
  ADD CONSTRAINT FK_Orders_Employees
  FOREIGN KEY(empid)
  REFERENCES dbo.Employees(empid);

--	Solda, "dbo.Orders" tablosunun i�erisindeki "Columns" klas�r�n�n i�erisinde "empid (FK)" Kolonumuz g�m�� renkli
--anahtar �ekilnde olu�tu.


------ Tablolar�m�z� G�relim: ------
SELECT * FROM [ITUmindset].[dbo].[Employees] 
SELECT * FROM [ITUmindset].[dbo].[Orders]


------ Veri Giri�i Yapal�m (Order i�in) ------
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
----	NOTE:	Yukaridaki veri giri�i i�in olan kodu �al��t�rd�k ve HATA ALDIK!
----	Hata : "dbo.Employees" tablosunda olmayan bir "empid" de�erini "dbo.Orders" tablosu i�in girmeye �al���yorsun.
----	Bunu yapamazs�n diyor! ��nk� "Foreign Key" �zelli�imiz ile bu iki tablodaki "empid" Kolonlar�n� Birbirlerine
----	E�LED�K !!!
----	REFERANS olarak verdi�imiz "Employees" tablosunda OLMAYAN hi�bir "empid" de�eri "Orders" tablosunda OLAMAZ !!!
----	REFERANS olarak verilen tablo , K�stas Tablosudur! Yaz�lan de�er �NCE o Tabloda olmal�d�r !!!

------	A�a��da D�zelterek Deneyelim :
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


------ Tekrar Tablolar�m�z� G�relim : ------
  SELECT * FROM [ITUmindset].[dbo].[Employees] 
SELECT * FROM [ITUmindset].[dbo].[Orders]


---------- "Foreign Key" ile Birbirlerine �li�kilendirilmi� Kolondan , Bir Veri Silme ----------
delete from dbo.Employees where empid = 1909

------ VEYA ------
delete from [ITUmindset].[dbo].[Employees] where [empid] = 1909

----	NOTE  :  �al��t�rd���m�zda bir hata ald�k !!!
----	"Foreign Key" ile birbirlerine ili�kilendirdi�imiz bir kolondan veri silmemiz m�mk�n de�ildir!!! ANCAK ,
----	o veri �zerinde bir De�i�iklik yapabiliriz... Yani o veriyi gerekiyorsa Anonimle�tirebiliriz...
----	G�rd���m�z gibi, "Foreign Key" sayesinde veriyi korumu� da oluyoruz !!!
----        ANCAK , illaki bir veri silmek istiyorsak ; �NCEL�KLE , REFERANS ald���m�z Tablodaki ili�kili Kolondan
----    o veriyi silmemiz gerekiyor !!!


---------- Tablolar�n Silinmesi ----------
DROP TABLE dbo.Orders , dbo.Employees ;


---------- Yeniden Tablolar� Olu�tural�m ----------
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

--	 "ALTER" komutu tabloda DE����KL�K, G�NCELLEME yapmam�z� sa�lar! "ALTER TABLE" komutundan sonra, de�i�iklik yapmak
-- istedi�imiz tablonun ismini yazar�z...
--	 "ADD" komutu tabloya bir �ey EKLEMEM�Z� sa�lar! "ADD CONSTRAINT" komutu ile bir "Constraint" ekliyoruz...
--	 "ADD  CONSTRAINT" komutu ile de tabloya bir KISITLAMA eklemi� oluruz. Sonras�ndaki yazd���m�z ifade ise bir
-- atamad�r.

ALTER TABLE dbo.Employees
  ADD CONSTRAINT CHK_Employees_salary
  CHECK(salary > 2900);

  INSERT INTO [Employees]
(empid, [firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1900, 'ALPER','CEYLAN','2020-12-01',133,'36715774475',3100)


---------- Tablolar�n Silinmesi ----------
DROP TABLE dbo.Orders , dbo.Employees;


----    NOTE  :  'Constraint''leri , illaki ALTER TABLE ile yapmam�za gerek yoktur. CREATE TABLE ile de yaratabiliriz...


--------------- CONSTRAINT'lerin , Tablo Olu�turulurken Belirtilmesi ---------------

IF OBJECT_ID ('dbo.testCustomer') IS NOT NULL BEGIN        
	DROP TABLE dbo.testCustomer;    
END;
GO    


CREATE TABLE dbo.testCustomer (        
	CustomerID INT NOT NULL IDENTITY(1, 1) ,      --   Customer ID (M��teri No)
	FirstName  VARCHAR(25) , 
	LastName   VARCHAR(25) ,        
	--Age      INT ,	  (Buray� comment hale getirdik ��nk� ya� her sene de�i�ir! Onun yerine do�um tarihi tutulur) :
	BirthDate  DATE ,	  --   G�n�m�zden , do�um tarihi ��kar�larak bulunur.
	isActive   bit ,	  --   Sadece , '0' veya '1' de�eri al�r.
	Gender	   CHAR(1) DEFAULT 'F' ,     --   Cinsiyet, tek bir karakter alacak (CHAR(1)) !! De�er girilmezse "F" olacak!
	--   Bu yukar�daki  "CHAR(1) DEFAULT 'F'"  kodu da , bir 'Constraint''dir...       
	CONSTRAINT ch_testCustomer_Gender CHECK (Gender IN ('F' , 'M' , 'U' , 'T')) ,     -- 'Gender' kolonu , her karakteri
																		--almas�n diye de , bir 'Constraint' ekliyoruz...
	CONSTRAINT PK_testCustomer PRIMARY KEY (CustomerID)
	--CONSTRAINT ch_testCustomer_Age CHECK (Age < 140) ,   (Buray� da comment hale getirdik. ��nk� 'Age' kolonunu sildik)
	) ;


IF OBJECT_ID('dbo.testOrder') IS NOT NULL 
BEGIN        
	DROP TABLE dbo.testOrder;    
END;    
GO


--------------- SELECT GETDATE() ---------------

----	NOTE  :	 "GETDATE()" komutu, bize DEFAULT olarak sunucumuzun SAAT�N� verir!

--	 Computed Column (Hesaplanm�� Kolon) i�lemlerinde kullan�l�r =
--	 Veri taban�nda bir Kolon olu�turuyoruz. Ama o Kolona bir de�er G�REM�YORUZ... O Kolonda sadece , ba�ka Kolonlar
-- aras�ndaki Matematiksel i�lemleri g�rmek istiyoruz !

--   A�a��da DEFAULT haliyle yaz�lm�� olan pembe renkli 'GETDATE()' fonksiyonu bize , Sunucunun Zaman�n� verir...

CREATE TABLE dbo.testOrder (
	CustomerID  INT NOT NULL,
	OrderID		INT NOT NULL IDENTITY,
	OrderDate	DATETIME DEFAULT GETDATE(),
	Price		Money NOT NULL,		    -- 5
	Qty			INT NOT NULL,		    -- 10
	LineItemTotal AS (Price * Qty),		-- 50		 -- Bu kolondaki veriyi de�i�tiremeyiz! Matematiksel i�lem kolonu!
	CONSTRAINT fk_testOrders
	FOREIGN KEY (CustomerID)
	REFERENCES dbo.testCustomer(CustomerID),
	CONSTRAINT PK_TestOrder PRIMARY KEY (OrderID)
	);
--	 Solda, "dbo.testOrder" tablomuzun "Columns" klas�r�ne bakt���m�zda, "LineItemTotal(Computed,money,null)" ifadesini
-- g�r�yoruz. �ekli di�erlerinden farkl�! Bu "LineItemTotal" kolonuna herhangi bir "insert" i�lemi yapamay�z! Yani bir
-- veri giri�i YAPAMAYIZ! Bu kolon, di�er kolonlarla ilgili matematiksel i�lemleri tutar!
-- 	Yine solda, "dbo.testOrder" tablomuza sa� t�klay�p "Script Table as"'a gelip "INSERT to"'ya t�klad���m�zda, haz�r
-- "insert" komutu geliyor. O komutta da g�rd���m�z gibi "LineItemTotal" kolonu YOK! ��nk� bu kolona "insert" yap�lamaz!
-- Ama di�er kolonlar i�in i�lemleri buradan rahatl�kla yapabiliriz..




------------------------------------------------------------------------------------------------------------------------




-------------------- 'AdventureWorks1' isimli Veri Taban�na Ge�i� Yapal�m --------------------

USE [AdventureWorks1]



--------------- F�LTRELEME ---------------

-- 'FROM'    :  Kaynaklar�m�z� (Tablolar�m�z�) yaz�yoruz.
-- 'SELECT'  :  G�rmek istedi�imiz Alanlar� (Kolonlar�) yaz�yoruz.
-- 'WHERE'   :  �stedi�imiz Filtreleri (Verileri) yaz�yoruz.


---------- Tablodaki T�m Kay�tlar�n G�sterilmesi ----------
SELECT * FROM AdventureWorks_Customers


---------- Tablodaki Belirli Kolonlar�n G�sterilmesi ----------
----    NOTE  :  Normalde , Kolonlar�n isimlerini yazarken ; Kolon isimlerinin aralar�nda bo�luk olma ihtimalinden
----    dolay� , Kolon isimlerini K��eli Parantez i�erisinde yazmal�y�z... AMA e�er Kolon isminde bir bo�luk yok
----    ise K��eli Parantez kullanmadan direkt Kolon ismini de yazabiliriz...
SELECT CustomerKey , Prefix , FirstName , LastName , EducationLevel , HomeOwner FROM AdventureWorks_Customers;

-- Kolon ismini de�i�tirmek i�in de ; 'as' tak�s�n� kullanmal�y�z :
SELECT CustomerKey as [Customer ID] , Prefix , FirstName , LastName, EducationLevel FROM AdventureWorks_Customers;


---------- Tablodaki �lk 100 Kay�d�n G�sterilmesi ----------
SELECT top 100 CustomerKey , Prefix , FirstName , LastName FROM AdventureWorks_Customers;
-- ('MySQL' i�in  :  SELECT CustomerKey, Prefix, FirstName, LastName FROM AdventureWorks_Customers LIMIT 100 ;)


---------- Tablodaki �lk Y�zde Birlik (%1) Kay�tlar�n G�sterilmesi ----------
SELECT top 1 percent CustomerKey , Prefix , FirstName , LastName , EducationLevel FROM AdventureWorks_Customers;

----    NOTE  :  Yukar�daki yapt���m�z Filtreleme i�lemlerinde , �NCE b�t�n Tabloyu okuyor sonra Filtreleme i�lemi
----    ger�ekle�tiriyor...



--------------- 'WHERE' ile Filtreleme ---------------

-- B�t�n Tabloyu G�RMEDEN , sadece istedi�imiz verileri Filtreleyip okumak istiyorsak , 'WHERE' kriterini kullan�r�z...

----	NOTE  :  E�itlik "=" operat�r� ; B�REB�R AYNI olan de�erleri g�sterir! Yani E�itlik sonras�nda yaz�lan de�ere ,
----    TAM denk gelen de�erleri g�sterir. Mesela a�a��da "Bike Racks" yazd���m�zda ; ba�ka bir , i�erisinde "Bike"
----    olan veri sat�r�n� g�stermez..! Sadece Tam olarak "Bike Racks" yazan veri sat�rlar�n� g�sterir...

SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey
FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  =  'Bike Racks'; 

SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  <>  'Bike Racks';		-- "<>" (E�it De�ildir)
 ------ VEYA ------
SELECT ProductSubcategoryKey , SubcategoryName , ProductCategoryKey FROM AdventureWorks_Product_Subcategories
WHERE SubcategoryName  !=  'Bike Racks';		-- "!=" (E�it De�ildir)



--------------- 'BETWEEN' Komutu ---------------
-- �stedi�imiz , NUMERIK olan de�er veya de�erler ; Birbirlerinin ARASINDA ise 'BETWEEN' komutunu kullanabiliriz : 

SELECT OrderDate
	,StockDate
	,OrderNumber
	,ProductKey     
	,CustomerKey     
	,TerritoryKey   
	,OrderQuantity 
FROM AdventureWorks_Sales_2017

WHERE TerritoryKey  BETWEEN  5 and 7;
----	NOTE:	"BETWEEN" komutunda , mesela yukar�da '5' ile '7' de�erleri aras�n� g�stermesini istedik. Bu komut
----    ile kulland���m�zda , hem '5' hem de '7' de�erleri DAH�L ED�L�YOR..!   Yani   '5' <= 'X' >= '7'   gibi...

-- VEYA , 'BETWEEN' Komutunu Kullanmadan da yapabiliriz : 
WHERE TerritoryKey >= 8  and  TerritoryKey <=10;



--------------- 'E�it De�ildir' Filtresi ---------------
SELECT ProductSubcategoryKey, SubcategoryName, ProductCategoryKey FROM AdventureWorks_Product_Subcategories WHERE SubcategoryName <> 'Bike Racks'
---- VEYA ----
SELECT ProductSubcategoryKey, SubcategoryName, ProductCategoryKey FROM AdventureWorks_Product_Subcategories WHERE SubcategoryName != 'Bike Racks'



--------------- 'Tarih Aral���' Filtresi ---------------
--   Yine istersek 'BETWEEN' komutu ile yapar�z. �stersek de 'k���k e�ittir - b�y�k e�ittir' operat�rleri ile yapar�z :
SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017
WHERE StockDate >= '1-1-2003'  AND  StockDate <= '12-30-2003';

SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017 
WHERE StockDate  BETWEEN  '1-1-2003'  AND  '12-30-2003';



--------------- 'OR (VEYA)' Kullan�m� ---------------
--   Her iki ko�ulun da sa�lanmas� gerekti�i durumlarda hep 'AND' kulland�k... AMA iki ko�uldan biri sa�lansa da bize
-- yeter diyorsak , 'OR' komutunu kullan�r�z...
SELECT StockDate , OrderNumber , OrderQuantity , CustomerKey FROM AdventureWorks_Sales_2017
WHERE CustomerKey >= 14000  OR  CustomerKey < 16000


--------------- 'NULL (Bo� Veri)' Kontrolu ---------------
SELECT CustomerKey , BirthDate , EmailAddress , AnnualIncome
FROM AdventureWorks_Customers
WHERE EmailAddress IS NULL
--	 BO� Veri kontrol� i�in ; "WHERE" komutu i�erisinde, arama yapaca��m�z kolon ismini ve "IS NULL" komutunu yazar�z!

SELECT CustomerKey , BirthDate , EmailAddress , AnnualIncome
FROM AdventureWorks_Customers
WHERE EmailAddress IS NOT NULL
--   BO� OLMAYAN Verilerin kontrol� i�in de ; "WHERE" komutu i�erisinde, arama yapaca��m�z kolon ismini ve "IS NOT NULL"
-- komutunu yazar�z!



------------------------------------------------------------------------------------------------------------------------
--------------- Veri Tabanlar�n� �EMALARINA Ay�rma i�lemlerini neye g�re yap�yoruz ? ---------------

--   �irketin Veri Taban�n� haz�rlarkenki yapaca�� operasyonlara g�re ayarlanabilir veya �irketin departmanlar�na
-- g�re de olabilir...
--   Mesela Veri Setini , Veri Taban�nda HAM �ekilde tutuyorsak 'DBO' �emas�nda tutuyoruz. Ama mesela bir Data Scientist
-- o veriyi al�p manip�lasyonunu yapt�ktan sonra 'STAGE' diye bir �emada saklayabiliyor. En sonunda da en nihai halini
-- ald���nda 'RESULT' veya 'ANALYSIS' veya 'DS' diye farkl� �emalarda bas�yoruz ki bizimle �al��anlar �unu anl�yor ; 
-- DS �emas� En Son sonucu veren �ema olarak olu�turuluyor... gibi ...
------------------------------------------------------------------------------------------------------------------------



--------------- SIRALAMA - �rnek 1 ---------------

----	NOTE  :	 "ORDER BY" komutu HER ZAMAN sorgu kodlar�m�z�n EN ALT SATIRINA , EN ALT KISMINA YAZILIR!
----	NOTE  :  "DESC" komutu, "Z"'den "A"'ya s�ralar!
----	NOTE  :	 "ASC" komutu, "A"'dan "Z"'ye s�ralar!

SELECT CustomerKey , LastName , FirstName , Prefix , MaritalStatus
FROM AdventureWorks_Customers
WHERE MaritalStatus IS NOT NULL
ORDER BY LastName DESC , FirstName ASC
--   Burada ; �NCE , 'LastName''ye g�re "Z"'den "A"'ya s�ralad�k ,
-- SONRA da 'FirstName''ye g�re "A"'dan "Z"'ye s�ralad�k!


--------------- SIRALAMA - �rnek 2 ---------------

SELECT CustomerKey , LastName , FirstName , Prefix , MaritalStatus
FROM AdventureWorks_Customers
WHERE MaritalStatus IS NOT NULL
ORDER BY 2 DESC , 3 ASC
--	 Burada da ; yukar�daki "SELECT" komutundaki Kolon isimlerini yazd���m�z s�raya g�re , ka��nc� s�radaki Kolona
-- g�re i�lem yapacaksak , o kolonun s�ras�n� yazabiliyoruz , yani Kolonlar�n s�ra numaralar�n� da yazabiliyoruz...
-- Mesela burada ; "SELECT" komutunda yazd���m�z "LastName" Kolonu '2.' s�radaki Kolon , "FirstName" Kolonu da '3.'
-- s�radaki Kolon. Bu Kolonlar�n sadece s�ra numaralar�n� yazarak da sorgu yapabiliyoruz!
--   Yani bir �stteki Kolon isimlerini yazarak yapt���m�z s�ralaman�n ayn�s�n� yapt�k...




--------------- 'LIKE' Komutu ---------------

----	NOTE  :  Her zaman kesinlik i�eren veya bir aral�k i�eren sorgular yapmak zorunda de�iliz! Mesela yukar�da
----	yapt���m�z , kolonda "Bike Rack" yazan sat�r� getir gibi , tarih aral�klar� gibi veya 14000-16000
----	aral���ndakileri getir gibi sorgular yapmak zorunda de�iliz...
----	      ��erisinde �u olan , bu harf olan , ... gibi sorgumalar da yapabiliriz. Ve bunu "LIKE" komutu
----	ile  yapar�z!

----    NOTE  :  'LIKE' komutu , 'Varchar()' , 'Char()', ... gibi 'STRING' de�erler alan yerlerde sorgulanabilir...

----	NOTE  :	 "LIKE" komutunda, i�erisine yazd���m�z harf veya kelimenin b�y�k veya k���k yaz�lmas�n�n bir �nemi YOK!

----	NOTE  :	 "LIKE" komutunu kullanman�n bir handikap� vard�r! �zellikle Canl� Veritaban�nda kullan�yorsak ve Sat�r
----	Say�s� da �ok fazlaysa , "LIKE" komutu tabloyu okumam�zda bir yava�l��a sebep olur! ��nk� "LIKE" komutu ,
----	yapt���m�z aramada T�m Tabloyu Scan Eder (Tarar) ve sonra sonucu verir...


---------- LIKE 1 ----------

--	Bu sorguda diyoruz ki; "AdventureWorks_Customers" tablosuna git, "LastName" ve "FirstName" kolonlar�n� g�ster ve
--"LastName" kolonunda yaz�l� veriler i�erisinde "G" harfi ile B�TEN sat�rlar� g�ster!

----	NOTE  :	 '%G' = "G" harfi ile B�TEN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers   
WHERE LastName LIKE '%G' ;   


---------- LIKE 2 ----------

----	NOTE  :	 't%' = "t" harfi ile BA�LAYAN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers   
WHERE FirstName LIKE 't%';   


---------- LIKE 3 ----------

----	NOTE  :	 '%ang%' = ��ER�S�NDE "ang" harf dizisi GE�EN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers     
WHERE LastName LIKE '%aNg%';


---------- LIKE 4 ----------

----	NOTE  :	 NOT LIKE '%ang%';  =  ��ER�S�NDE "ang" harf dizisi GE�MEYEN demek!

SELECT LastName , FirstName    
FROM AdventureWorks_Customers     
WHERE LastName NOT LIKE '%ang%';




--------------- 'CONCAT' Fonksiyonu ---------------

SELECT Prefix , FirstName , LastName
FROM AdventureWorks_Customers; 

----	NOTE  :	 Yukar�daki kod sat�rlar� ile "AdventureWorks_Customers" tablomuzdaki "Prefix , FirstName , LastName"
----	kolonlar�n� g�sterdik. Bu kolonlar� TEK bir kolon haline getirmek i�in iki farkl� y�ntem kullan�r�z.
----	Birincisi, "+" operat�r�n� kullanarak kolonlar� birle�tirir ve tek kolon haline getiririz. "AS" komutunu ile
----    de , birle�tirilmi� haldeki kolona istedi�imiz �smi veririz...
----	�kincisi de , "CONCAT" fonksiyonunu kullan�r�z.

----	NOTE  :	 "CONCAT" kullanmam�z�n en �nemli sebeplerinden birisi de, "Type Casting" yani "Tip D�n��t�rme"
----	yapmam�z gerekti�inde , yani datalar�n tiplerinin de�i�tirilmesi gerekti�inde "CONCAT" Fonksiyonu bunu
----    ba�ka bir �ey gerekmeden kendi kendine yap�yor!


---------- �lk Y�ntem ----------
SELECT Prefix + ' ' + FirstName + ' ' + LastName + ' ' AS FullName
FROM AdventureWorks_Customers; 



---------- �kinci Y�ntem ----------
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




--------------- !!! Bo� Kay�t Fonksiyonu (ISNULL()) !!! ---------------

--	Tablomuzdaki "CustomerKey" kolonunda Bo� bir sat�r varsa onu g�rmek i�in kulland���m�z kod:
SELECT * FROM AdventureWorks_Sales_2017 WHERE CustomerKey IS NULL;

----	NOTE  :	 "NULL" olan de�erlerin yerine ba�ka bir de�er vermek istiyorsak "ISNULL" fonksiyonunu kullan�r�z!!

----	NOTE  :	 "ISNULL" fonksiyonumuzun i�erisindeki ilk parametresi ; g�rmek istedi�imiz kolonun bo� olup
----    olmad���n� sorgular. Virg�lden sonraki olan ikinci parametresi ise e�er h�cre bo� ise ; yerine DEFAULT
----    olarak ne yaz�lmas� gerekti�ini g�sterir! Sonras�nda da "AS" komutu ile kolonumuza yeni isim verebiliriz..

----	NOTE  :	 "ISNULL" fonksiyonumuzu kullanmam�z�n temel sebebi, son kullan�c�n�n tabloya bakt���nda daha kolay
----	anlamas�n� sa�lamakt�r...

SELECT OrderNumber , ISNULL(CustomerKey , 'No Customer ID') AS [Customer ID] , TerritoryKey , OrderQuantity
FROM AdventureWorks_Sales_2017;  


---------- H�cre Bazl� Hesaplama ----------

----	NOTE  :  "VARCHAR()" de�erleri i�inde herhangi bir matematiksel i�lem yapamay�z!

----    NOTE  :  H�cresel bazl� hesaplamalarda e�er Tabloyu CREATE ederken yap�yorsak , mesela iki kolon aras�ndaki
----    aritmetik operat�r� koyup (art� , eksi , �arp� , b�lme , ... gibi) orada bir Computed Column (Hesaplanm�� Kolon)
----    i�lemi yapabiliriz. Ve biz ona 'insert' de�eri girmeden program otomatik kendisi hesaplamas�n� yapar...

----	NOTE  :	 �zellikle "NULL" ifadesi ; �arpma , b�lme ve ��karma i�lemlerinde b�y�k problem ��kart�r! Bu
----    problemi ��zmek i�in de "ISNULL()" fonksiyonu kullan�labilir...

--   Sorgu baz�nda bir i�lem yapmak istersek de "ISNULL" fonksiyonunu kullanabiliriz :

----    NOTE  :  A�a��daki mesela "ISNULL(ProductKey , 0)" komutunda ; 'ProductKey' kolonundaki de�er BO� de�er ise
----    yerine '0' koy demi�iz...

SELECT OrderNumber , (ProductKey + CustomerKey) AS PCK ,
	   ISNULL(ProductKey , 0) + ISNULL(CustomerKey , 0) AS PCK2
FROM AdventureWorks_Sales_2017 ; 

----    NOTE  :  Yukar�daki "(ProductKey + CustomerKey)" yap�s� ile ISNULL(ProductKey , 0) + ISNULL(CustomerKey , 0)
----    yap�s�n�n normalde hi�bir fark� yok gibi g�r�n�yor AMA 'ISNULL()' fonksiyonunu kullanarak yapmam�z�n sebebi ;
----    E�er ki ilk hesaplamada kolonlardan en az biri NULL de�er ise , sonu� direkt NULL ��k�yor... Ama biz o NULL
----    de�eri o �ekilde g�rmek istemiyoruz , onun yerine '0' yazmas�n� istiyoruz... Onun i�in de 'ISNULL()'
----    fonksiyonunu kullan�yoruz...

--	 A�a��daki kod sat�r�ndaki "ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1)" k�sm�nda :
--	 B�LME i�leminde Payda "0" olamayaca�� i�in ; "CustomerKey" de�erimiz "0" �SE onu "1" yap , DE��LSE "CustomerKey"
-- de�erini ayn� �ekilde tut demi�iz... Sonras�nda da 'ISNULL()' fonksiyonu ile , bu
-- "(IIF(CustomerKey=0 , 1 , CustomerKey))" de�erinin i�erisinde "NULL" de�eri VARSA , onu da "1" olarak tut demi�iz...
-- Yani kontrol etmek i�in ; "ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1)" komutunu yazm���z...
SELECT OrderNumber , ISNULL(ProductKey, 0) / ISNULL(IIF(CustomerKey=0 , 1 , CustomerKey) , 1) AS PCK2
FROM AdventureWorks_Sales_2017 




--------------- 'IN' Komutu ---------------

----	NOTE  :	 Bir filtreleme i�leminde B�RDEN FAZLA filtreleme yapacaksak "IN" komutunu kullanabiliriz...

----	NOTE  :	 "IN" komutunun i�erisine yazaca��m�z ifadelerin Tam ve Do�ru olmas� gerekir. En ufak yanl��l�kta
----	arad���m�z sat�rlar� g�remeyiz...

----    NOTE  :  Ama , 'b�y�k - k���k harf' uyumuna uyulmas�na gerek yok...

----	NOTE  :	 Arama yaparken,  ""  i�areti KULLANAMAYIZ...  ''  i�aretini KULLANMALIYIZ...

select *  FROM AdventureWorks_Customers
WHERE Occupation IN ('bachelors' , 'graduate Degree')


--------------- Di�er Y�ntemler ---------------

---------- 'NOT IN' ----------

select *  FROM AdventureWorks_Customers
WHERE Occupation NOT IN ('Bachelors' , 'Graduate Degree')


---------- 'OR' ----------

WHERE Occupation = 'Bachelors'  OR  Occupation = 'Graduate Degree'

----	NOTE  :	 "OR" metodu da �ok tavsiye edilen bir y�ntem de�ildir. Bu da "LIKE" metodu gibi sistemi yava�lat�r...




--    ** condition == Ko�ul , Durum , �art. **


--------------- !!! 'IIF' Fonksiyonu !!! ---------------

----	NOTE  :	 "IIF" fonksiyonunu i�erisine �LK �NCE 'condition''u yazaca��z...

----	NOTE  :	 Bu "IIF" fonksiyonunu , daha �ok NUMER�K OLMAYAN verileri NUMER�K hale d�n��t�rmek i�in kullan�r�z...

--	  A�a��daki kod sat�r�nda ;
-- "Occupation" kolunundaki "Graduate Degree" verisini i�erenleri "1" yap , di�erlerini "0" yap diyoruz ve o kolunun
-- ad�n� da 'OCCUPATION' yap diyoruz... :

SELECT CustomerKey , FirstName , LastName , IIF([Occupation] LIKE 'Graduate Degree' , 1 , 0) AS OCCUPATION
FROM AdventureWorks_Customers


----    NOTE  :  Bu b�l�mde yapt�klar�m�z�n tamam� , Data �ekme i�lemleri ile ilgiliydi...



------------------------------------------------------------------------------------------------------------------------





-------------------- FONKS�YONLAR ve DE���KEN TANIMLAMA --------------------

---------- Bir "email" �rne�i Yapal�m : ----------

----    NOTE  :  Mesela 'C++''da bir de�i�ken tan�mlamak istiyorsak direkt "int x = 3;" yazabiliriz... 'x' art�k
----    bir integer de�i�kendir... 'SQL''de ise De�i�ken tan�mlamak i�in 'DECLARE' komutunu kullanmam�z gerekir...
----    'DECLARE' komutu ile bir DE���KEN yarat�r�z... 'SET' komutu ile de o De�i�kene , DE�ER atar�z...
----    NOTE  :  'SET' komutunu Kullanmadan da DE�ER atayabilirdik... MEsela a�a��da direkt ,
----    " DECLARE @email VARCHAR(50) = 'alperceylan009@itu.edu' "  yazsayd�k , yine DE�ER� atayabilmi� olurduk...

----    NOTE  :  A�a��lardaki 'SELECT' komutlu KODLARI �al��t�r�rken , Muhakkak beraberinde ayn� anda 'DECLARE'
----     komutlu sat�rlar�n da �al��t�r�lmas� gerekiyor... Yoksa 'SELECT' komutu , Yaratt���m�z Atamay� bulamaz...

-- "VARCHAR(50)" T�r�nde , "@email" �sminde bir DE���KEN yarat :
DECLARE @email VARCHAR(50)
SET @email = 'alperceylan009@itu.edu.tr'
----	+ Veri Setimizdeki bir ki�inin , okul 'email''i olup olmad���n� ��renmeye �al��al�m :

--	E�er "@" i�aretinden sonra ".edu" ifadesi ge�iyorsa , bu bir okul mail adresidir...

SELECT @email AS [Mail Address] ,
	IIF(@email LIKE '%.edu.%' , 1 , 0) AS is_University ,
	--	Yukar�daki kod ile, okul maili ise "1" de�ilse "0" d�ns�n istiyoruz...


    ---------- LEN() Fonksiyonu ----------
	--	��erisine yazd���m�z ifadenin uzunlu�unu bulur :
	LEN(@email) AS [LEN(@email)] ,


    ---------- LEFT() ----------
	--	"@email" atamam�z�n i�erisindeki ifadede , �LK iki karakteri g�rmek istiyorsak :
	LEFT(@email , 3) AS [LEFT(@email , 3)] ,


    ---------- RIGHT() ----------
	--	"@email" atamam�z�n i�erisindeki ifadede SON d�rt karakteri g�rmek istiyorsak :
	RIGHT(@email , 4) AS [RIGHT(@email , 4)] ,


	---------- SUBSTRING() Fonksiyonu ----------
	--	 "@email" atamam�z�n i�erisindeki '3.' karakterden BA�LA ve d�rt karakter �LER� do�ru git ve bunlar�n hepsini
	-- g�r demek istiyorsak :
	----	NOTE  :	 Saymaya da "0"'dan DE��L , "1"'den ba�lar!
	SUBSTRING(@email , 3 , 4) AS [SUBSTRING(@email , 3 , 4)] ,


	---------- CHARINDEX() Fonksiyonu ----------
	--	 "CHARINDEX" fonksiyonu da ; i�erisine virg�lden �nceki yazd���m�z ifadenin , virg�lden sonraki yaz�lan
	-- ifadenin i�inde , KA�INCI SIRADA oldu�unu s�yl�yor... Yani INDEX'ini s�yl�yor...
	-- Yani , CHARINDEX() Fonksiyonu ; i�erisinde virg�lden �NCE yazd���m�z ifadeyi , virg�lden SONRAK� Kolonda
    -- arar... Ve o ifadeyi Ka��nc� Index'te bulduysa , O index'i de d�ner... (Saymaya da '1''den ba�lar...!)
	----	NOTE  :	 Saymaya da "0"'dan DE��L , "1"'den ba�lar!
	CHARINDEX('@' , @email) AS [CHARINDEX('@' , @email)] ,

---- Step 1 ----
SELECT CustomerKey , CHARINDEX('5' , CustomerKey) as [INDEX]
FROM AdventureWorks_Sales_2017 ;

---- Step 2 ----
SELECT EmailAddress ,
	SUBSTRING(EmailAddress , CHARINDEX('-', EmailAddress) + 1 , 25) AS MailProvider
FROM AdventureWorks_Customers ;
		
		

	---------- 'Email Provider (DOMAIN)''i Bulal�m : ----------

	--    ** provider == Sa�layan , Sa�lay�c� , Kar��layan. **

	--	 "CHARINDEX" ile "@" ifadesinin , ka��nc� karakterde oldu�unu bulup , o kadar karakteri b�t�n metnin
	-- uzunlu�undan kesersek , "domain"'imizi buluruz... Yani "alperceylan009@itu.edu.tr" metninin karakter
	-- uzunlu�undan , "@" ifadesine kadar olan k�sm� tamamen kesersek sadece "@" sonras� ifade kal�r... :

	--	 RIGHT (@email , METN�N TAMAMI Eleman say�s�  -  '@' VE �NCES�N�N Eleman say�s�)   Yani ; 25 - 15 = 10
	RIGHT (@email , LEN(@email) - CHARINDEX('@' , @email)) as ["@"'den Sonras�] ,

	CHARINDEX('.' ,  RIGHT (@email , LEN(@email) - CHARINDEX('@' , @email))) as [Noktan�n S�ras� (Index'i)] ,

	LEFT(RIGHT(@email, LEN(@email) - CHARINDEX('@', @email))  ,  CHARINDEX('.', RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))) - 1) as Email_Provider_Domain ,


	--	 'Public Provider' mi? Diye de bakal�m :
	IIF(LEFT(RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))  ,  CHARINDEX('.', RIGHT (@email, LEN(@email) - CHARINDEX('@', @email))) - 1)
	IN ('gmail' , 'hotmail' , 'yahoo' , 'mynet' , 'outlook' , 'microsoft') , 1 , 0) AS is_Puclic_Provider ,


select * from AdventureWorks_Customers



	---------- LOWER() Fonksiyonu ----------
	--	 Hepsini k���k harf haline getirir :
	LOWER(@email) AS [LOWER(@email)] ,


	---------- UPPER() Fonksiyonu ----------
	--	 Hepsini b�y�k harf haline getirir :
	UPPER(@email) AS [UPPER(@email)] ,


	---------- RTRIM() Fonksiyonu ----------
	--	 Sa�daki(right) bo�luklar� kald�r�r :
	RTRIM(@email) AS [R-TRIM(@email)] ,
	

	---------- LTRIM() Fonksiyonu ----------
	--   Soldaki(left) bo�luklar� kald�r�r :
	LTRIM(@email) AS [L-TRIM(@email)] ,
	

	---------- REPLACE() Fonksiyonu ----------
	--	 "REPLACE" fonksiyonu ; i�erisindeki ikinci de�eri , ���nc� de�er ile de�i�tirir :
	REPLACE(@email , '@' , '_') AS [REPLACE(@email , '@' , '_')] ;


----	NOTE  :	 Haz�r "String" Fonksiyonlar� , Solda S�ras� ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	i�erisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak ��in de Yukar�da S�ras� ile :
----	View - Template Browser - Function -

----    NOTE  :  Bo� zamanlar�m�zda , Fonksiyon yaratma egzersizleri yapmam�z�n bize b�y�k katk�lar� olacakt�r..!

----------------------------------------------------------------------------------------------------------------------




-------------------- TAR�H FONKS�YONLARI --------------------


----    NOTE  :  Program�m�z�n D�L�N� 'T�RK�E' yapmak istersek :
SET LANGUAGE TURKISH


----    'GETDATE()' Fonksiyonu ; TAM �u an�n Tarih ve Saatini verir...

----    'YEAR()' Fonksiyonu ; i�erisine yazd���m�z ataman�n SADECE Y�l�n� g�sterir...

----    'DATEPART()' Fonksiyonu ; Bu fonksiyonun i�erisine , Date'nin Hangi Par�as�n� g�rmek istiyorsak onu yaz�yoruz...

----    'DATENAME()' Fonksiyonu ; i�erisine Date'nin Hangi Par�as�n� yazarsak , o Date bilgisinin 'String' yaz�l���n�
---- g�steriyor...

----    'DATEDIFF()' Fonksiyonu ; iki TAR�H aras�ndaki fark� almak istiyorsak kullan�yoruz. Bu fonksiyonda
---- �nemli olan �ey ; iki Tarihin Hangi Par�alar�n�n Fark�n� almak istiyorsak belirtmemiz gerekti�idir... Mesela
---- iki Tarihin aylar�n�n fark�n� m�? G�nlerinin fark�n� m�? vb...
----    Mesela ;  " DATEDIFF(YEAR , ilk tarih , ikinci tarih) "  gibi... Mesela bunu hesaplayarak YA�I
---- bulabiliyoruz...

----    'CONVERT()' Fonksiyonu ; Tarih Fonksiyonuna bakt���m�zda , mesela 'GETDATE()' fonksiyonu
---- "y�l-ay-g�n-saat-saniye..." �eklinde s�ral�yor... Ama bu t�m Formatlarda bu �ekilde s�ralanmaz... �lke �lke
---- bile de�i�iyor... Bu tarz farkl�l�klar� d�zenlemek i�in �e�itli FORMATLAR vard�r. Bunu da CONVERT() Fonksiyonu
---- ile yap�yoruz... Bu fonksiyon ; �ki farkl� date tipini , birbirleri ile yer de�i�tirir...
---- ('Y�l' ile 'G�n' bilgilerinin yer de�i�tirmesi gibi...)
----    CONVERT(Data T�P� , De�i�tirilecek DATE , FORMAT)

----    'DATEADD()' Fonksiyonu ; i�erisine yazd���m�z Tarihler �zerinde matematiksel i�lemler yapmam�z� sa�lar...
----    DATEADD(Date Yap�s� , Matematiksel ��lem , Tarih Bilgisi) AS DATE

----    'CAST()' Fonksiyonu ; DATE Tiplerinde �al���rken ; i�erisine yazd���m�z Tarihin , Saat bilgilerini siler
---- sadece "Y�l-Ay-G�n" bilgilerini g�sterir...

----    NOTE  :  A�a��daki 'CONVERT()' Fonksiyonunun i�erisindeki '104' say�s� da , Tarihin s�ralanmas�yla ilgili
----    FORMATLARDAN birinin g�sterimidir... Bu FORMAT Komutlar�n�n listesi de :
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


--------------- Veri Taban� ile Tarih Farkl�l��� Fonksiyonu ---------------

----    NOTE  :  'DATEDIFF()' Fonksiyonu ; iki tarih aras�ndaki fark� almak istiyorsak kullan�yoruz. Bu fonksiyonda
----    �nemli olan �ey ; iki tarihin Hangi Par�alar�n�n Fark�n� almak istiyorsak belirtmemiz gerekiyor... Mesela
----    iki tarihin aylar�n�n fark�n� m�? G�nlerinin fark�n� m�? vb.
----    Mesela ;  " DATEDIFF(YIL , ilk tarihin y�l� , ikinci tarihin y�l�) "  gibi... Mesela bunu hesaplayarak YA�I
----    bulabiliyoruz...

--   A�a��da , 'OrderDate' ile 'StockDate' aras�ndaki g�n fark�n� bulmak istiyoruz ve Fark�n '4850' g�nden fazla
-- oldu�u sat�rlar� Filtreleyip d�nd�rmek istiyoruz... :
SELECT CustomerKey , StockDate , OrderDate ,      
	DATEDIFF(day , StockDate , OrderDate) AS NumberOfDays 
FROM AdventureWorks_Sales_2017
WHERE DATEDIFF(DAY , StockDate , OrderDate) > 4850 ;


--------------- Tarih G�sterim Formatlar� ---------------
----    https://www.sqlshack.com/sql-convert-date-functions-and-formats/

SELECT   
	CONVERT(VARCHAR(12), GETDATE(), 111) AS DATE_1,
	CONVERT(VARCHAR(12), GETDATE(), 104) AS DATE_2,
	CONVERT(VARCHAR(20), GETDATE(), 114) AS DATE_3





-------------------- TABLO ��ER�S�NDE MATEMAT�KSEL HESAPLAMALAR --------------------

--    ** aggregate == Y�����m , K�melenmek , Toplanmak , Hepsi , Topluluk. **

----	NOTE  :	 Haz�r �statistiksel ��lem Fonksiyonlar� , Solda S�ras� ile :
----	Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions - System Functions -
----    Aggregate Functions...  ��erisindedir...


--------------- 'RANDOM' SAYI ---------------

--    'RAND()' Fonksiyonu ile ; her �al��t�rmam�zda bize Rastgele bir say� �retiyor...

SELECT CAST(RAND() * 10 AS INT) + 1;



SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

--------------- Aggregation (Toplama , K�meleme , Birle�tirme) 1 ---------------

--   TOPLAM M��teri say�m�za bakal�m... Yani SAYDIRALIM... Bunun i�in 'COUNT()' Fonksiyonunu kullanabiliriz... :
SELECT COUNT(*) AS CustometKey
FROM AdventureWorks_Customers;


--    ** territory == Faaliyet alan� , Yetki alan� , Alan , B�lge. **

--    'DISTINCT()' Fonksiyonu ; i�erisine yazd���m�z Kolonun BENZERS�Z elemanlar�n� bulur...

--   'TerritoryKey' Kolonunun de�erlerini, BENZERS�Z bir �ekilde SAYDIRMAK istiyorsak da 'DISTINCT()' Fonksiyonunu
-- kullanaca��z... :

SELECT DISTINCT(Occupation) From AdventureWorks_Customers

SELECT COUNT(DISTINCT(Occupation)) FROM AdventureWorks_Customers

SELECT COUNT(DISTINCT(TerritoryKey)) FROM AdventureWorks_Sales_2017



--------------- Aggregation (Toplama , K�meleme , Birle�tirme) 2 ---------------

--    'CAST()' Fonksiyonu ; Data Tiplerinin (Type) de�i�imini bu fonksiyon ile yapabiliriz... KOD'un sonunda hangi
-- Data Tipini istedi�imizi yazmal�y�z...
--    'CONVERT()' Fonksiyonu ; Data Tiplerinin (Type) de�i�imini bu fonksiyon ile de yapabiliriz... ��erisinde ilk
-- �nce , hangi Data Ti�ini istedi�imizi yazmal�y�z...

--    ** round == Yuvarlak , Devir. **

--    'ROUND()' Fonksiyonu ; Bu fonksiyon , i�erisine yazd���m�z NUMER�K de�eri , �stedi�imiz Yere (Basama�a) Kadar
-- YUVARLAMAMIZI sa�ar.

--    'SUM()' Fonksiyonu ; bir de�erin TOPLAMINI almak istiyorsak 'SUM()' Fonksiyonunu kullan�r�z...

----    NOTE  :  'SUM()' Fonksiyonunu kullanabilmemiz i�in , i�erisine yazd���m�z de�erin NUMERIK olmas� �ARTTIR !
----    Bunun i�in de burada �ncelikle 'OrderQuantity' Kolonunun Tipini de�i�tirece�iz... :
ALTER TABLE AdventureWorks_Sales_2017 ALTER COLUMN OrderQuantity INT


--   Sonra da , 'OrderQuantity' Tablomda ka� kay�t var? Ve buna kar��l�k TOPLAM 'OrderQuantity' adeti nedir? Bakal�m :
-- Yani , KA� Sipari�e kar��l�k KA� adet �r�n sat�lm��? Bakal�m : 
SELECT COUNT(*) , SUM(OrderQuantity) , cast(SUM(OrderQuantity) AS VARCHAR(10))
FROM AdventureWorks_Sales_2017 ;

--   Her sipari�te ORTALAMADA ka� tane �r�n gitmi� bakal�m :
SELECT COUNT(*) , SUM(OrderQuantity) , SUM(OrderQuantity) / COUNT(*)  AS TotalProductsOrdered
FROM AdventureWorks_Sales_2017 ;
----    NOTE  :  Yukar�daki i�lemden sonra sonu� olarak '1' d�nd�rd�... ��nk� INTEGER Tipinde bir i�lem yapt��� i�in
----    TAMSAYI bir sonu� verdi... Ama biz b�yle bir sonu� istemiyoruz... Bunun i�in 'ROUND()' Fonksiyonu
----    kullan�labilir :
SELECT COUNT(*) , SUM(OrderQuantity) , ROUND(CAST(SUM(OrderQuantity) AS FLOAT) / CAST(COUNT(*) AS FLOAT) , 4)
FROM AdventureWORKS_Sales_2017 ;


--------------- Aggregation (Toplama , K�meleme , Birle�tirme) 3 ---------------

----    NOTE  :  'MAX()' - 'MIN()' - ... vb. �statistiki Fonksiyonlar�n� bir Kolon �zerinde kullanabilmek i�in ;
----    o Kolonun verilerinin TAMAMEN NUMER�K veri i�eriyor olmas� gerekiyor...
----    BURAYA GER� D�N�P BU PROBLEM� TEKRAR ��ZMEM�Z GEREKECEK... ��nk� a�a��da DOLAR i�aretini kald�rmam�z gerekiyor...

--   En Pahal� �r�n� bulmak i�in de 'MAX()' Fonksiyonunu kullanabiliriz...
SELECT MAX(AnnualIncome) AS MostExpensivePrice    
FROM AdventureWorks_Customers; 


--------------- Aggregation (Toplama , K�meleme , Birle�tirme) 4 ---------------

--    ** freight == Nakliye. **

SELECT AVG(AnnualIncome) AS AverageAnnualIncome 
FROM AdventureWorks_Customers;  


----    NOTE  :  �imdiye kadarki hesaplamalar�n tamam�nda hep TEK Sat�rl�k sonu�lar d�nd�rd�k... AMA bu hesaplamalar�
----    belli bir Filtreye g�re yapmak istiyorsak ; �ehirlere G�re , �r�nlere G�re , Zamana G�re , ... Bir �eye G�re ...
----    yapmak istiyorsak , 'GROUP BY' komutunu kullanmam�z gerekiyor... Yani bu hesaplamalar� Neye G�re yapmas�n�
----    istedi�imizi belirtmemiz gerekiyor...
----    Yani 'Aggregate' Fonksiyonlar kullan�rken , "Ba�ka Bir De�ere G�re" bir hesaplama yapmak istiyorsak , muhakkak
----    'GROUP BY' ile yazmam�z gerekiyor...


------------------------- GROUP BY -------------------------

SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

--------------- Aggregation (Toplama , K�meleme , Birle�tirme) 5 ---------------

ALTER TABLE AdventureWorks_Customers ALTER COLUMN CustomerKey INT

----    NOTE  :  Yukar�daki gibi �statistiki ve / veya Matematiksel hesaplamalar� belli bir F�LTREYE g�re yapmak
----    istiyorsak (�ehirlere g�re, �r�nlere g�re, m��teri ya��na g�re, Zamana g�re, ... vb...) ve ayn� zamanda hepsini
---- B�R ARADA g�rmek istiyorsak ; 'GROUP BY' Komutunu kullan�yoruz...

----    NOTE  :  'GROUP BY' Komutunu kullanmazsak bir hata al�yoruz... Bunun da sebebi SQL'in �ok da ak�ll�
----    olmamas�ndand�r... Program ; bu hesaplamalar� neye g�re yapaca��n� bilmiyor... Bu Aritmetik hesaplaman�n
----    d���ndaki (�evresindeki) alan�m�z� , 'GROUP BY' ile tan�mlamam�z gerekiyor...

----    NOTE  :  KOD Blo�unda yazd���m�z KA�INCI �fadeye g�re s�ralamak istiyorsak , onu da 'ORDER BY' Komutu ile
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

----    NOTE  :  Filtrelemelerde 'FROM''dan sonra WHERE komutunu yazarak mesela , �ehir Ankara'ya e�it ise �unu �unu
----    yap , De�ilse de �unu �unu yap gibi �eyler yazabiliyorduk... HESAPLAMALARDA bir Filtreleme yapmak istiyorsak da,
----    'HAVING' komutunu kullan�yoruz...

--    Mesela , E�itim Seviyelerine g�re Toplam ka� tane m��teri var g�rmek istiyoruz :
SELECT COUNT(*) AS CountOfEducationLevel , EducationLevel
FROM AdventureWorks_Customers
GROUP BY EducationLevel;

--    --    Mesela , E�itim Seviyelerine g�re , Toplamda 3000'den fazla m��teri olan E�itim Seviyelerini g�rmekistiyoruz :
SELECT COUNT(*) AS CountOfEducationLevel , EducationLevel
FROM AdventureWorks_Customers
group by EducationLevel
HAVING count(*) > 3000 


--------------- HAVING COUNT(*) > 3 ; ---------------

---------- Benzersiz (Unique) Say�m ----------
SELECT COUNT(DISTINCT CustomerKey) AS CountOfCustomerKey , EducationLevel    
FROM AdventureWorks_Customers    
GROUP BY EducationLevel;



------------------------- IF CLAUSE -------------------------

----    NOTE  :  Hat�rlarsak "IIF" fonksiyonunu TEK SATIRDA yazabiliyorduk... ��erisindeki ilk eleman ile ko�ulumuzu
----    belirtiyorduk. O ko�ul Do�ru ise �kinci elemanda , yap�lmas� gerekeni yaz�yorduk. O ko�ul Yaln�� ise de
----    ���nc� elemanda , yap�lmas� gerekeni yaz�yorduk...

--    �ncelikle , Bug�n g�nlerden ne? Ona bakal�m :
SELECT DATENAME(weekday, GETDATE())


--    A�a��da , E�ER bug�n g�nlerden 'Saturday' veya 'Sunday' �SE 'Weekend' d�nd�r ; DE��LSE 'Weekday' d�nd�r diyoruz...
SELECT IIF(DATENAME(weekday, GETDATE()) IN ('Saturday', 'Sunday') , 'Weekend' , 'Weekday') AS TODAY


----    NOTE  :  �zellikle Parametre olarak i�lem yapt���m�zda ; Birden Fazla Sat�r ve / veya Birden Fazla Ko�ul
----    belirtti�imiz zamanlarda  "IF  -  ELSE  -  ELSE IF"  komutlar�n� kullan�yoruz...

IF DATENAME(weekday, GETDATE()) IN ('Saturday', 'Sunday')
       SELECT 'Weekend' AS TODAY;
ELSE 
       SELECT 'Weekday'AS TODAY;



SELECT * FROM AdventureWorks_Customers;
SELECT * FROM AdventureWorks_Sales_2017;

------------------------- CASE - WHEN (DURUM - ZAMAN) �rne�i 1 -------------------------

--    ** odd == Tek say� , Acayip , Garip , Tuhaf. **
--    ** even == �ift say� , D�zg�n , P�r�zs�z , E�it , Bile. **

----    NOTE  :  �ok fazla Ko�ulumuz varsa da ; her defas�nda 'ELSE - IF' kullanmak yerine "CASE - WHEN" komutlar�n�
----    kullanabiliyoruz...

SELECT TerritoryKey ,
	CASE TerritoryKey % 2
	WHEN 0 THEN 'Even' ELSE 'Odd' END
FROM AdventureWorks_Sales_2017 ;


------------------------- CASE - WHEN (DURUM - ZAMAN) �rne�i 2 -------------------------

SELECT CustomerKey , ProductKey ,
	CASE
	WHEN ProductKey BETWEEN 0 AND 99 THEN 'Under 100'
	WHEN ProductKey BETWEEN 100 AND 199 THEN '100-199'
	WHEN ProductKey BETWEEN 200 AND 299 THEN '200-299'
	WHEN ProductKey BETWEEN 300 AND 399 THEN '300-399'
	WHEN ProductKey BETWEEN 400 AND 499 THEN '400-499'
	ELSE '500 and over' end AS range
FROM AdventureWorks_Sales_2017 ;


--   'AdventureWorks_Customers' Tablomuzun �LK 10 Sat�r�n� g�sterelim :
Select TOP 10 * FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
--   OR :
SELECT TOP 10 * FROM AdventureWorks_Customers


--   M��terilerimizi , Ya� Da��l�m�na g�re s�n�fland�ral�m :
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
--    NOTE  :  Yukar�da , 'GROUP BY' komutunu kullanmam�z�n sebebi , COUNT() i�lemi ger�ekle�tirmemizdir...



--    ** horoscope == Bur�. **

--    Bur� Bulma i�lemi yapabiliriz :

----    NOTE  :  Burada i� biraz de�i�iyor. ��nk� Bur� dedi�imiz �eylerin Tarih Aral�klar� sabit de�il... Bunun i�in
----    de 'CAST()' i�lemi yapmak gerekiyor... ��nk� , Tarih i�lemlerinde CAST() fonksiyonunu kullanabiliyoruz...
----    Ve ayr�ca bur� hesaplad���m�z i�in, 'Y�l�' bir kenara b�rak�p kullanmamak istiyoruz...
----    Asl�nda hepsinin Y�l�n� sabitlemeye �al��aca��z... Bunu da , '1900' y�l�na sabitleyerek yapal�m... ��nk�
----    bildi�imiz gibi Bur�lar�n sabit tarihleri var ama hep birbirlerinden farkl� aral�klardalar. Ve bundan dolay�
----    Y�l Ge�i�lerinde problemler ��kabilir... Bu y�zden Y�l� ekarte etmek i�in t�m do�um y�llar�n� mesela '1900'
----    y�l�na sabitleyece�iz...

----    NOTE  :  Tam �u An�n Tarihinden , 01/01/1900 Tarihini ��karmak istiyoruz... Matematiksel bir i�lem yapmak
----    istedi�imiz i�in 'DATEADD()' fonksiyonunu kullanaca��z :
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

----    NOTE  :  DATA �EKME k�sm� buraya kadard�...

----    NOTE  :  S�k s�k al��t�rmalar yapmam�z gerekiyor... Bunun i�in KAGGLE sitesini kullanabiliriz... Oradaki
----    Data Setlerine girip Filtreleyerek istedi�imiz bir Data Seti indirebiliriz... Ve bu Data Setin �zerinde
----    �al��abiliriz...

----    NOTE  :  Mesela 'CSV' dosyalar�n� 'SQL Server''de a�abilmek i�in bir �ok y�ntem vard�r... Bunlar� 'Youtube''de
----    aratarak da bulabiliriz... 'Youtube''ye; "CSV import SQL Server'" yaz�p aratabiliriz...
----    NOTE  :  'CSV' dosyalar�n� SQL Server'de a�abilmek i�in bir y�ntem ;
----    Mesela Soldaki 'AdventureWorks1' Veri Taban�na SA� T�klay�p , 'Tasks''a gelip , 'Import Flat Files''e t�klay�p ,
----    'CSV' dosyalar�n� y�kleyebiliriz... 'CSV''lerin i�erisindeki her bir Sat�ra , INSERT INTO komutunu
----    haz�rlayabiliriz...





------------------------- JOIN -------------------------

--------------- Inner Join (�� Birle�im)---------------

--   �imdiye kadar t�m hesaplamalar� da , filtrelemeleri de TEK B�R Tablo �zerinde yapt�k... Ama �li�kisel Veri
-- Tabanlar�nda veriyi tutma amac�m�z , Par�alara b�lmek ve bir yerde 'Primary Key''ler di�er yerde 'Foreign Key''ler
-- ile datalar� sonras�nda birle�tirmek �zerine bir mentalitemiz vard�... Buna da NORMAL�ZASYON y�ntemi deniyordu...

-- Veri Ambarlar�ndaki as�l ama� ise veriyi saklamak de�il de Analiz etmek oldu�u i�in , orada da tam tersi olarak
-- DENORMAL�ZE diye bir y�ntem vard�r...


SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

--   Mesela yukar�da , daha �nce b�l�nen iki tane Tablomuz vard�r... Bu iki Tabloyu birbirine ba�layarak bir Data Set
-- olu�turmak isteyebiliriz... Bu i�lemleri 'JOIN' metodu ile yap�yoruz... E�er sadece 'JOIN' yazarak i�lem yaparsak ,
-- sunucu DEFAULT olarak 'INNER JOIN' kullan�yor...

--   INNER JOIN  :  E�er iki Tablonun (K�menin) Sadece KES���M (ORTAK) KOLONLARINI getirmek istiyorsak kullan�r�z...

--   LEFT JOIN  :  E�er SOLDAK� K�menin (Tablonun) TAMAMINI Kapsas�n istiyorsak kullan�r�z...

--   RIGHT JOIN  :  E�er SA�DAK� K�menin (Tablonun) TAMAMINI Kapsas�n istiyorsak kullan�r�z...

--   CROSS JOIN  :  T�M K�meleri (Tablolar�) Kapsas�n istiyorsak kullan�r�z... Ama bu metod pek kullan�lmaz...


----    NOTE  :  'FROM' komutundan sonra yazd���m�z Tablo ismine K�sa Bir �sim vermek istersek , Sonras�nda 'AS'
----    komutunu kullanarak bunu yapabiliriz... Mesela A�a��da "AdventureWorks_Customers" Tablomuza k�saca 'C' ismini
----    veriyoruz...

----    NOTE  :  'FROM' komutundan sonraki yazd���m�z Tablo , LEFT Tablomuz oluyor...
----	NOTE  :  'JOIN' metodundan sonraki yazd���m�z Tablo da , RIGHT Tablomuz oluyor...

--   'ON'  Komutu  :  Mesela , INNER JOIN kullanarak iki Tablonun Kesi�im K�mesini almak istiyoruz... AMA bu i�lemi
-- NEYE G�RE (Hangi Kolon veya Kolonlara G�re) yapaca��m�z� belirlemek i�in de  'ON'  komutunu kullan�yoruz...

SELECT C.CustomerKey , BirthDate , FirstName , LastName
FROM AdventureWorks_Customers AS C
INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey ;

--   Yukar�da , "AdventureWorks_Customers" Tablomuzun 'CustomerKey' Kolonu ile , "AdventureWorks_Sales_2017"
-- Tablomuzun 'CustomerKey' Kolonunu ; INNER JOIN T�r�nde birbirlerine ba�lad�k... Yani sadece KES���M K�MELER�N� ald�k.

----    NOTE  :  Yukar�daki iki tabloda da Ayn� �sme sahip Kolonlar oldu�u i�in , Tablolardaki birle�tirmek istedi�imiz
-- Kolonlardan SADECE birini SELECT komutu i�erisinde yazabiliyoruz. Biz 'C.CustomerKey' Kolonunu yazd�k...
-- Di�er Kolonlar i�in b�yle bir �ey yapmamam�z�n sebebi , o kolonlar�n SADECE "AdventureWorks_Customers" Tablosunda
-- var olmas�d�r...


--   A�a��da , RIGHT JOIN metodu ile "AdventureWorks_Sales_2017" Tablosunun TAMAMINI getir diyoruz. Ve beraberinde
-- "AdventureWorks_Customers" Tablosunun Sadece KES��ENLER�N� g�rmek istiyoruz... Ve bu i�lemi yaparken 'CustomerKey'
-- Kolonlar�na g�re bir birle�tirme (Join) yapmak istiyoruz...
SELECT S.* , BirthDate , FirstName , LastName
FROM AdventureWorks_Customers AS C
RIGHT JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey ;


----    NOTE  :  Mesela bir �rnek vermek gerekirse ; Trendyol'un 10m kullan�c�s� 150m da sipari�i var. Bu 150m sipari�i
----    'COUNT Listing' ile sayd�rarak ; 10m kullan�c�dan 8m tanesinin sipari� vermi� oldu�unu g�r�r�z... 2m kullan�c�
----    hi� sipari� vermemi�... Bu t�m kullan�c�lar�n oldu�u Tablo ile sadece sipari� veren kullan�c�lar�n oldu�u Tabloyu
----    INNER JOIN yaparak kullan�c�lar� sayd�r�rsak bu bize 8m ki�iyi verir... E�er LEFT JOIN yaparak sipari�leri
----    sayd�r�rsak bu bize 10m ki�iyi verir ve aradaki 2m sipari� vermeyen kullan�n�n yan�nda da sipari� say�s� olarak
----    NULL de�er d�ner...


----    NOTE  :  �ok fazla tablo oldu�unda , istedi�imiz tabloyu bulmakta zorlan�yorsak Filtreleyerek bulabiliriz...
----    Bunun i�in de ; Veri Setimizin (AdventureWorks1) i�erisindeki  'Tables'  klas�r�ne Sa� t�klay�p , sonras�nda
----    'Filter''e  t�klay�p , sonras�nda da  'Filter Settings''e  t�klayabiliriz. A��lan pencerede de ne tarz bir
----    Filtreleme yapmak istiyorsak o 'Property''in 'Value' k�sm�na t�klay�p yazabiliriz...

--    ** property == �zellik **





--------------- ???  Multiple Inner Join (�oklu �� Birle�tirme)  ??? ---------------

-- Video 1.8 , 23.30 dakikadan itibaren... -->

-- Bunu ba�ka Veri Seti ile �al��..! �u an kulland���m�z Veri Seti ile olmad�... A�a��s� yanl��...

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

----    NOTE  :  E�er 'COUNT' gibi bir Fonksiyon kullan�yorsak, g�stermek istedi�imiz alanlara g�re 'GROUP BY'
----    kullanmam�z gerekir...

SELECT 
FirstName, COUNT(*) 
FROM [dbo].[DimCustomer] 
GROUP BY FirstName
HAVING COUNT(*) > 15




--------------- Left Join (Sol Y�nden Kat�l�m) ---------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

-- INNER JOIN ile yapal�m :
SELECT 
C.CustomerKey , C.LastName , S.OrderNumber , COUNT(DISTINCT(ProductKey)) AS Unique_ProductKey_Count
FROM AdventureWorks_Customers AS C
INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
GROUP BY C.CustomerKey , C.LastName , S.OrderNumber
HAVING COUNT(DISTINCT(ProductKey)) < 5

-- LEFT JOIN ile yapal�m :
SELECT 
C.CustomerKey , C.LastName , S.OrderNumber , COUNT(DISTINCT(ProductKey)) AS Unique_ProductKey_Count
FROM AdventureWorks_Customers AS C
LEFT JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
GROUP BY C.CustomerKey , C.LastName , S.OrderNumber
HAVING COUNT(DISTINCT(ProductKey)) < 5

----    NOTE  :  Yukar�da g�rd���m�z gibi , LEFT JOIN ile yapt���m�zda 'NULL' de�erler de d�nd�...



--------------- Cross Join (�apraz Birle�tirme) ---------------
SELECT C.CustomerKey , C.LastName , S.OrderNumber
FROM AdventureWorks_Customers AS C
CROSS JOIN AdventureWorks_Sales_2017 AS S;





SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

----    NOTE  :  Sorgular�m�z�n i�erisinde mutlak bir de�er vermek veya LIKE gibi komutlar� kullanmak yerine ,
----    ba�ka bir sorgumuzu da Filtre olarak kullanabiliriz... :

--------------- �zel Sorgu Sonucunun Filtrelenmesi 1 ---------------

-- A�a��da , Sadece 'sipari� veren' CustomerKey'leri g�rmek istiyoruz...
----    NOTE  :  INNER JOIN ile ayn� i�lemi yap�yor ama Yap�sal olarak Farkl� �al���yor...

SELECT CustomerKey , LastName
FROM AdventureWorks_Customers
WHERE CustomerKey IN
	(SELECT DISTINCT CustomerKey FROM AdventureWorks_Sales_2017);



--------------- �zel Sorgu Sonucunun Filtrelenmesi 2 ---------------

-- A�a��da , Sadece 'sipari� vermeyen' CustomerKey'leri g�rmek istiyoruz...

SELECT CustomerKey , LastName
FROM AdventureWorks_Customers
WHERE CustomerKey NOT IN (
	SELECT CustomerKey
	FROM AdventureWorks_Sales_2017
	WHERE CustomerKey IS NOT NULL ) ;



--------------- �ki Farkl� Veri Setinin Birle�tirilmesi ---------------

--    'UNION' Komutu  ::  �ki tabloyu , TEK bir tablo olarak g�stermek istiyorsak ; 'UNION' komutu ile bu iki tabloyu
-- birbirlerine ba�l�yoruz...
-- Yani ilk yaz�lan Kolon isminin alt�nda , her iki kolonu alt alta s�ral�yoruz...

SELECT DISTINCT OrderNumber
FROM AdventureWorks_Sales_2017
UNION ALL
SELECT EmailAddress
FROM AdventureWorks_Customers ;

----    NOTE  :  Burada rastgele bir birle�tirme i�lemi yapt�m ama mesela , genellikle baz� �irketlerde 'Person'
----    tablosu ile 'Customer' tablosu ayr� ayr� tablolarda olabiliyor... Bu iki tabloyu birle�tirmek i�in bu
----    'UNION' komutunu kullanabiliyoruz...





----    NOTE  :  �imdiye kadar hep FROM komutundan sonra bir Tablo ismi verdik ve Tabloyu okuttuk...
----		FROM i�erisinde ; bizim i�in �nemli olan bir Sorguyu , Tablo gibi de kullanabiliriz...
----		Yani b�t�n tablolar� tek tek okutmak yerine , bir Sorguyu Filtreleyerek elimizde bir Data Set olu�turup ,
----    bu Data Seti de tekrar Tablo gibi davrand�rtmak istiyorsak ; FROM komutundan sonra Parantez i�erisinde
----    Sorgumuzu yazmam�z gerekiyor... :

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

--------------- Derived Table (T�retilmi� Tablo) ---------------

-- Fiziksel bir Tablo de�il de , bir Sorguyu Tablo gibi davrand�rtma i�lemine Drived Table deniyor...

-- Derived Table de , g�nl�k hayatta s�kl�kla kullanaca��m�z i�lemlerden birisidir...

SELECT C.LastName , C.BirthDate , C.CustomerKey
FROM AdventureWorks_Customers AS C
INNER JOIN (
	SELECT OrderNumber , CustomerKey
	FROM AdventureWorks_Sales_2017 where CustomerKey>15000 
		   ) AS SLS
				ON C.CustomerKey = SLS.CustomerKey ;





----------------------------------------------------------------------------------------------------------------------





--------------- Custom Query (�zel Sorgu) ---------------
SELECT COUNT(*) AS CountOfOrders, FirstName,        
	MiddleName, LastName    
FROM Person.Person AS P    
INNER JOIN Sales.Customer AS C ON P.BusinessEntityID = C.PersonID    
INNER JOIN Sales.SalesOrderHeader        
	AS SOH ON C.CustomerID = SOH.CustomerID    
GROUP BY FirstName, MiddleName, LastName; 




--------------- H�cresel S�ralama 1 ---------------
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




--------------- H�cresel S�ralama 2 ---------------
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


--------------- De�i�ken Tan�mlama 1 ---------------
DECLARE @myInt INT = 10;    
PRINT @myInt;   

--------------- De�i�ken Tan�mlama 2 ---------------
DECLARE @myString VARCHAR(20) = 'This is a test';    
PRINT @myString;   


--------------- De�i�kenlere Sorgu Sonucundan De�er Atama ---------------
DECLARE @MaxID INT, @MinID INT;

    
SELECT @MaxID = MAX(SalesOrderID),        
	@MinID = MIN(SalesOrderID)    
FROM Sales.SalesOrderHeader; 

SELECT @MinID, @MaxID
   
PRINT CONCAT('Max: ', @MaxID);    
PRINT CONCAT('Min: ', @MinID); 

--    2018 y�l�nda ka� spor i�eri�i �retmi�im ?
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



------------------- FONKS�YONLAR -------------------

SELECT * FROM AdventureWorks_Customers ;
SELECT * FROM AdventureWorks_Sales_2017 ;

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile i�lem yapt���m�z i�in, Birebirlik bir
													-- de�er d�nd���n� biliyoruz.
		FROM AdventureWorks_Sales_2017  AS S



----	NOTE  :	 Haz�r "String" Fonksiyonlar� , Solda S�ras� ile :
----	Databases - Veri Setimiz(ITUmindset) - Programmability - Functions - System Functions - String Functions
----	i�erisindedir.

----	NOTE  :	 Bir Fonksiyon Yaratmak ��in de MSSQL ekran�nda Yukar�da S�ras� ile :
----	View - Template Browser - Function -


--    FUNCTION :: Bir veya birden fazla parametre al�p bize sonu� d�nen yap�lara FONKS�YON denir.

--    SCALAR - VALUED FUNCTION :: Bir veya birden fazla parametre al�p bize sadece B�R de�er d�nen yap�lara
-- SCALAR - VALUED FUNCTION denir.

--    INLINE TABLE - VALUED FUNCTUON ::  E�er Fonksiyonumuz 1'e N'lik , N'e 1'lik veya N'e N'lik bir TABLO sonucu
-- d�n�yorsa buna INLINE FUNCTION denir.

--    MULTI - STATEMENT TABLE - VALUED FUNCTION :: E�er bir sorgu sonucumuz yoksa , i�eride hesaplamalar yap�p
-- de�i�kenleri bir Tabloya at�p sanal bir Tablo ile d�nd�r�yorsa buna da MULTI - STATEMENT FUNCTION denir.

----    NOTE  :  Solda ; Databases - Veri Setimiz(AdventureWorks1) - Programmability - Functions -
----    Scalar-valued Functions'a gelip sa� t�klad���m�zda , 'New Scalar-valued Function' imlecini g�r�r�z. Buna
----    t�klad���m�zda bize yazmam�z gereken Template , yeni bir �al��ma sayfas�nda g�nderiliyor...

--    ** template == �ablon. **

----    NOTE  :  Fonksiyonlarda ; de�i�tirme , silme , g�ncelleme , ... gibi i�lemler yoktur. Fonksiyonlar�n tek amac�
----    var ; parametreyi ald�ktan sonra , datan�n hesaplan�p bir ��kt� vermesidir...

----    NOTE  :  De�i�tirme , Silme , G�ncelleme , ... gibi i�lemler i�in  'STORED PROCEDURE (Sakl� Yordam)'
----    kullanaca��z...

----    NOTE  :  Bir KOD blo�unu tamamen Comment (Yorum) blo�u haline getirmek i�in ; T�M blo�u se�ip ,
----    'CTRL + k + c' tu�lar�na basmak gerekiyor...


--    NOTE  :  Mesela bu yapt���m�z ad�mlar� nas�l takip edebiliriz ? Hangi ad�mda ne oldu�unu nas�l g�rebiliriz ?
--    Bunun i�in  "BREAK POINT"  koymam�z gerekiyor...



--    B�t�n i�lemlerimizi bitirip , Data Manip�lasyonumuzu da yap�p , Fonksiyonlar� ve Sakl� Yordamlar� da yaratt�ktan
-- sonra ; sorgumuzun bizden ba��ms�z olarak g�nl�k �al��mas�n� istiyoruz... Bunun i�in Solda EN ALTTAK�
-- 'SQL Server Agent''in  i�inde  "JOBS"  klas�r� vard�r... O "JOB"'lar� , tan�mlayarak �al��t�r�yoruz...
--    O "JOB"'lar , her gece �al��mas� gereken yap�lar� g�sterir... Oradan , �zelliklerini ve arka-planda nas�l
-- �al��t���n� g�rmek istedi�imiz bir "JOB"'a Sa� t�klay�p , sonras�nda da  'Properties'  butonuna t�klamal�y�z...
--    'Properties''e t�klad�ktan sonra kar��m�za o JOB'un �zellikleri ��k�yor. Oradan  "Steps"  butonuna t�klay�p ,
-- her bir Stepte nas�l i�lemler yap�ld���n� g�rebiliyoruz... Herhangi bir i�lemin ayr�nt�l� Kodlar�n� g�rmek i�in de,
-- o Stepe �ift T�kl�yoruz ve a��yoruz... A��lan sayfada , �al��an Sorgunun Kodlar�n� g�rebiliriz...
--    ��erisine girdi�imiz Stepin �leri �zelliklerini g�rmek i�in de ; bu sayfan�n i�erisinde soldaki  'Advanced'
-- butonuna t�kl�yoruz... 'Advanced''de ; e�er bu Step Ba�ar�l� ise , o Stepten sonra hangi Step'e ge�mesi gerekti�ini
-- se�ebiliyoruz... Ayn� �ekilde , Ba�ar�s�z ise de o Stepten sonra hangi Step'e ge�mesi gerekti�ini se�ebiliyoruz...
-- Ayr�ca Ba�ar�s�z olursa , Ba�ar�l� olmak i�in ;� hangi Interval'de Ka� Kez daha denemesi gerekti�ini de
-- se�ebiliyoruz... Son olarak 'Hata Dosyas�' olu�turacaksak da  "Output File:"  dosyas�n�n ad�n�n ne olaca��n� da
-- yazabiliyoruz...
--    Bunlar�n hepsini yaparak "JOB"'umuzun ad�mlar�n� belirleyebiliyoruz...
--    �imdi de Yine "JOB"'umuzun i�erisinde Solda  "Schedules"  butonuna t�kl�yoruz. Burada da "JOB"'umuzun Hangi
-- Periyotta �al��mas� gerekti�i talebini belirtiyoruz... Mesela her g�n saat ka�ta �al��mas� gerekti�ini
-- belirtiyoruz (Sabah saat 08.15 gibi...). Bunu belirttikten sonra da a�a��daki  'Edit'  butonuna t�kl�yoruz...
--    'Edit'  butonuna t�klad�ktan sonra da ;  'Schedule Type'  ,  'Frequency'  ,  'Daily frequency'  ve  'Duration'
-- triklerini belirtiyoruz... Ve sonras�nda da  'OK'  butonuna basarak �al��t�r�yoruz...

--    Bir defa ana kurguyu tasarlad�ktan sonra e�er bir Veri Taban�m�z varsa , mesela "SQL Server"'imiz varsa burada
-- bir  "SQL Server Agent"  i�inde  "JOB"  tan�ml�yoruz. Veya  'Open Source'  bir k�t�phane kullanacaksak da mesela
-- "APACHE Airflow" kullan�yoruz... Bu tip yerlerde  "Schedules"  i�lemlerimizi ger�ekle�tiriyoruz... Ondan sonra da
-- art�k Datalar�m�z temiz geliyor. Hatta Data Science Modelimizi kurup "Python Script"'leri de buraya ba�lad���m�zda,
-- sonu�lar� da alm�� oluyoruz ve art�k sonras�nda bir i�lem yapm�yoruz. Sadece monit�r�ze ediyoruz.



--------------- De�i�ken �zerinden 'IF' Kontrolu ---------------

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

--------------- D�ng� ---------------
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

--------------- Transaction (��lem , Hareket , Faaliyet) ---------------
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
  




--------------- Exception (�stisna , Ola�and���l�k , Ola�and��� durum) ---------------
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

--------------- Views (G�r�n�mler) ---------------
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

--------------- Scalar (Skaler , Y�ns�z , Say�sal) Functions 1 ---------------
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


--------------- Scalar (Skaler , Y�ns�z , Say�sal) Functions 2 ---------------
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

--------------- Scalar (Skaler , Y�ns�z , Say�sal) Functions 3 ---------------
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

--------------- Scalar (Skaler , Y�ns�z , Say�sal) Functions 4 ---------------
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

--------------- Stored Procedures (Sakl� Yordamlar - Prosed�rler) ---------------
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


--------------- Stored Procedures (Sakl� Yordamlar - Prosed�rler) ---------------
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

--    ** explicitly == A��k�a , A��k bir �ekilde. **

SELECT *
FROM OPENJSON(@json, '$.info')
WITH ( type int,
       town nvarchar(50) '$.address.town',
       country nvarchar(50) '$.address.country'
     )
GO