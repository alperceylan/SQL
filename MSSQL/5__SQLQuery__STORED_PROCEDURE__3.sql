
--    Þu anda içinde bulunduðumuz Stored Procedure sayfasýný açmak için de ; Soldaki  'Programmability'  içerisindeki
-- 'Stored Procedures'  klasörünü REFRESH ettikten sonra , oluþturduðumuz "Stored Procedure"'yi görüyoruz... Üzerine
-- gelip Sað týklayýp ,  'Script Stored Procedure as'  butonuna týklayýp sonrasýnda ,  'EXECUTE To'  butonuna
-- týklýyoruz ve sonrasýnda da  'New Query Editor Window'  butonuna týklýyoruz... Ve þu anda içinde bulunduðumuz
-- sayfa açýlýyor...

--    Daha önce yaratýlmýþ olan STORED PROCEDURE sayesinde , oradaki iþlemleri burada direkt olarak kolayca
-- uygulayabiliyoruz... Aþaðýdaki  "EXECUTE"  kýsmýna direkt "Stored Procedure"'nin ismini ve sonrasýnda da hangi
-- kullanýcý (CustomerKey) ile ilgili iþlem yapmak istediðimizi yazýyoruz ve çalýþtýrýyoruz... ::

USE [AdventureWorks1]
GO

DECLARE @CustomerKey varchar(50)

-- TODO : Set parameter values here.

EXECUTE [dbo].[sp_ITU_VIII_Get_Anonymzed_1] 11079

GO


--    Üzerinde deðiþiklik yaptýðýmýz kullanýcýyý görelim :

SELECT TOP 10 * FROM AdventureWorks_Customers WHERE [CustomerKey] = 11079



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