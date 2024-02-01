CREATE OR REPLACE PROCEDURE gerar_relatorio_folha_pagamento_br AS
BEGIN
    -- Cabe�alho
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
            IF funcionario.Salario BETWEEN 2112.01 AND 2826.65 THEN
                IMPOSTO := (funcionario.Salario - 158.4) * 0.075;
                ELSIF funcionario.Salario BETWEEN 2826.66 AND 3751.05 THEN
                	IMPOSTO := (funcionario.Salario - 370.4) * 0.15;
                ELSIF funcionario.Salario BETWEEN 3751.06 AND 4664.68 THEN
                		IMPOSTO := (funcionario.Salario - 651.73) * 0.225;
				ELSIF funcionario.Salario > 4664.68 THEN
                				IMPOSTO := (funcionario.Salario - 884.96) * 0.275;
						ELSIF funcionario.Salario < 2112.01 THEN
							IMPOSTO := 0;
            END IF;
            
            SEGURO_EMPREGO := funcionario.Salario * 0.08;
            
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
END gerar_relatorio_folha_pagamento_br;
/