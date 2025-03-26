
ENTITY circuit IS
    PORT (
        Sx,x2,x1,x0,clock : IN BIT;
        f3,f2,f1,f0,g3,g2,g1,g0 : OUT BIT
    );
END circuit;


ARCHITECTURE estructural OF circuit IS
    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

	COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

	COMPONENT COMP4BITS IS
    	PORT (
        b3, b2, b1, b0, a3, a2, a1, a0 : IN BIT;
        z2, z1, z0 : OUT BIT
    	);
	END COMPONENT;
	
	COMPONENT sum4bits IS
    	PORT (
        b3, b2, b1, b0, a3, a2, a1, a0, cin : IN BIT;
        s3, s2, s1, s0, cout : OUT BIT
    	);
	END COMPONENT;

	COMPONENT reg4bits IS
    	PORT (ent3, ent2, ent1, ent0, cont1, cont0, d, clock  : IN BIT;
          sort3, sort2, sort1, sort0 : OUT BIT);
	END COMPONENT;

	COMPONENT MUX2a1 IS
    	PORT (
        a, b, sel : IN BIT;
        z : OUT BIT
    	);
	END COMPONENT;


	SIGNAL z10, z20, z01, z11, alfa, beta, gamma, sum0, sum1, sum3, sum2, mux0, mux1, mux2, mux3, inv1, inv2, inv3, inv0, scout: BIT;

	FOR DUT1: COMP4BITS USE ENTITY WORK.COMP4BITS(ifthen);
    FOR DUT2: COMP4BITS USE ENTITY WORK.COMP4BITS(ifthen);
    FOR DUT3: portaor2 USE ENTITY WORK.or2(logicaret);
	FOR DUT4: portainv USE ENTITY WORK.inversor(logicaret);
	FOR DUT5: portainv USE ENTITY WORK.inversor(logicaret);
	FOR DUT6: portainv USE ENTITY WORK.inversor(logicaret);
	FOR DUT13: portainv USE ENTITY WORK.inversor(logicaret);
	FOR DUT14: sum4bits USE ENTITY WORK.sum4bits(estructural);
	FOR DUT7: MUX2a1 USE ENTITY WORK.MUX2a1(estructural);
	FOR DUT8: MUX2a1 USE ENTITY WORK.MUX2a1(estructural);
	FOR DUT9: MUX2a1 USE ENTITY WORK.MUX2a1(estructural);
	FOR DUT10: MUX2a1 USE ENTITY WORK.MUX2a1(estructural);
	FOR DUT11: reg4bits USE ENTITY WORK.reg4bits(estructural);
	FOR DUT12: reg4bits USE ENTITY WORK.reg4bits(estructural);

BEGIN
	DUT1: COMP4BITS PORT MAP('0', '1', '0', '0', Sx,x2,x1,x0, z20, z10, alfa);
	DUT2: COMP4BITS PORT MAP('1', '1', '0', '0', Sx,x2,x1,x0, beta, z11, z01);
	DUT3: portaor2 PORT MAP(alfa, beta, gamma);
	DUT4: portainv PORT MAP(x1,inv1);
	DUT5: portainv PORT MAP(x2,inv2);
	DUT6: portainv PORT MAP(Sx,inv3);
	DUT13: portainv PORT MAP(x0,inv0);
	DUT14: sum4bits PORT MAP('0','0','0','0',inv3, inv2, inv1, inv0,'1', sum3, sum2, sum1, sum0, scout);
	DUT7: MUX2a1 PORT MAP(sum3,x0,Sx,mux3);
	DUT8: MUX2a1 PORT MAP(sum2,x1,Sx,mux2);
	DUT9: MUX2a1 PORT MAP(sum1,x2,Sx, mux1);
	DUT10: MUX2a1 PORT MAP(sum0,Sx,Sx, mux0);
	DUT11: reg4bits PORT MAP(x0,x1,x2,Sx, gamma, '0', '0', clock, f3, f2, f1, f0);
	DUT12: reg4bits PORT MAP(mux3, mux2, mux1, mux0, gamma, '0', '0', clock, g3, g2, g1, g0);
END estructural;