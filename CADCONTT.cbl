      ******************************************************************
      * Author: GABRIEL ELI LEANDRO
      * Date: 12/07/2022
      * Purpose: CADASTRAR CONTATOS
      * Update: 15/07/2022 - TRANSFORMADO DE PROGRAMA PARA MODULO
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CADCONTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
            INPUT-OUTPUT SECTION.
            FILE-CONTROL.
                SELECT CONTATOS ASSIGN TO
                'C:\Users\Gabriel\Desktop\CRUD COBOL\bin\CONTATOS.DAT'
                ORGANIZATION IS INDEXED
                ACCESS MODE  IS RANDOM
                RECORD KEY   IS ID-CONTATO
                FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD CONTATOS.
       COPY FD_CONTT.
       WORKING-STORAGE SECTION.
       01 WS-REGISTRO                   PIC X(22) VALUE SPACES.
       01 FILLER REDEFINES WS-REGISTRO.
          03 WS-ID-CONTATO              PIC 9(02).
          03 WS-NM-CONTATO              PIC X(20).
       77 WS-FS                         PIC 99.
          88 FS-OK                      VALUE 0.
       77 WS-EOF                        PIC X.
          88 EOF-OK                     VALUE 'S' FALSE 'N'.
       77 WS-EXIT                       PIC X.
          88 EXIT-OK                    VALUE 'F' FALSE 'N'.

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM                PIC X(40).

       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN-PROCEDURE.
            DISPLAY LK-MENSAGEM
            SET EXIT-OK                TO FALSE
            PERFORM P300-CADASTRA      THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
           .
       P300-CADASTRA.
            SET EOF-OK                 TO FALSE
            SET FS-OK                  TO TRUE

            DISPLAY 'PARA REGISTRAR UM CONTATO, INFORME: '
            DISPLAY 'Um numero para a Identificacao: '
            ACCEPT WS-ID-CONTATO
            DISPLAY 'Um nome para o Contato: '
            ACCEPT WS-NM-CONTATO

            OPEN I-O CONTATOS

            IF WS-FS EQUAL 35 THEN
                OPEN OUTPUT CONTATOS
            END-IF

            IF FS-OK THEN
                MOVE WS-ID-CONTATO     TO ID-CONTATO
                MOVE WS-NM-CONTATO     TO NM-CONTATO

                WRITE REG-CONTATOS
                INVALID KEY
                           DISPLAY 'CONTATO JA CADASTRADO!'
                      NOT INVALID KEY
                           DISPLAY 'Contato gravado com sucesso!'
                END-WRITE
            ELSE
                DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS.'
                DISPLAY 'FILE STATUS: ' WS-FS
            END-IF

            CLOSE CONTATOS

            DISPLAY
               'TECLE: '
               '<QUALQUER TECLA> para continuar, ou <F> para finalizar.'
            ACCEPT WS-EXIT
           .
       P300-FIM.
       P900-FIM.
            GOBACK.
       END PROGRAM CADCONTT.
