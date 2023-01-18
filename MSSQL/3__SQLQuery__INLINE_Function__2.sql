
--    Bu fonksiyonu �al��t�rmak i�in ; Soldaki  "Table-valued Functions"  klas�r�nde fonksiyonumuzu bulup - Sa�
-- t�klay�p -  "Script Function as"'a  t�klay�p -  "SELECT to"'ya  t�klay�p -  "New Query Editor Window"'a
-- t�klayabiliriz... Ve yeni bir �al��ma penceresinde fonksiyonumuz a��l�r... Yani �u an i�inde bulundu�umuz sayfa
-- a��l�r...


USE [AdventureWorks1]
GO

SELECT * FROM [dbo].[fx_ITU_VIII_Inline_1] (13516)
GO

----    NOTE  :  Yukar�da , SCALAR Function'dan farkl� olarak , SELECT'den sonra  "* FROM"  da yazmam�z gerekti...





----    NOTE  :  SCALAR Function'larda , fonksiyon kurulduktan sonra JOIN kullanmadan kolay bir KOD sat�r� ile devam
----    edebiliyorduk... Ama INLINE Function'larda "TABLO" d�nmek istedi�imiz i�in ; INNER JOIN'deki Gibi bir Ba�lant�
----    yapmam�z gerekiyor... Yani "CROSS APPLY" komutunu kullanmam�z gerekiyor... ::

SELECT C.[CustomerKey] , EmailAddress , Fx.*
FROM AdventureWorks_Customers AS C
CROSS APPLY [dbo].[fx_ITU_VIII_Inline_1] (C.[CustomerKey]) as Fx

--    Hatta , Ka��nc� Kolona g�re bir S�ralama yapmak istiyorsak onu da belirleyebiliriz ::

--ORDER BY  5 DESC
-- OR
--ORDER BY  Fx.[Revenue] DESC