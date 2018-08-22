*> Test File I/O: READ, WRITE
*> An example program which 
*>    reades (TFileIn.dat) records from a input file,
*>    displays the records, 
*>    and writes (TFileOut.dat)them to a sequential file.
*>
*> Progrm-ID: TFile.cob
*> Author:    Kuo-pao Yang
*> OS:        Ubuntu 18
*> Compiler:  OpenCOBOL
*> Note:
*> The following instructions are used to
*>       edit, compile, and run this program
*>    $ nano  TFile.cob
*>    $ cobc -x -free TFile.cob
*>    $ ./TFile

IDENTIFICATION DIVISION.
PROGRAM-ID.  TFile.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT myInFile  ASSIGN TO "TFileIn.dat".
    SELECT myOutFile ASSIGN TO "TFileOut.dat".
DATA DIVISION.
FILE SECTION.
FD myInFile.
01 inRecord.
   02  m  PIC XX.
   02  n  PIC X(2).
   02  o  PIC 99.
   02  p  PIC 9(2).
   02  q  PIC X.
FD myOutFile.
01 outRecord.
   02  r  PIC XX.
   02  s  PIC X(2).
   02  t  PIC 99.
   02  u  PIC 9(2).
   02  v  PIC X.
WORKING-STORAGE SECTION.
01 w   PIC  X(3)  VALUE "YES".
PROCEDURE DIVISION.
    OPEN INPUT myInFile.
    OPEN OUTPUT myOutFile.
    PERFORM subRead
    PERFORM UNTIL w = "NO"
       MOVE m to r
       MOVE n to s
       COMPUTE t = o + 1
       COMPUTE u = p - 2
       MOVE q to v 
       DISPLAY "r = ", r, ",s = ", s, ",t = ", t, ",u = ", u
       WRITE outRecord
       PERFORM subRead
    END-PERFORM.
    CLOSE myInFile.
    CLOSE myOutFile.
    STOP RUN.
subRead.
    READ myInFile
       AT END 
          MOVE "NO" TO w
       NOT AT END
          DISPLAY "m = ", m, ",n = ", n, ",o = ", o, ",p = ", p
    END-READ.

*> Input:  
*>    file "TFileIn.dat"
*>         abcd1234
*>         efgh5678
*> Output: file "TFileOut.dat" and display on screen:
*>    file "TFileOut.dat"
*>         abcd1332
*>         efgh5776
*>    Screen
*>         m = ab,n = cd,o = 12,p = 34
*>         r = ab,s = cd,t = 13,u = 32
*>         m = ef,n = gh,o = 56,p = 78
*>         r = ef,s = gh,t = 57,u = 76
