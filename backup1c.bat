REM /////////////////////////////////////////////////////////////////////////////////
REM ��������������� ������ ���� sibek
REM ������ �������� ��������� ����� ���� ������ 1C �� POSTGRESQL
CLS
ECHO OFF
CHCP 1251

REM �������� ���������� ����� POSTGRESQL 
SET PGBIN=C:\Program Files\PostgreSQL 1C\14\bin
SET PGDATABASE=��� ����
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=��� ������������ POSTRES
SET PGPASSWORD=������ ������������ POSTGRES

REM ������� � ������� � bat-������ (������ ������� ����)
%~d0
CD %~dp0

REM ������������ ����� ����� ��� ��������� ����� � LOG ����� ������
SET DAT=%date:~0,2%%date:~3,2%%date:~6,4%
SET DUMPFILE=���� � ����� � ��� �����.backup
SET LOGFILE=���� � ���� � ��� �����.log
SET DUMPPATH="%DUMPFILE%"
SET LOGPATH="%LOGFILE%"

REM ���������� ������� (���������) ��� �������� ��������� ����� ���� 
CALL "%PGBIN%\pg_dump.exe" --format=custom --verbose --file=%DUMPPATH% 2>%LOGPATH%

REM ���������� ������� (���������) ���������, ���� ������ ��� �� �����
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull
REM ��� ������������� ������ ��������� ������������ ���� ����� � ��������������� ������ � ������� � �� ��������
:Error
DEL %DUMPPATH%
MSG * "������ ��� �������� ��������� ����� ���� ������. �������� backup_sibek.log."
ECHO %DATETIME% ������ ��� �������� ��������� ����� ���� ������ %DUMPFILE%. �������� ����� %LOGFILE%. >> backup_sibek.log
GOTO End

REM ���� ����� ������� ��� ������ �������� ������ � ������� �����������
:Successfull
ECHO %DATETIME% �������� �������� ��������� ����� %DUMPFILE% >> backup_sibek.log
GOTO End
:End

REM ��������������� ��������� ��� ����� ������� 5 ���� �� ���� ��������, ������� �� ���������
FORFILES /p "D:\1C BackUp\" /s /m *.* /d -5 /c "CMD /c del /Q @FILE" 
