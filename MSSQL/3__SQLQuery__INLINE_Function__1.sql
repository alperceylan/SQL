
--    Hangi m��terinin ka� sipari� verdi�ini bulabilece�imiz bir fonksiyon yazal�m :::::::

----    NOTE  :  Burada kulland���m�z INLINE FUNCTION ; 1'e N'lik , N'e 1'lik veya N'e N'lik bir 'TABLO' sonucu d�ner.

CREATE FUNCTION fx_ITU_VIII_Inline_1      --   <--- Fonksiyonun ismi.
(	
	--    Parametre olarak (Input olarak) bu fonksiyon ne alacak? Ve Tipi ne olacak? ::
	@CustomerKey varchar(50)

)

--    A�a��da g�rd���m�z gibi RETURNS , otomatik olarak direkt 'TABLE' olarak d�n�yor... ��nk� INLINE FUNCTION ,
-- TABLO olu�turmak i�in kullan�l�r... :
RETURNS TABLE 
AS
RETURN 
(
	--    Add the SELECT statement with parameter references here :
	--    Buraya da , ayn� �ekilde t�m SELECT'imizi yap��t�r�yoruz... :

		SELECT
			COUNT(S.[ProductKey]) AS ProductCount   --   Burada, COUNT ile i�lem yapt���m�z i�in, Bire birlik bir
													-- de�er d�nd���n� biliyoruz.
		FROM AdventureWorks_Customers AS C
				INNER JOIN AdventureWorks_Sales_2017 AS S  ON C.CustomerKey = S.CustomerKey
		WHERE C.[CustomerKey] = @CustomerKey
		GROUP BY C.[CustomerKey]

		--   Biz buraya , SCALAR Function'da yapt���m�z SELECT'in ayn�s�n� yap��t�rd�k... Ama daha komplike KODLAR
		-- da yap��t�rabilirdik ve asl�nda �yle de yapmal�y�z...

)
GO

----    NOTE  :  Bu fonksiyonu �al��t�rmak istiyorsak ; Soldaki "Table-valued Functions" klas�r�nde fonksiyonumuzu
----    bulup - Sa� t�klay�p - "Script Function as"'a t�klay�p - "SELECT to"'ya t�klay�p - "New Query Editor Window"'a
----    t�klayabiliriz... Ve yeni bir �al��ma penceresinde fonksiyonumuz a��l�r...