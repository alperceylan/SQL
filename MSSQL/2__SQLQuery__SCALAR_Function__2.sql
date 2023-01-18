
--    Bu fonksiyonu �al��t�rmak i�in ; soldaki "Scalar-valued Functions" klas�r�nde fonksiyonumuzu bulup - Sa�
-- t�klay�p -  "Script Function as"'a  t�klay�p -  "SELECT to"'ya  t�klay�p -  "New Query Editor Window"'a
-- t�klayabiliriz... Ve yeni bir �al��ma penceresinde fonksiyonumuz a��l�r... Yani �u an i�inde bulundu�umuz sayfa
-- a��l�r...



USE [AdventureWorks1]
GO

SELECT [dbo].[fx_ITU_VIII_Scalar_1] (13516)
GO





--    Art�k hi� 'JOIN' metodunu kullanmadan devam edebiliriz... :
--    Fonksiyon kurulduktan sonra , sadece a�a��daki kodu �al��t�rarak , hangi m��terinin ka� sipari� verdi�ini
-- ��renebiliyoruz... �stersek ilave kolonlar da g�rebiliyoruz...

SELECT C.[CustomerKey] , C.[BirthDate] , [dbo].[fx_ITU_VIII_Scalar_1] (C.[CustomerKey]) as ProductCount
FROM AdventureWorks_Customers AS C

----    NOTE  :  Yukar�daki "SELECT"'de , '[dbo].[fx_ITU_VIII_Scalar_1]' yazd�ktan sonra parantez i�inde , tekrar
----    (C.[CustomerKey]) yazmam�z�n sebebi ; fonksiyonun 'CustomerKey' kolonuna g�re �al��mas�n� istememizdendir... 

----    NOTE  :  Bu bir fonksiyon olarak solda durdu�u i�in , ba�ka �al��anlarla ortak eri�imimiz olsayd� ,
----    ba�kalar� da kullanabileceklerdi...