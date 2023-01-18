
--    �u anda i�inde bulundu�umuz Stored Procedure sayfas�n� a�mak i�in de ; Soldaki  'Programmability'  i�erisindeki
-- 'Stored Procedures'  klas�r�n� REFRESH ettikten sonra , olu�turdu�umuz "Stored Procedure"'yi g�r�yoruz... �zerine
-- gelip Sa� t�klay�p ,  'Script Stored Procedure as'  butonuna t�klay�p sonras�nda ,  'EXECUTE To'  butonuna
-- t�kl�yoruz ve sonras�nda da  'New Query Editor Window'  butonuna t�kl�yoruz... Ve �u anda i�inde bulundu�umuz
-- sayfa a��l�yor...

--    Daha �nce yarat�lm�� olan STORED PROCEDURE sayesinde , oradaki i�lemleri burada direkt olarak kolayca
-- uygulayabiliyoruz... A�a��daki  "EXECUTE"  k�sm�na direkt "Stored Procedure"'nin ismini ve sonras�nda da hangi
-- kullan�c� (CustomerKey) ile ilgili i�lem yapmak istedi�imizi yaz�yoruz ve �al��t�r�yoruz... ::

USE [AdventureWorks1]
GO

DECLARE @CustomerKey varchar(50)

-- TODO : Set parameter values here.

EXECUTE [dbo].[sp_ITU_VIII_Get_Anonymzed_1] 11079

GO


--    �zerinde de�i�iklik yapt���m�z kullan�c�y� g�relim :

SELECT TOP 10 * FROM AdventureWorks_Customers WHERE [CustomerKey] = 11079



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