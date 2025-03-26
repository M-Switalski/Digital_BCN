ENTITY inversor IS
PORT (a : IN BIT; z : OUT BIT);
END inversor;

ARCHITECTURE logicaret OF inversor IS
BEGIN
z <= not a AFTER 5 ns;
END logicaret;

ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logicaret of and2 IS
BEGIN
z <= a AND b AFTER 5 ns;
END logicaret;

ENTITY or2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END or2;

ARCHITECTURE logicaret OF or2 IS
BEGIN
Z <= a OR b AFTER 5 ns;
END logicaret;

ENTITY and3 IS
PORT(a, b, c: IN BIT; z: OUT BIT);
END and3;

ARCHITECTURE logicaret OF and3 IS
BEGIN
Z <= a AND b AND c AFTER 5 ns;
END logicaret;

ENTITY or3 IS
PORT(a, b, c: IN BIT; z: OUT BIT);
END or3;

ARCHITECTURE logicaret OF or3 IS
BEGIN
Z <= a OR b OR c AFTER 5 ns;
END logicaret;

ENTITY and4 IS
PORT(a, b, c, d: IN BIT; z: OUT BIT);
END and4;

ARCHITECTURE logicaret OF and4 IS
BEGIN
Z <= a AND b AND c AND d AFTER 5 ns;
END logicaret;

ENTITY or4 IS
PORT(a, b, c, d: IN BIT; z: OUT BIT);
END or4;

ARCHITECTURE logicaret OF or4 IS
BEGIN
Z <= a OR b OR c OR d AFTER 5 ns;
END logicaret;

ENTITY xor2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END xor2;

ARCHITECTURE logicaret of xor2 IS
BEGIN
z <= a XOR b AFTER 5 ns;
END logicaret;

------------------------------------------------------------------------------------

ENTITY MUX2a1 IS
    PORT (
        a, b, sel : IN BIT;
        z : OUT BIT
    );
END MUX2a1;

ARCHITECTURE logicaret OF MUX2a1 IS
BEGIN
    z <= (NOT sel AND a) OR (sel AND b) AFTER 5 ns;
END logicaret;

ARCHITECTURE estructural OF MUX2a1 IS
    COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    SIGNAL inv_sel, alfa, beta : BIT;

    FOR DUT1: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT2: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT3: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT4: portaor2 USE ENTITY WORK.or2(logicaret);
BEGIN
    DUT1: portainv PORT MAP(sel, inv_sel);
    DUT2: portaand2 PORT MAP(a, inv_sel, alfa);
    DUT3: portaand2 PORT MAP(b, sel, beta);
    DUT4: portaor2 PORT MAP(alfa, beta, z);
END estructural;

ARCHITECTURE ifthen OF MUX2a1 IS
BEGIN
    PROCESS (a, b, sel)
    BEGIN
        IF sel = '0' THEN
            z <= a AFTER 5 ns;
        ELSE
            z <= b AFTER 5 ns;
        END IF;
    END PROCESS;
END ifthen;

ENTITY COMP2BITS IS
    PORT (
        b1, b0, a1, a0 : IN BIT;
        z2, z1, z0 : OUT BIT
    );
END COMP2BITS;

ARCHITECTURE ifthen OF COMP2BITS IS
BEGIN
    PROCESS (b1, b0, a1, a0)
    BEGIN
        IF (b1 > a1) THEN
            z2 <= '1' AFTER 5 ns; z1 <= '0' AFTER 5 ns; z0 <= '0' AFTER 5 ns;
        ELSIF (b1 < a1) THEN
            z2 <= '0' AFTER 5 ns; z1 <= '0' AFTER 5 ns; z0 <= '1' AFTER 5 ns;
        ELSE 
            IF (b0 > a0) THEN
                z2 <= '1' AFTER 5 ns; z1 <= '0' AFTER 5 ns; z0 <= '0' AFTER 5 ns;
            ELSIF (b0 < a0) THEN
                z2 <= '0' AFTER 5 ns; z1 <= '0' AFTER 5 ns; z0 <= '1' AFTER 5 ns;		
            ELSE
                z2 <= '0' AFTER 5 ns; z1 <= '1' AFTER 5 ns; z0 <= '0' AFTER 5 ns;
            END IF;
        END IF;
    END PROCESS;
END ifthen;

ENTITY COMP4BITS IS
    PORT (
        b3, b2, b1, b0, a3, a2, a1, a0 : IN BIT;
        z2, z1, z0 : OUT BIT
    );
END COMP4BITS;

ARCHITECTURE estructural OF COMP4BITS IS
    COMPONENT COMP2BITS IS
        PORT (b1, b0, a1, a0 : IN BIT;
              z2, z1, z0 : OUT BIT);
    END COMPONENT;

    COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    SIGNAL alfa, beta, gamma, delta, epsilon, zeta, eta, theta : BIT;

    FOR DUT1: COMP2BITS USE ENTITY WORK.COMP2BITS(ifthen);
    FOR DUT2: COMP2BITS USE ENTITY WORK.COMP2BITS(ifthen);
    FOR DUT3: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT4: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT5: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT6: portaor2 USE ENTITY WORK.or2(logicaret);
    FOR DUT7: portaor2 USE ENTITY WORK.or2(logicaret);
BEGIN
    DUT1: COMP2BITS PORT MAP(b1, b0, a1, a0, alfa, beta, gamma);
    DUT2: COMP2BITS PORT MAP(b3, b2, a3, a2, delta, epsilon, zeta);
    DUT3: portaand2 PORT MAP(alfa, epsilon, eta);
    DUT4: portaand2 PORT MAP(gamma, epsilon, theta);
    DUT5: portaand2 PORT MAP(beta, epsilon, z1);
    DUT6: portaor2 PORT MAP(zeta, theta, z0);
    DUT7: portaor2 PORT MAP(eta, delta, z2);
END estructural;

ARCHITECTURE ifthen OF COMP4BITS IS
BEGIN
    PROCESS (b3, b2, b1, b0, a3, a2, a1, a0)
    BEGIN
        IF (b3 > a3) THEN
            z2 <= '1' AFTER 5 ns; 
            z1 <= '0' AFTER 5 ns; 
            z0 <= '0' AFTER 5 ns;
        ELSIF (b3 < a3) THEN
            z2 <= '0' AFTER 5 ns; 
            z1 <= '0' AFTER 5 ns; 
            z0 <= '1' AFTER 5 ns;
        ELSE
            IF (b2 > a2) THEN
                z2 <= '1' AFTER 5 ns; 
                z1 <= '0' AFTER 5 ns; 
                z0 <= '0' AFTER 5 ns;
            ELSIF (b2 < a2) THEN
                z2 <= '0' AFTER 5 ns; 
                z1 <= '0' AFTER 5 ns; 
                z0 <= '1' AFTER 5 ns;
            ELSE
                IF (b1 > a1) THEN
                    z2 <= '1' AFTER 5 ns; 
                    z1 <= '0' AFTER 5 ns; 
                    z0 <= '0' AFTER 5 ns;
                ELSIF (b1 < a1) THEN
                    z2 <= '0' AFTER 5 ns; 
                    z1 <= '0' AFTER 5 ns; 
                    z0 <= '1' AFTER 5 ns;
                ELSE
                    IF (b0 > a0) THEN
                        z2 <= '1' AFTER 5 ns; 
                        z1 <= '0' AFTER 5 ns; 
                        z0 <= '0' AFTER 5 ns;
                    ELSIF (b0 < a0) THEN
                        z2 <= '0' AFTER 5 ns; 
                        z1 <= '0' AFTER 5 ns; 
                        z0 <= '1' AFTER 5 ns;
                    ELSE
                        z2 <= '0' AFTER 5 ns; 
                        z1 <= '1' AFTER 5 ns; 
                        z0 <= '0' AFTER 5 ns;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ifthen;


ENTITY sum1bit IS
    PORT (a,b,cin : IN BIT;
          S,cout : OUT BIT);
END sum1bit;

ARCHITECTURE estructural OF sum1bit IS

	COMPONENT portaxor2 IS
        PORT (a, b : IN BIT;
              z : OUT BIT);
    	END COMPONENT;
	
	COMPONENT portaand2 IS
        PORT (a, b : IN BIT;
              z : OUT BIT);
    	END COMPONENT;
	
	COMPONENT portaor2 IS
        PORT (a, b : IN BIT;
              z : OUT BIT);
    	END COMPONENT;

	SIGNAL inv_s1, alfa, beta, gamma, delta: BIT;
	
	FOR DUT1: portaxor2 USE ENTITY WORK.xor2(logicaret);
	FOR DUT2: portaxor2 USE ENTITY WORK.xor2(logicaret);
	FOR DUT3: portaor2 USE ENTITY WORK.or2(logicaret);
	FOR DUT4: portaand2 USE ENTITY WORK.and2(logicaret);
	FOR DUT5: portaand2 USE ENTITY WORK.and2(logicaret);
	FOR DUT6: portaor2 USE ENTITY WORK.xor2(logicaret);

	BEGIN
    DUT1: portaxor2 PORT MAP(a, b, alfa);
    DUT2: portaxor2 PORT MAP(cin, alfa, S);
    DUT3: portaor2 PORT MAP(a, b, beta);
    DUT4: portaand2 PORT MAP(cin, beta, gamma);
    DUT5: portaand2 PORT MAP(a, b, delta);
    DUT6: portaor2 PORT MAP(gamma, delta, cout);
    
END estructural;

ENTITY sum4bits IS
    PORT (
        b3, b2, b1, b0, a3, a2, a1, a0, cin : IN BIT;
        s3, s2, s1, s0, cout : OUT BIT
    );
END sum4bits;

ARCHITECTURE estructural OF sum4bits IS

    COMPONENT sumador IS
        PORT (a, b, cin : IN BIT;
              S, cout : OUT BIT);
    END COMPONENT;

    SIGNAL alfa, beta, gamma : BIT;

    FOR DUT1: sumador USE ENTITY WORK.sum1bit(estructural);
    FOR DUT2: sumador USE ENTITY WORK.sum1bit(estructural);
    FOR DUT3: sumador USE ENTITY WORK.sum1bit(estructural);
    FOR DUT4: sumador USE ENTITY WORK.sum1bit(estructural);

BEGIN
    DUT1: sumador PORT MAP(a0, b0, cin, s0, alfa);
    DUT2: sumador PORT MAP(a1, b1, alfa, s1, beta);
    DUT3: sumador PORT MAP(a2, b2, beta, s2, gamma);
    DUT4: sumador PORT MAP(a3, b3, gamma, s3, cout);

END estructural;

----------------------------------------------------------------------------------------------------------------
ENTITY mux4a1 IS
    PORT (a, b, c, d, sel1, sel0  : IN BIT;
          z : OUT BIT);
END mux4a1;

ARCHITECTURE logicaret of mux4a1 IS
BEGIN
z <= (NOT sel1 AND NOT sel0 AND a) OR (NOT sel1 AND sel0 AND b) OR (sel1 AND NOT sel0 AND c) OR (sel1 AND sel0 AND d) AFTER 5 ns;
END logicaret;

ENTITY FF_D IS
PORT(D, ck, preset: IN BIT; Q: OUT BIT);
END FF_D;

ARCHITECTURE ifthen OF FF_D IS
SIGNAL alfa: BIT;
BEGIN
PROCESS (D, ck, preset)
BEGIN
    IF preset = '0' THEN
        alfa <= '1' AFTER 2 ns;	
    ELSIF ck'EVENT AND ck = '0' THEN
        alfa <= D AFTER 2 ns;
    END IF;
END PROCESS;

Q <= alfa;
END ifthen;

ENTITY Reg1bit IS
    PORT (a, b, s1, s0, ck : IN BIT;
          z : OUT BIT);
END Reg1bit;

ARCHITECTURE estructural OF Reg1bit Is

	COMPONENT ff IS
	PORT(D, ck, preset: IN BIT; Q: OUT BIT);
	END COMPONENT;

	COMPONENT mux IS
    	PORT (a, b, c, d, sel1, sel0  : IN BIT;
          z : OUT BIT);
	END COMPONENT;

	SIGNAL alfa, preset, beta: BIT;

	FOR DUT1: mux USE ENTITY WORK.mux4a1(logicaret);
	FOR DUT2: ff USE ENTITY WORK.FF_D(ifthen);

	BEGIN
    DUT1: mux PORT MAP('0', beta, a, b, s1, s0, alfa);
    DUT2: ff PORT MAP(alfa, ck,'1', beta);
	z <= beta AFTER 5 ns;
    
END estructural;

ENTITY reg4bits IS
    PORT (ent3, ent2, ent1, ent0, cont1, cont0, d, clock  : IN BIT;
          sort3, sort2, sort1, sort0 : OUT BIT);
END reg4bits;

ARCHITECTURE estructural OF reg4bits IS
	COMPONENT Reg1 IS
	PORT(a, b, s1, s0, ck : IN BIT;
          z : OUT BIT);
	END COMPONENT;

	SIGNAL alfa, beta, gamma: BIT;

	FOR DUT1: Reg1 USE ENTITY WORK.Reg1bit(estructural);
	FOR DUT2: Reg1 USE ENTITY WORK.Reg1bit(estructural);
	FOR DUT3: Reg1 USE ENTITY WORK.Reg1bit(estructural);
	FOR DUT4: Reg1 USE ENTITY WORK.Reg1bit(estructural);

	BEGIN
	DUT1: Reg1 PORT MAP(ent3, d, cont1, cont0, clock, alfa);
	sort3 <= alfa;
	DUT2: Reg1 PORT MAP(ent2, alfa, cont1, cont0, clock, beta);
	sort2 <= beta;
	DUT3: Reg1 PORT MAP(ent1, beta, cont1, cont0, clock, gamma);
	sort1 <= gamma;
	DUT4: Reg1 PORT MAP(ent0, gamma, cont1, cont0, clock, sort0);
END estructural;








