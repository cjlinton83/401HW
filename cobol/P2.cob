IDENTIFICATION DIVISION.
PROGRAM-ID. P2.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT IN-FILE ASSIGN TO "P2In.dat"
        ORGANIZATION IS LINE SEQUENTIAL.
    SELECT OUT-FILE ASSIGN TO "P2Out.dat"
        ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD IN-FILE.
01 IN-RECORD.
    05 STUDENT-NAME          PIC A(19).
    05 STUDENT-NUMBER        PIC X(10).
    05 SEMESTER              PIC X(15).
    05 COURSE                PIC X(15).
    05 COURSE-TITLE          PIC X(30).
    05 GRADE                 PIC A(5).
    05 EARNED                PIC 9.99.
FD OUT-FILE.
01 OUT-SCHOOL-NAME.
    05 FILLER                PIC A(22).
    05 FILLER                PIC A(34).
01 OUT-SCHOOL-ADDR.
    05 FILLER                PIC A(30).
    05 FILLER                PIC X(18).
01 OUT-SPACE                 PIC A.
01 OUT-STUDENT-NAME          PIC A(19).
01 OUT-STUDENT-NUMBER        PIC X(10).
01 OUT-SEMESTER              PIC X(15).
01 OUT-LABELS.
    05 FILLER                PIC X(15).
    05 FILLER                PIC X(30).
    05 FILLER                PIC A(5).
    05 FILLER                PIC A(11).
    05 FILLER                PIC AAAA.
01 OUT-RECORD.
    05 OUT-COURSE            PIC X(15).
    05 OUT-COURSE-TITLE      PIC X(30).
    05 OUT-GRADE             PIC A(5).
    05 OUT-EARNED            PIC 9.99.
    05 FILLER                PIC A(5).
    05 OUT-QPTS              PIC ZZ9.99.
01 OUT-EOS-SEMESTER-TOTALS.
    05 FILLER                PIC A(29).
    05 FILLER                PIC A(19).
    05 OUT-SEMESTER-EARNED   PIC ZZ9.99.
    05 FILLER                PIC A(5).
    05 OUT-SEMESTER-QPTS     PIC ZZ9.99.
    05 FILLER                PIC AAAA.
    05 OUT-SEMESTER-GPA      PIC ZZ9.99.
01 OUT-EOS-CUM-TOTALS.
    05 FILLER                PIC A(29).
    05 FILLER                PIC A(19).
    05 OUT-CUMULATIVE-EARNED PIC ZZ9.99.
    05 FILLER                PIC A(5).
    05 OUT-CUMULATIVE-QPTS   PIC ZZ9.99.
    05 FILLER                PIC AAAA.
    05 OUT-CUMULATIVE-GPA    PIC ZZ9.99.

WORKING-STORAGE SECTION.
01 WS-SCHOOL-NAME.
    05 FILLER                PIC A(22)   VALUE SPACE.
    05 FILLER                PIC A(34)   VALUE "SOUTHEASTERN LOUISIANA UNIVSERITY".
01 WS-SCHOOL-ADDR.
    05 FILLER                PIC A(30)   VALUE SPACE.
    05 FILLER                PIC X(80)   VALUE "HAMMOND, LA 70402".
01 WS-SPACE                  PIC A       VALUE SPACE.
01 WS-LABELS.
    05 FILLER                PIC X(15)   VALUE "COURSE".
    05 FILLER                PIC X(30)   VALUE "TITLE".
    05 FILLER                PIC A(5)    VALUE "GR".
    05 FILLER                PIC A(11)   VALUE "EARNED".
    05 FILLER                PIC AAAA    VALUE "QPTS".
01 EOF                       PIC A       VALUE "N".
01 WS-SEMESTER               PIC X(15).
01 WS-RECORD.
    05 WS-COURSE             PIC X(15).
    05 WS-COURSE-TITLE       PIC X(30).
    05 WS-GRADE              PIC A(5).
    05 WS-EARNED             PIC 9.99.
    05 FILLER                PIC A(5)    VALUE SPACE.
    05 WS-QPTS               PIC ZZ9.99.
01 WS-EOS-SEMESTER-TOTALS.
    05 FILLER                PIC A(29)   VALUE SPACE.
    05 FILLER                PIC A(19)   VALUE "SEMESTER".
    05 WS-SEMESTER-EARNED    PIC ZZ9.99.
    05 FILLER                PIC A(5)    VALUE SPACE.
    05 WS-SEMESTER-QPTS      PIC ZZ9.99.
    05 FILLER                PIC AAAA    VALUE SPACE.
    05 WS-SEMESTER-GPA       PIC ZZ9.99.
01 WS-EOS-CUM-TOTALS.
    05 FILLER                PIC A(29)   VALUE SPACE.
    05 FILLER                PIC A(19)   VALUE "CUMULATIVE".
    05 WS-CUMULATIVE-EARNED  PIC ZZ9.99.
    05 FILLER                PIC A(5)    VALUE SPACE.
    05 WS-CUMULATIVE-QPTS    PIC ZZ9.99.
    05 FILLER                PIC AAAA    VALUE SPACE.
    05 WS-CUMULATIVE-GPA     PIC ZZ9.99.

*> WSC FIELDS ARE USED FOR COMPUTATION THEN MOVED TO ASSOCIATED WS FIELD.
01 WSC-EARNED                PIC 999V99  VALUE ZERO.
01 WSC-QPTS                  PIC 999V99  VALUE ZERO.
01 WSC-SEMESTER-EARNED       PIC 999V99  VALUE ZERO.
01 WSC-CUMULATIVE-EARNED     PIC 999V99  VALUE ZERO.
01 WSC-SEMESTER-QPTS         PIC 999V99  VALUE ZERO.
01 WSC-CUMULATIVE-QPTS       PIC 999V99  VALUE ZERO.

PROCEDURE DIVISION.
MAIN-LOGIC SECTION.
PROGRAM-BEGIN.

    PERFORM OPENING-PROCEDURE.
    PERFORM WRITE-DISPLAY-REPORT.
    PERFORM CLOSING-PROCEDURE.

PROGRAM-DONE.
    STOP RUN.

OPENING-PROCEDURE.
    OPEN INPUT IN-FILE.
    OPEN OUTPUT OUT-FILE.

CLOSING-PROCEDURE.
    CLOSE IN-FILE, OUT-FILE.

READ-NEXT-RECORD.
    READ IN-FILE NEXT RECORD
        AT END
            MOVE "Y" TO EOF.

WRITE-DISPLAY-REPORT.
    PERFORM READ-NEXT-RECORD.
    MOVE SEMESTER TO WS-SEMESTER.

    PERFORM WRITE-HEADER.
    PERFORM DISPLAY-HEADER.

    PERFORM UNTIL EOF = "Y"
        PERFORM SET-WS-RECORD

        IF EOF = "N" THEN
            IF SEMESTER = WS-SEMESTER THEN
                PERFORM DISPLAY-SEMESTER-RECORDS
                PERFORM WRITE-SEMESTER-RECORDS
                PERFORM UPDATE-SEMESTER-TOTALS
            ELSE
                PERFORM CALCULATE-EOS-TOTALS
                PERFORM DISPLAY-EOS-TOTALS
                PERFORM WRITE-EOS-TOTALS

                MOVE SEMESTER TO WS-SEMESTER

                DISPLAY WS-SPACE
                WRITE OUT-SPACE FROM WS-SPACE
                DISPLAY WS-SEMESTER
                WRITE OUT-SEMESTER FROM WS-SEMESTER

                PERFORM DISPLAY-SEMESTER-RECORDS
                PERFORM WRITE-SEMESTER-RECORDS
                PERFORM UPDATE-SEMESTER-TOTALS
            END-IF
        END-IF

        PERFORM READ-NEXT-RECORD
    END-PERFORM.

    PERFORM CALCULATE-EOS-TOTALS.
    PERFORM DISPLAY-EOS-TOTALS.
    PERFORM WRITE-EOS-TOTALS.

WRITE-HEADER.
    WRITE OUT-SCHOOL-NAME FROM WS-SCHOOL-NAME.
    WRITE OUT-SCHOOL-ADDR FROM WS-SCHOOL-ADDR.
    WRITE OUT-SPACE FROM WS-SPACE.

    WRITE OUT-STUDENT-NAME FROM STUDENT-NAME.
    WRITE OUT-STUDENT-NUMBER FROM STUDENT-NUMBER.
    WRITE OUT-SPACE FROM WS-SPACE.

    WRITE OUT-SEMESTER FROM WS-SEMESTER.
    WRITE OUT-LABELS FROM WS-LABELS.

DISPLAY-HEADER.
    DISPLAY WS-SCHOOL-NAME.
    DISPLAY WS-SCHOOL-ADDR.
    DISPLAY WS-SPACE.

    DISPLAY STUDENT-NAME.
    DISPLAY STUDENT-NUMBER.
    DISPLAY WS-SPACE.

    DISPLAY WS-SEMESTER.
    DISPLAY WS-LABELS.

SET-WS-RECORD.
    MOVE COURSE TO WS-COURSE.
    MOVE COURSE-TITLE TO WS-COURSE-TITLE.
    MOVE GRADE TO WS-GRADE.
    MOVE EARNED TO WS-EARNED.

    PERFORM SET-QPTS.

SET-QPTS.
    MOVE WS-EARNED TO WSC-QPTS.

    IF WS-GRADE IS EQUAL TO "A" THEN
        COMPUTE WSC-QPTS = WSC-QPTS * 4
    ELSE IF WS-GRADE IS EQUAL TO "B" THEN
        COMPUTE WSC-QPTS = WSC-QPTS * 3
    ELSE IF WS-GRADE IS EQUAL TO "C" THEN
        COMPUTE WSC-QPTS = WSC-QPTS * 2
    ELSE IF WS-GRADE IS EQUAL TO "D" THEN
        COMPUTE WSC-QPTS = WSC-QPTS * 1
    ELSE        
        MOVE 0 TO WSC-QPTS
    END-IF.

    MOVE WSC-QPTS TO WS-QPTS.

UPDATE-SEMESTER-TOTALS.
    MOVE WS-EARNED TO WSC-EARNED.
    COMPUTE WSC-SEMESTER-EARNED = WSC-SEMESTER-EARNED + WSC-EARNED.

    COMPUTE WSC-SEMESTER-QPTS = WSC-SEMESTER-QPTS + WSC-QPTS.

CALCULATE-EOS-TOTALS.
    MOVE WSC-SEMESTER-EARNED TO WS-SEMESTER-EARNED.
    MOVE WSC-SEMESTER-QPTS TO WS-SEMESTER-QPTS.

    COMPUTE WSC-CUMULATIVE-EARNED = WSC-CUMULATIVE-EARNED + WSC-SEMESTER-EARNED.
    MOVE WSC-CUMULATIVE-EARNED TO WS-CUMULATIVE-EARNED.

    COMPUTE WSC-CUMULATIVE-QPTS = WSC-CUMULATIVE-QPTS + WSC-SEMESTER-QPTS.
    MOVE WSC-CUMULATIVE-QPTS TO WS-CUMULATIVE-QPTS.
    
    MOVE ZERO TO WSC-SEMESTER-EARNED.
    MOVE ZERO TO WSC-SEMESTER-QPTS.

DISPLAY-EOS-TOTALS.
    DISPLAY WS-EOS-SEMESTER-TOTALS.
    DISPLAY WS-EOS-CUM-TOTALS.

WRITE-EOS-TOTALS.
    WRITE OUT-EOS-SEMESTER-TOTALS FROM WS-EOS-SEMESTER-TOTALS.
    WRITE OUT-EOS-CUM-TOTALS FROM WS-EOS-CUM-TOTALS.

DISPLAY-SEMESTER-RECORDS.
    DISPLAY WS-RECORD.

WRITE-SEMESTER-RECORDS.
    WRITE OUT-RECORD FROM WS-RECORD.
