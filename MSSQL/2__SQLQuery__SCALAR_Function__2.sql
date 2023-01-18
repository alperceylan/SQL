
--    Bu fonksiyonu çalýþtýrmak için ; soldaki "Scalar-valued Functions" klasöründe fonksiyonumuzu bulup - Sað
-- týklayýp -  "Script Function as"'a  týklayýp -  "SELECT to"'ya  týklayýp -  "New Query Editor Window"'a
-- týklayabiliriz... Ve yeni bir çalýþma penceresinde fonksiyonumuz açýlýr... Yani þu an içinde bulunduðumuz sayfa
-- açýlýr...



USE [AdventureWorks1]
GO

SELECT [dbo].[fx_ITU_VIII_Scalar_1] (13516)
GO





--    Artýk hiç 'JOIN' metodunu kullanmadan devam edebiliriz... :
--    Fonksiyon kurulduktan sonra , sadece aþaðýdaki kodu çalýþtýrarak , hangi müþterinin kaç sipariþ verdiðini
-- öðrenebiliyoruz... Ýstersek ilave kolonlar da görebiliyoruz...

SELECT C.[CustomerKey] , C.[BirthDate] , [dbo].[fx_ITU_VIII_Scalar_1] (C.[CustomerKey]) as ProductCount
FROM AdventureWorks_Customers AS C

----    NOTE  :  Yukarýdaki "SELECT"'de , '[dbo].[fx_ITU_VIII_Scalar_1]' yazdýktan sonra parantez içinde , tekrar
----    (C.[CustomerKey]) yazmamýzýn sebebi ; fonksiyonun 'CustomerKey' kolonuna göre çalýþmasýný istememizdendir... 

----    NOTE  :  Bu bir fonksiyon olarak solda durduðu için , baþka çalýþanlarla ortak eriþimimiz olsaydý ,
----    baþkalarý da kullanabileceklerdi...