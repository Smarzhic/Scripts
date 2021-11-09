# Время создания и изменения всех групповых политик
get-gpo -all | Sort CreationTime,Modificationtime | Select Displayname,*Time

# Все объекты групповых политик, измененные за последние 30 дней
get-gpo -all | Where {$_.ModificationTime -ge (Get-Date).AddDays(-30)}

# Отчет по отдельному объекту групповых политик (Defaul Domain Policy), необходимо создать каталог C:\work
Get-GPOReport -name "Default Domain Policy" -ReportType HTML -Path "c:\work\ddp.htm"
invoke-item "c:\work\ddp.htm"

# Отчеты по всем объектам групповых политик. необходимо создать каталог C:\work
Get-GPOReport -All -ReportType HTML -Path "c:\work\allgpo.htm"
invoke-item "c:\work\allgpo.htm"
