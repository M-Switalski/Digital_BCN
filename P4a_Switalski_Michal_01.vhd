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

-----------------------------------------------------------------------------------

ENTITY bloc1 IS
    PORT (b2,b1,b0,s1,s0 : IN BIT;
          Mb2,Mb1,Mb0 : OUT BIT);
END bloc1;

ENTITY sum1bit IS
    PORT (a,b,cin : IN BIT;
          S,cout : OUT BIT);
END sum1bit;


-----------------------------------------------

ARCHITECTURE estructural OF bloc1 IS

	COMPONENT portainv IS
        PORT (a : IN BIT;
              z : OUT BIT);
    	END COMPONENT;

	COMPONENT portaxor2 IS
        PORT (a, b : IN BIT;
              z : OUT BIT);
    	END COMPONENT;
	
	COMPONENT portaand2 IS
        PORT (a, b : IN BIT;
              z : OUT BIT);
    	END COMPONENT;
	
	SIGNAL inv_s1, alfa, beta, gamma, delta: BIT;
	
	FOR DUT1: portaxor2 USE ENTITY WORK.xor2(logicaret);
	FOR DUT2: portainv USE ENTITY WORK.inversor(logicaret);
	FOR DUT3: portaand2 USE ENTITY WORK.and2(logicaret);
	FOR DUT4: portaand2 USE ENTITY WORK.and2(logicaret);
	FOR DUT5: portaand2 USE ENTITY WORK.and2(logicaret);
	FOR DUT6: portaxor2 USE ENTITY WORK.xor2(logicaret);
	FOR DUT7: portaxor2 USE ENTITY WORK.xor2(logicaret);
	FOR DUT8: portaxor2 USE ENTITY WORK.xor2(logicaret);

	BEGIN
    DUT1: portaxor2 PORT MAP(s0, s1, alfa);
    DUT2: portainv PORT MAP(s0, inv_s1);
    DUT3: portaand2 PORT MAP(inv_s1, b0, beta);
    DUT4: portaand2 PORT MAP(inv_s1, b1, gamma);
    DUT5: portaand2 PORT MAP(inv_s1, b2, delta);
    DUT6: portaxor2 PORT MAP(alfa, beta, Mb0);
    DUT7: portaxor2 PORT MAP(alfa, gamma, Mb1);
    DUT8: portaxor2 PORT MAP(alfa, delta, Mb2);

END estructural;
	
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
	FOR DUT3: portaor2 USE ENTITY WORK.and2(logicaret);
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

ARCHITECTURE logicaret of bloc1 IS
BEGIN
Mb0 <= (NOT s0 AND NOT s1 AND b0) OR (s0 AND NOT s1 AND b1) OR (s1 AND b2) AFTER 5 ns;
Mb1 <= (NOT s0 AND NOT s1 AND b1) OR (s0 AND NOT s1 AND b2) OR (s1 AND b0) AFTER 5 ns;
Mb2 <= (NOT s0 AND NOT s1 AND b2) OR (s0 AND NOT s1 AND b0) OR (s1 AND b1) AFTER 5 ns;
END logicaret;

ARCHITECTURE logicaret of sum1bit IS
BEGIN
S <= (a XOR b) XOR cin AFTER 5 ns;
cout <= (a AND b) OR (cin AND (a OR b)) AFTER 5 ns;
END logicaret;

ENTITY sum3bits IS
    PORT (b2,b1,b0,a2,a1,a0,cin : IN BIT;
          s2,s1,s0,cout : OUT BIT);
END sum3bits;

ARCHITECTURE estructural OF sum3bits Is
	
	COMPONENT sumador IS
	PORT (a,b,cin : IN BIT;
          S,cout : OUT BIT);
	END COMPONENT;

	SIGNAL alfa, beta: BIT;

	FOR DUT1: sumador USE ENTITY WORK.sum1bit(estructural);
	FOR DUT2: sumador USE ENTITY WORK.sum1bit(estructural);
	FOR DUT3: sumador USE ENTITY WORK.sum1bit(estructural);

	BEGIN
    DUT1: sumador PORT MAP(a0, b0, cin, s0, alfa);
    DUT2: sumador PORT MAP(a1, b1, alfa, s1, beta);
    DUT3: sumador PORT MAP(a2, b2, beta, s2, cout);
    
END estructural;

ENTITY mux4a1 IS
    PORT (a, b, c, d, sel1, sel0  : IN BIT;
          z : OUT BIT);
END mux4a1;

ARCHITECTURE logicaret of mux4a1 IS
BEGIN
z <= (NOT sel1 AND NOT sel0 AND a) OR (NOT sel1 AND sel0 AND b) OR (sel1 AND NOT sel0 AND c) OR (sel1 AND sel0 AND d) AFTER 5 ns;
END logicaret;

ARCHITECTURE ifthen OF mux4a1 IS
BEGIN
	PROCESS (a, b, c, d, sel1, sel0)
	BEGIN
		IF sel1='0' AND sel0='0' THEN
			z <= a AFTER 5 ns;
		ELSIF sel1='0' AND sel0='1' THEN
			z <= b AFTER 5 ns;
		ELSIF sel1='1' AND sel0='0' THEN
			z <= c AFTER 5 ns;
		ELSIF sel1='1' AND sel0='1' THEN
			z <= d AFTER 5 ns;
		END IF;
		-------------
	END PROCESS;
END ifthen;

------------------------------------------------------------------------------

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
    ELSIF ck'EVENT AND ck = '1' THEN
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

	FOR DUT1: mux USE ENTITY WORK.mux4a1(estructural);
	FOR DUT2: ff USE ENTITY WORK.FF_D(estructural);

	BEGIN
    DUT1: mux PORT MAP('0', beta, a, b, s1, s0, alfa);
    DUT2: ff PORT MAP(alfa, ck, preset, beta);
	z <= beta;
    
END estructural;



