@ECHO OFF
IF EXIST "C:\Program Files\GRAPHISOFT\ArchiCAD 18\Add-Ons\RosettaArchiCAD.apx"(del "C:\Program Files\GRAPHISOFT\ArchiCAD 18\Add-Ons\RosettaArchiCAD.apx") ELSE()
copy "C:\Program Files\GRAPHISOFT\API Development Kit 18.3006\Examples\Geometry_Test - Copy\x64\RosettaArchiCAD.apx" "C:\Program Files\GRAPHISOFT\ArchiCAD 18\Add-Ons"