IDENTIFICATION DIVISION.
PROGRAM-ID. P2.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT IN-FILE  ASSIGN TO "P2In.dat" ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD IN-FILE.
01 IN-RECORD.
    02 NAME             PIC A(19).
    02 W-NUMBER         PIC X(10).
    02 SEMESTER         PIC X(13).
    02 COURSE           PIC X(13).
    02 DESCRIPTION      PIC X(30).
    02 GRADE            PIC A.
WORKING-STORAGE SECTION.
01 EOF PIC A VALUE "N".

PROCEDURE DIVISION.
    OPEN INPUT IN-FILE.
    PERFORM SUBREAD
    PERFORM UNTIL EOF = "Y"
        PERFORM SUBREAD
    END-PERFORM.
    CLOSE IN-FILE.
    STOP RUN.

SUBREAD.
    READ IN-FILE
        AT END
            MOVE "Y" TO EOF
        NOT AT END
            DISPLAY NAME, W-NUMBER, SEMESTER, COURSE, DESCRIPTION, GRADE
    END-READ.
