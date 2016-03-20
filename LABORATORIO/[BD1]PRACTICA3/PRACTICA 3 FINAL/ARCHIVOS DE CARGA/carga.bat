@echo off

exit | sqlplus C##PRACTICA3/1234@localhost:1521/ORACLEDB @C:\Users\Public\Documents\DROPS.sql


exit | sqlplus C##PRACTICA3/1234@localhost:1521/ORACLEDB @C:\Users\Public\Documents\DB.sql


exit | sqlldr userid = C##PRACTICA3/1234  control=C:\Users\Public\Documents\ARTIST.ctl
echo ARTISTAS CARGADOS


exit | sqlldr userid = C##PRACTICA3/1234  control=C:\Users\Public\Documents\CANCIONES.ctl ERRORS=15200
echo CANCIONES CARGADAS


exit | sqlldr userid = C##PRACTICA3/1234  control=C:\Users\Public\Documents\USERS.ctl
echo USUARIOS CARGADOS


exit | sqlldr userid = C##PRACTICA3/1234  control=C:\Users\Public\Documents\REPRO.ctl
echo REPRODUCIONES CARGADOS


exit;



