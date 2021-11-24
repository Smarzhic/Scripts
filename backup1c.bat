REM /////////////////////////////////////////////////////////////////////////////////
REM пегепбхпбнбюмхе оепбни аюгш sibek
REM опхлеп янгдюмхъ пегепбмни йнохх аюгш дюммшу 1C мю POSTGRESQL
CLS
ECHO OFF
CHCP 1251

REM сйюгюмхе оепелеммшу япедш POSTGRESQL 
SET PGBIN=C:\Program Files\PostgreSQL 1C\14\bin
SET PGDATABASE=хлъ аюгш
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=хлъ онкэгнбюрекъ POSTRES
SET PGPASSWORD=оюпнкэ онкэгнбюрекъ POSTGRES

REM оепеунд б йюрюкнц я bat-тюикнл (нрйсдю гюосыем тюик)
%~d0
CD %~dp0

REM тнплхпнбюмхе хлемх тюикю дкъ пегепбмни йнохх х LOG тюикю нрверю
SET DAT=%date:~0,2%%date:~3,2%%date:~6,4%
SET DUMPFILE=осрэ й дюлос х хлъ тюикю.backup
SET LOGFILE=осрэ й кнцс х хлъ тюикю.log
SET DUMPPATH="%DUMPFILE%"
SET LOGPATH="%LOGFILE%"

REM бшонкмемхе йнлюмдш (опнцпюллш) дкъ янгдюмхе пегепбмни йнохх аюгш 
CALL "%PGBIN%\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%

REM бшонкмемхе йнлюмдш (опнцпюллш) гюбепьемн, еякх ньханй мер рн йнмеж
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull
REM опх бнгмхймнбемхх ньханй сдюкъеряъ онбпефдеммши тюик йнохх х яннрберярбсчыюъ гюохяэ б фспмюке н ее янгдюмхх
:Error
DEL %DUMPPATH%
MSG * "нЬХАЙЮ ОПХ ЯНГДЮМХХ ПЕГЕПБМНИ ЙНОХХ АЮГШ ДЮММШУ. яЛНРПХРЕ backup_sibek.log."
ECHO %DATETIME% нЬХАЙХ ОПХ ЯНГДЮМХХ ПЕГЕПБМНИ ЙНОХХ АЮГШ ДЮММШУ %DUMPFILE%. яЛНРПХРЕ НРВЕР %LOGFILE%. >> backup_sibek.log
GOTO End

REM еякх йнохъ ядекюмю аег ньханй декюеряъ гюохяэ б фспмюке пецхярпюжхх
:Successfull
ECHO %DATETIME% сЯОЕЬМНЕ ЯНГДЮМХЕ ПЕГЕПБМНИ ЙНОХХ %DUMPFILE% >> backup_sibek.log
GOTO End
:End

REM сярюмюбкхбюеряъ оюпюлерпш дкъ йнохх упюмхрэ 5 дмеи нр дюрш янгдюмхъ, сдюкърэ он хяревемхч
FORFILES /p "D:\1C BackUp\" /s /m *.* /d -5 /c "CMD /c del /Q @FILE" 
