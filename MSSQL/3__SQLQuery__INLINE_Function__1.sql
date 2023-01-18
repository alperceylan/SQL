
--    Hangi müþterinin kaç sipariþ verdiðini bulabileceðimiz bir fonksiyon yazalým :::::::

----    NOTE  :  Burada kullandýðýmýz INLINE FUNCTION ; 1'e N'lik , N'e 1'lik veya N'e N'lik bir 'TABLO' sonucu döner.

CREATE FUNCTION fx_ITU_VIII_Inline_1      --   <--- Fonksiyonun ismi.
(	
	--    Parametre olarak (Input olarak) bu fonksiyon ne alacak? Ve Tipi ne olacak? ::
	@CustomerKey varchar(50)

)

--    Aþaðýda gördüðümüz gibi RETURNS , otomatik olarak direkt 'TABLE' olarak dönüyor... Çünkü INLINE FUNCTION ,
-- TABLO oluþturmak için kullanýlýr... :
RETURNS TABLE 
AS
RETURN 
(
	--    Add the SELECT statement with parameter references here :
	--    Buraya da , ayný þekilde tüm SELECT'imizi yapýþtýrýyoruz... :

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile iþlem yaptýðýmýz için, Bire birlik bir
													-- deðer döndüðünü biliyoruz.
		FROM AdventureWorks_Customers AS C
				INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
		WHERE C.[CustomerKey] = @CustomerKey
		GROUP BY C.[CustomerKey]

		--   Biz buraya , SCALAR Function'da yaptýðýmýz SELECT'in aynýsýný yapýþtýrdýk... Ama daha komplike KODLAR
		-- da yapýþtýrabilirdik ve aslýnda öyle de yapmalýyýz...

)
GO

----    NOTE  :  Bu fonksiyonu çalýþtýrmak istiyorsak ; Soldaki "Table-valued Functions" klasöründe fonksiyonumuzu
----    bulup - Sað týklayýp - "Script Function as"'a týklayýp - "SELECT to"'ya týklayýp - "New Query Editor Window"'a
----    týklayabiliriz... Ve yeni bir çalýþma penceresinde fonksiyonumuz açýlýr...