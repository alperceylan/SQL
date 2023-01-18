
--    Bu fonksiyonu çalýþtýrmak için ; Soldaki  "Table-valued Functions"  klasöründe fonksiyonumuzu bulup - Sað
-- týklayýp -  "Script Function as"'a  týklayýp -  "SELECT to"'ya  týklayýp -  "New Query Editor Window"'a
-- týklayabiliriz... Ve yeni bir çalýþma penceresinde fonksiyonumuz açýlýr... Yani þu an içinde bulunduðumuz sayfa
-- açýlýr...


USE [AdventureWorks1]
GO

SELECT * FROM [dbo].[fx_ITU_VIII_Inline_1] (13516)
GO

----    NOTE  :  Yukarýda , SCALAR Function'dan farklý olarak , SELECT'den sonra  "* FROM"  da yazmamýz gerekti...





----    NOTE  :  SCALAR Function'larda , fonksiyon kurulduktan sonra JOIN kullanmadan kolay bir KOD satýrý ile devam
----    edebiliyorduk... Ama INLINE Function'larda "TABLO" dönmek istediðimiz için ; INNER JOIN'deki Gibi bir Baðlantý
----    yapmamýz gerekiyor... Yani "CROSS APPLY" komutunu kullanmamýz gerekiyor... ::

SELECT C.[CustomerKey] , EmailAddress , Fx.*
FROM AdventureWorks_Customers AS C
CROSS APPLY [dbo].[fx_ITU_VIII_Inline_1] (C.[CustomerKey]) as Fx

--    Hatta , Kaçýncý Kolona göre bir Sýralama yapmak istiyorsak onu da belirleyebiliriz ::

--ORDER BY  5 DESC
-- OR
--ORDER BY  Fx.[Revenue] DESC