
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




----------------------------------



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


ENTITY mux2a_4bits IS
    PORT (
        b3,b2,b1,b0,a3,a2,a1,a0,sel: IN BIT;
        z3,z2,z1,z0 : OUT BIT
    );
END mux2a_4bits;

------------------------------------------------

ARCHITECTURE estructural OF mux2a_4bits IS
    COMPONENT comMUX2a1 IS
        PORT (
        a, b, sel : IN BIT;
        z : OUT BIT
    );
    END COMPONENT;

    --SIGNAL inv_sel, alfa, beta : BIT;

    FOR DUT1: comMUX2a1 USE ENTITY WORK.MUX2a1(logicaret);
    FOR DUT2: comMUX2a1 USE ENTITY WORK.MUX2a1(logicaret);
    FOR DUT3: comMUX2a1 USE ENTITY WORK.MUX2a1(logicaret);
    FOR DUT4: comMUX2a1 USE ENTITY WORK.MUX2a1(logicaret);
BEGIN
    DUT1: comMUX2a1 PORT MAP(a3,b3,sel,z3);
    DUT2: comMUX2a1 PORT MAP(a2,b2,sel,z2);
    DUT3: comMUX2a1 PORT MAP(a1,b1,sel,z1);
    DUT4: comMUX2a1 PORT MAP(a0,b0,sel,z0);
END estructural;

ENTITY comp1bit IS
    PORT (
        b,a,g_ant,p_ant : IN BIT;
        g,p : OUT BIT
    );
END comp1bit;

ARCHITECTURE estructural OF comp1bit IS
    COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand3 IS
        PORT (a, b, c : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

SIGNAL inv_a, inv_b, inv_g, inv_p, and_p, and_g : BIT;

    FOR DUT1: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT2: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT3: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT4: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT5: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT6: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT7: portaor2 USE ENTITY WORK.or2(logicaret);
    FOR DUT8: portaor2 USE ENTITY WORK.or2(logicaret);
BEGIN
    DUT1: portainv PORT MAP(a, inv_a);
    DUT2: portainv PORT MAP(b, inv_b);
    DUT3: portainv PORT MAP(g_ant, inv_g);
    DUT4: portainv PORT MAP(p_ant, inv_p);
    DUT5: portaand3 PORT MAP(b, inv_p, inv_a, and_p);
    DUT6: portaand3 PORT MAP(a, inv_g, inv_b, and_g);
    DUT7: portaor2 PORT MAP(g_ant,and_p,g);
    DUT8: portaor2 PORT MAP(p_ant, and_g, p);

END estructural;




ENTITY comp4bits IS
    PORT (
        b3,b2,b1,b0,a3,a2,a1,a0 : IN BIT;
        z2,z1,z0 : OUT BIT
    );
END comp4bits;

ARCHITECTURE estructural OF comp4bits IS
COMPONENT ccomp1bit IS
    PORT (
        b,a,g_ant,p_ant : IN BIT;
        g,p : OUT BIT
    );
END COMPONENT;

COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
END COMPONENT;

COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
END COMPONENT;

SIGNAL g1, g2, g3, g0, p1, p2, p3, p0, or_s : BIT;

    FOR DUT1: ccomp1bit USE ENTITY WORK.comp1bit(estructural);
    FOR DUT2: ccomp1bit USE ENTITY WORK.comp1bit(estructural);
    FOR DUT3: ccomp1bit USE ENTITY WORK.comp1bit(estructural);
    FOR DUT4: ccomp1bit USE ENTITY WORK.comp1bit(estructural);
    FOR DUT5: portaor2 USE ENTITY WORK.or2(logicaret);
    FOR DUT6: portainv USE ENTITY WORK.inversor(logicaret);

BEGIN
    DUT1: ccomp1bit PORT MAP(b3, a3, '0', '0', g3, p3);
    DUT2: ccomp1bit PORT MAP(b2, a2, g3, p3, g2, p2);
    DUT3: ccomp1bit PORT MAP(b1, a1, g2, p2, g1, p1);
    DUT4: ccomp1bit PORT MAP(b0, a0, g1, p1, g0, p0);
    DUT5: portaor2 PORT MAP(g0, g0, or_s);
    DUT6: portainv PORT MAP(or_s, z1);
    z2 <= g0;
    z0 <= p0;

END estructural;


----------------------------------------------------------- s1 s0
ENTITY reg4bits IS
PORT(a3,a2,a1,a0, dl, dr, clr, s1,s0, clock: IN BIT; f3,f2,f1,f0: OUT BIT);
END reg4bits;

ARCHITECTURE ifthen OF reg4bits IS
SIGNAL q3int, q2int, q1int, q0int: BIT;
BEGIN
PROCESS (s1, s0, a3,a2,a1,a0, dl, dr, clr, clock)
BEGIN
IF clr='0' THEN 
	q3int <= '0' AFTER 5 ns; q2int <= '0' AFTER 5 ns; q1int <= '0' AFTER 5 ns; q0int <= '0' AFTER 5 ns;
      ELSIF clock'EVENT AND clock='0' THEN
	IF (s1 = '0' AND s0 = '0') THEN
		q3int <= q3int AFTER 5 ns; q2int <= q2int AFTER 5 ns; q1int <= q1int AFTER 5 ns; q0int <= q0int AFTER 5 ns;
	ELSIF (s1 = '0' AND s0 = '1') THEN
		q3int <= q2int AFTER 5 ns; q2int <= q1int AFTER 5 ns; q1int <= q0int AFTER 5 ns; q0int <= dr AFTER 5 ns;
	ELSIF (s1 = '1' AND s0 = '0') THEN
		q3int <= dl AFTER 5 ns; q2int <= q3int AFTER 5 ns; q1int <= q2int AFTER 5 ns; q0int <= q1int AFTER 5 ns;
	ELSIF (s1 = '1' AND s0 = '1') THEN
		q3int <= a3 AFTER 5 ns; q2int <= a2 AFTER 5 ns; q1int <= a1 AFTER 5 ns; q0int <= a0 AFTER 5 ns;
	END IF;
END IF;
END PROCESS;
f3 <= q3int;
f2 <= q2int;
f1 <= q1int;
f0 <= q0int;
END ifthen;

------------------------------------------------------------------

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
	FOR DUT6: portaor2 USE ENTITY WORK.or2(logicaret);

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


-------------------circuit--------------------------------


ENTITY circuit IS
    PORT (
        a3,a2,a1,a0,b3,b2,b1,b0, s1,s0, clock : IN BIT;
        sort3,sort2,sort1,sort0 : OUT BIT
    );
END circuit;

ARCHITECTURE estructural OF circuit IS

COMPONENT ccomp4bits IS
    PORT (
        b3,b2,b1,b0,a3,a2,a1,a0 : IN BIT;
        z2,z1,z0 : OUT BIT
    );
END COMPONENT;

COMPONENT cmux2a_4bits IS
    PORT (
        b3,b2,b1,b0,a3,a2,a1,a0,sel: IN BIT;
        z3,z2,z1,z0 : OUT BIT
    );
END COMPONENT;

COMPONENT creg4bits IS
PORT(a3,a2,a1,a0, dl, dr, clr, s1,s0, clock: IN BIT; f3,f2,f1,f0: OUT BIT);
END COMPONENT;

COMPONENT csum4bits IS
    PORT (
        b3, b2, b1, b0, a3, a2, a1, a0, cin : IN BIT;
        s3, s2, s1, s0, cout : OUT BIT
    );
END COMPONENT;


    SIGNAL sout, sel, muxz0, muxz1, muxz2, muxz3, regz00, zegz10, regz20, regz30, regz01, regz11, regz21, regz31, compz1, compz2, compz0 : BIT;

    FOR DUT1: ccomp4bits USE ENTITY WORK.comp4bits(estructural);
    FOR DUT2: cmux2a_4bits USE ENTITY WORK.mux2a_4bits(estructural);
    FOR DUT3: creg4bits USE ENTITY WORK.reg4bits(ifthen);
    FOR DUT4: creg4bits USE ENTITY WORK.reg4bits(ifthen);
    FOR DUT5: csum4bits USE ENTITY WORK.sum4bits(estructural);

BEGIN
    DUT1: ccomp4bits PORT MAP(b3, b2, b1, b0, a3, a2, a1, a0, compz2, compz1, compz0);
    DUT2: cmux2a_4bits PORT MAP(b3, b2, b1, b0, a3, a2, a1, a0, compz2, muxz0, muxz1, muxz2, muxz3);
    DUT3: creg4bits PORT MAP(muxz0, muxz1, muxz2, muxz3, '0', '0', '1', s1, s0, clock, regz00, zegz10, regz20, regz30); ---
    DUT4: creg4bits PORT MAP(muxz0, muxz1, muxz2, muxz3, '0', '0', '1', s1, s0, clock, regz01, regz11, regz21, regz31); ---
    DUT5: csum4bits PORT MAP(regz01, regz11, regz21, regz31, regz00, zegz10, regz20, regz30, '0', sout, sort3, sort2, sort1, sort0);

END estructural;