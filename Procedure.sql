CREATE OR REPLACE PROCEDURE gerar_relatorio_folha_pagamento AS
BEGIN
    -- Cabeçalho
    DBMS_OUTPUT.PUT_LINE('________________________________________________________________________________');
    DBMS_OUTPUT.PUT_LINE('Folha de pagamento - TAB Funcionario');
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('ID | NOME               |SALARIO BRUTO |   DESC IR   | DESC SEG | SALARIO LIQUID');
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    
    FOR funcionario IN (SELECT CodFun, NomFun, Salario FROM FUNCIONARIO) LOOP
        DECLARE
            IMPOSTO NUMBER;
            SEGURO_EMPREGO NUMBER;
            SALARIO_LIQUIDO NUMBER;
        BEGIN
            IF funcionario.Salario > 2000 THEN
                IMPOSTO := funcionario.Salario * 0.1;
            ELSE
                IMPOSTO := funcionario.Salario * 0.02;
            END IF;
            
            SEGURO_EMPREGO := funcionario.Salario * 0.02;
            
            SALARIO_LIQUIDO := funcionario.Salario - IMPOSTO - SEGURO_EMPREGO;
            
            -- Formatar e exibir os resultados
            DBMS_OUTPUT.PUT_LINE(
                RPAD(funcionario.CodFun, 3) || '| ' ||
                RPAD(funcionario.NomFun, 18) || ' |' ||
                'R$' || TO_CHAR(funcionario.Salario, '999,999.99') || ' | ' ||
                TO_CHAR(IMPOSTO, '999,999.99') || ' | ' ||
                TO_CHAR(SEGURO_EMPREGO, '9,999.99') || ' | ' ||
                'R$' || TO_CHAR(SALARIO_LIQUIDO, '999,999.99')
            );
        END;
    END LOOP;
END gerar_relatorio_folha_pagamento;
/