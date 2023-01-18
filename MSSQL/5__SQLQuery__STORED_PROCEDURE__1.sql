
--          STORED PROCEDURE (SAKLI YORDAM)

--    C++  ve  C#  programlar�ndaki  'VOID'  kavram�na benzer bir yap�d�r.

--    Sakl� yordamlar belli bir i�levi yerine getirmek i�in kullan�lan kod par�ac�klar�d�r.

--    Veritaban�nda CRUD gibi i�lemlerde, her seferinde kodu tekrar yazmam�z ve derlememiz gerekmektedir. Durum b�yle
-- olunca hem zaman hem de derleme a��s�ndan perormans kayb� olmaktad�r.
-- Bu gibi durumlarda Sakl� Yordam (Store Procedure), programlamada kullan�lan ifadelere g�re kod yazmam�z� sa�lar.
-- B�ylece her seferinde ayn� i�lemleri yapma gereksinimi duymadan zamandan tasarruf etmi� oluruz. �rnek verecek
-- olursak, veritaban�nda belli tarihler aral���nda m��teriye ait sipari�leri listemelek istedi�imiz, SELECT SQL
-- kodunu yazmak yerine sadece tarih aral��� ve m��teri numaras� verilerek listeme ger�ekle�tirilmesi �rnek olarak
-- verilebilir.

--    Sakl� Yordam, giri� (input) parametreleri alarak, �a�r�ld���nda ��kt� (output) de�eri d�nd�r�r.
--    Veritaban�nda i�lemler ger�ekle�tirebilece�imiz BEGIN�END, IF ELSE, WHILE, LOOP, REPEAT, BREAK, CONTINUE, CASE
-- gibi ifadeler ile kullan�labilir.
--    Bir defa derledikten sonra, tekrar derlemeye gerek kalmaz. Veritaban�nda derlenmi� bir execution plan halinde
-- saklan�r.
--    Hata kontrol� yapmak i�in TRY-CATCH yap�s� ile birlikte kullan�labilir.
--    'User-defined (UDF)' fonksiyonlara benzer. Ancak temel fark, 'UDF'�ler di�er SQL ifadeleri ile �a�r�l�rken,
-- Sakl� Yordamlar 'CALL' ifadesi kullan�larak �a�r�l�r.


--          Nerelerde Kullan�l�r ?
--    Tekrar kullan�labilirli�i sa�lamak istedi�imizde kullan�l�r. Mod�lerlik sa�layarak, bir defa olu�turulan
-- fonksiyonnu istedi�imiz kadar �a��rabiliriz.
--    Daha h�zl� y�r�tme (execution) istedi�imizde kullan�l�r. ��nk� kod ilk �al��t�r�ld���nda derlenir, daha sonra
-- sadece haf�zada saklanan execution plan halini kullanarak, tekrar derlenme ve optimizeye ihtiya� duymamaktad�r.
--    A� trafi�ini azaltmak istedi�imizde kullan�l�r. Sakl� Yordam SQL ifadelerini a� ortam�na �oklu g�ndermek yerine,
-- toplu olarak �al��t�rabilir. B�ylece trafi�i azalt�p performans art�l�r.
--    Daha iyi veri g�venli�i sa�lar. Kullan�c�lar�n sakl� yordam ifadelerini do�rudan �al��t�rma izni olmadan, Sakl�
-- Yordam�da izin verilerek g�venlik sa�lan�r.


--          Yeni Bir Stored Procedure Olu�turma (CREATE PROCEDURE)
-- (1)
--    Yeni bir Sakl� Yordam olu�turmak istedi�imizde ,  "CREATE PROCEDURE"  komutu ve sonras�nda Yordam ismi yaz�l�r ,
-- sonras�nda ;  "@"  i�areti ile , kullan�lacak parametreler tan�mlan�r. Sakl� Yordam ismi ve parametreler
-- tan�mland�ktan sonra ,  "AS"  ifadesiyle devam edilip  "BEGIN"  ve  "END"  ifadeleri aras�nda Sakl� Yordam'da
-- yap�lmak istenen sorgu yaz�l�r.

-- (2)
--    "Stored Procedure" olu�turmak i�in ba�ka bir y�ntem daha vard�r. Solda , �ncelikle �zerinde �al��mak istedi�imiz
-- Data Sete geliyoruz. Orada  'Programmability'  klas�r�ne t�kl�yoruz. Sonras�nda da  'Stored Procedures'  klas�r�ne
-- Sa� t�klayarak  'New'  butonundan sonra ortaya ��kan  'Stored Procedure'  butonuna t�kl�yoruz...
-- Bu butonlara t�klad���m�zda , Haz�r 'Stored Procedure' Tasla�� i�in yeni bir �al��ma sayfas� olu�acakt�r...



--          Sakl� Yordam �al��t�rma (EXECUTE Store Procedure)
--    Olu�turdu�umuz Sakl� Yordam� �al��t�rmak istedi�imizde  "EXEC"  komutunu kullan�r�z.


--          Sakl� Yordam G�ncelleme (ALTER Store Procedure)
--    Daha �nce olu�turdu�umuz Sakl� Yordam �zerinde de�i�iklik yapmak istedi�imizde ,  "ALTER"  ifadesi kullan�l�r.
-- "ALTER PROCEDURE"  ifadesinden sonra g�ncellemek istedi�imiz Sakl� Yordam ismi ve g�ncelleme sorgusu yaz�l�r.


--          Sakl� Yordam Silme (DROP Store Procedure)
--    Kullan�lmayan Sakl� Yordam yap�s�n�n silinmesi istendi�inde ,  "DROP"  ifadesi kullan�ll�r. "DROP PROCEDURE"
-- ifadesinden sonra droplamak istenilen Sakl� Yordam�n ismi yaz�l�r. Sorgu �al��t�r�ld���nda yordam�n silinmesi
-- ger�ekle�ir.


--          ENCRYPTED Sakl� Yordam (ENCRYPTED Store Procedure)
--    Sakl� Yordam�n d�zenlenebilirli�ini kapatmak i�in �ifreleme i�lemi uygulan�r. �ifrelenen Sakl� Yordam �zerinde
-- art�k kendimiz dahi de�i�iklik yapamay�z. Bu nedenle , �ifreli Sakl� Sordam olu�tururken kodlar�n�n da yede�ini
-- bir yerde saklamam�z ileride de�i�iklik yapmak istedi�imizde gerekli olabilir. �ifreli Sakl� Yordam , Normal Sakl�
-- Yordam olu�turur gibi ancak ilaveten , parametrelerden sonra  "WITH ENCRYPTION"  ifadesi eklenerek olu�turulur.


--          RECOMPILE Sakl� Yordam (RECOMILE Store Procedure)
--    Olu�turulan Sakl� Yordamlar genelde  'Plan Cache'�de  saklan�r. Ancak ,  "RECOMPILE"  ifadesiyle olu�turulan
-- Sakl� Yordamlar  'Plan Cache'�de  saklanmaz , her �al��t�r�ld���nda yeniden olu�turulur. Al�nan parametrelere g�re
-- de�i�ik  'Query Plan'�lar  olu�turuluyorsa , bu t�r Sakl� Yordam kullan�labilir. B�ylece her �al��t�r�ld���nda
-- yeniden  'Query Plan'  olu�turulur. "RECOMPILE Sakl� Yordam" , Normal Sakl� Yordam olu�turur gibi ancak ilaveten ,
-- parametrelerden sonra  "WITH RECOMPILE"  ifadesi eklenerek olu�turulur.



--          -�RNEK-
--    Mesela bir kullan�c� kayd�n� sildirdi ve biz de o kullan�c�n�n ki�isel bilgilerini silip anonim hale getirmek
-- istiyoruz. Bunun i�in ne yapmal�y�z ?
--    Mesela "11076" Customer Key'li kullan�c� kayd�n� sildirdi. �nce bu kullan�c�y� g�relim , daha sonra da
-- anonimle�tirme i�lemini ger�ekle�tirelim... ::


DECLARE @CustomerKey VARCHAR(50) = 11076
SELECT [CustomerKey]
      ,[Prefix]
      ,[FirstName]
      ,[LastName]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[EmailAddress]
      ,[AnnualIncome]
      ,[TotalChildren]
      ,[EducationLevel]
      ,[Occupation]
      ,[HomeOwner]
FROM [AdventureWorks1].[dbo].[AdventureWorks_Customers]
WHERE [CustomerKey] = @CustomerKey


--    ** unknown == Bilinmez , Bilinmeyen , Bilinmiyor , Tan�nm�yor. **


--    Anonimle�tirme G�ncellemesi ::

DECLARE @CustomerKey VARCHAR(50) = 11076
UPDATE [AdventureWorks1].[dbo].[AdventureWorks_Customers]
SET [FirstName] = 'Unknown'  ,  [LastName] = 'Unknown'  ,  [EmailAddress] = 'Unknown'  ,  [BirthDate] = GETDATE()
WHERE [CustomerKey] = @CustomerKey


--    G�ncelle�tirme Notlar� ::

----    NOTE  :  UPDATE (G�NCELLEME) yaparken 10 defa d���n�n 1 defa yap�n !  Geriye d�n�� �ok zor !
----    NOTE  :  "UPDATE" komutundan sonra , g�ncelleme yapmak istedi�imiz Tablonun ismini yaz�yoruz.
----    NOTE  :  "SET" komutundan sonra , hangi de�er g�ncellenecekse o de�er veya de�erleri yaz�yoruz.
----    NOTE  :  "WHERE" komutundan sonra , neye g�re g�ncelleme yapaca��m�z� yaz�yoruz.


--    Ayr�ca HAZIR G�ncelleme Kodlar�na da ula�abiliriz... Bunun i�in ; Soldaki , G�ncelleme yapmak istedi�imiz
-- Tabloya Sa� t�kl�yoruz (Mesela , 'AdventureWorks_Customers' tablosu). Sonras�nda "Script Table as"  butonuna
-- t�kl�yoruz. Oradan da hangi i�lemi ger�ekle�tirmek istiyorsak ona t�kl�yoruz , biz G�ncelleme istedi�imiz i�in
-- "UPDATE To"  butonuna t�klayaca��z. En son da  "New Quary Editor Window" butonuna t�klayarak , G�ncelleme
-- yapaca��m�z Tablo i�in haz�r G�ncelleme Kodlar�na ula�m�� oluyoruz...

--    Ula�t���m�z Haz�r G�ncelleme Kod Tasla��n� kopyalay�p buraya yap��t�raca��z... Gereksiz olan kolon isimlerini de
-- direkt silece�iz... "DECLARE" komutu ekleyece�iz... "WHERE" komutunu da d�zenleyece�iz... ::

DECLARE @CustomerKey VARCHAR(50) = 11075

UPDATE [dbo].[AdventureWorks_Customers]
   SET
       [Prefix] = 'Unknown'
      ,[FirstName] = 'Unknown'
      ,[LastName] = 'Unknown'
      ,[BirthDate] = GETDATE()
      ,[EmailAddress] = 'Unknown'
 WHERE [CustomerKey] = @CustomerKey


----    NOTE  :  Mesela baz� Tablolarda ; Telefon Numaras� , Kimlik Numaras� , ... gibi bilgi 'kolonlar�' vard�r. B�yle
----    bilgilerin tutuldu�u Tablolar da muhakkak ba�ka tablolara Ba��ml�d�rlar... B�yle bilgilerin tutuldu�u
----    "Kolonlar" da ; Sol tarafta , ilgili Tablonun i�indeki 'Columns' klas�r�n�n i�erisinde ,  "Anahtar Kilidi"
----    emojisi ile g�sterilir...

----    NOTE  :  Ba��ml�l�klar� g�rmek i�in de ; bakmak istedi�imiz Tabloya Sa� t�klayarak , 'View Dependencies'
----    butonuna t�klar�z. Buna t�klad���m�zda ; bir Tablodaki 'Kolonun' , ba�ka hangi Tablo veya Tablolar ile ba��ml�
----    oldu�unu g�r�r�z...

----    NOTE  :  Bu Ba��ml� olan Kolonlarda anonimle�tirme i�lemi yapmak i�in farkl� bir i�lem yapmam�za gerek yoktur.
----    Yine yukar�da yapt���m�z i�lemlere benzer �ekilde �al��abiliriz...