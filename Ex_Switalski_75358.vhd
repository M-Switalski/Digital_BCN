ENTITY inversor IS
PORT (a : IN BIT; z : OUT BIT);
END inversor;

ARCHITECTURE logicaret OF inversor IS
BEGIN
z <= not a AFTER 6 ns;
END logicaret;

ENTITY and2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logicaret of and2 IS
BEGIN
z <= a AND b AFTER 6 ns;
END logicaret;

ENTITY or2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END or2;

ARCHITECTURE logicaret OF or2 IS
BEGIN
Z <= a OR b AFTER 6 ns;
END logicaret;

ENTITY and3 IS
PORT(a, b, c: IN BIT; z: OUT BIT);
END and3;

ARCHITECTURE logicaret OF and3 IS
BEGIN
Z <= a AND b AND c AFTER 6 ns;
END logicaret;

ENTITY or3 IS
PORT(a, b, c: IN BIT; z: OUT BIT);
END or3;

ARCHITECTURE logicaret OF or3 IS
BEGIN
Z <= a OR b OR c AFTER 6 ns;
END logicaret;

ENTITY and4 IS
PORT(a, b, c, d: IN BIT; z: OUT BIT);
END and4;

ARCHITECTURE logicaret OF and4 IS
BEGIN
Z <= a AND b AND c AND d AFTER 6 ns;
END logicaret;

ENTITY or4 IS
PORT(a, b, c, d: IN BIT; z: OUT BIT);
END or4;

ARCHITECTURE logicaret OF or4 IS
BEGIN
Z <= a OR b OR c OR d AFTER 6 ns;
END logicaret;

ENTITY xor2 IS
PORT(a, b: IN BIT; z: OUT BIT);
END xor2;

ARCHITECTURE logicaret of xor2 IS
BEGIN
z <= a XOR b AFTER 6 ns;
END logicaret;

----------------------------------


ENTITY bloc1 IS
    PORT (
        b1,b0,a1,a0 : IN BIT;
        f1,f0 : OUT BIT
    );
END bloc1;


ARCHITECTURE estructural OF bloc1 IS
    COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand3 IS
	PORT (a, b, c : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor3 IS
	PORT (a, b, c : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

SIGNAL inv_a0, inv_b0, inv_a1, inv_b1, and_1, and_2, and_3, and_4, and_5 : BIT;

    FOR DUT1: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT2: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT3: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT4: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT5: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT6: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT7: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT8: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT9: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT10: portaor3 USE ENTITY WORK.or3(logicaret);
    FOR DUT11: portaor2 USE ENTITY WORK.or2(logicaret);
BEGIN
    DUT1: portainv PORT MAP(a0, inv_a0);
    DUT2: portainv PORT MAP(b0, inv_b0);
    DUT3: portainv PORT MAP(a1, inv_a1);
    DUT4: portainv PORT MAP(b1, inv_b1);
    DUT5: portaand2 PORT MAP(b1, b0, and_1);
    DUT6: portaand3 PORT MAP(b1, inv_a1, inv_a0, and_2);
    DUT7: portaand3 PORT MAP(a1, b0, inv_a0, and_3);
	
    DUT8: portaand3 PORT MAP(inv_b1, inv_b0, a1, and_4);
    DUT9: portaand3 PORT MAP(b1, inv_b0, inv_a1, and_5);
	
    DUT10: portaor3 PORT MAP(and_1, and_2, and_3, f1);
    DUT11: portaor2 PORT MAP(and_4, and_5, f0);


END estructural;

---------------------------------------------------------------

ENTITY bloc2 IS
    PORT (
        b1,b0,a1,a0 : IN BIT;
        f1,f0 : OUT BIT
    );
END bloc2;



ARCHITECTURE estructural OF bloc2 IS
    COMPONENT portainv IS
        PORT (a : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand3 IS
	PORT (a, b, c : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor3 IS
	PORT (a, b, c : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaor2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

    COMPONENT portaand2 IS
        PORT (a, b : IN BIT; z : OUT BIT);
    END COMPONENT;

SIGNAL inv_a0, inv_b0, inv_a1, inv_b1, and_1, and_2, and_3, and_4 : BIT;

    FOR DUT1: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT2: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT3: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT4: portainv USE ENTITY WORK.inversor(logicaret);
    FOR DUT5: portaand2 USE ENTITY WORK.and2(logicaret);
    FOR DUT6: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT7: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT8: portaand3 USE ENTITY WORK.and3(logicaret);
    FOR DUT9: portaor2 USE ENTITY WORK.or2(logicaret);
    FOR DUT10: portaor3 USE ENTITY WORK.or3(logicaret);
BEGIN
    DUT1: portainv PORT MAP(a0, inv_a0);
    DUT2: portainv PORT MAP(b0, inv_b0);
    DUT3: portainv PORT MAP(a1, inv_a1);
    DUT4: portainv PORT MAP(b1, inv_b1);
	
    DUT5: portaand2 PORT MAP(b1, b0, and_1);
	
    DUT6: portaand3 PORT MAP(a1, inv_b1, inv_b0, and_2);
    DUT7: portaand3 PORT MAP(a0, a1, inv_b1, and_3);
    DUT8: portaand3 PORT MAP(a0, inv_b0, a1, and_4);
	
    DUT9: portaor2 PORT MAP(and_1, inv_a1, f1);
    DUT10: portaor3 PORT MAP(and_2, and_3, and_4, f0);


END estructural;

------------------------------------------------------------

ENTITY flipflop_t IS
PORT(T, Clk, Pre: IN BIT; Q: OUT BIT);
END flipflop_t;

ARCHITECTURE ifthen OF flipflop_t IS
SIGNAL qint: BIT;
BEGIN
PROCESS (T, Clk, Pre)
BEGIN
    IF Pre = '0' THEN
        qint <= '1' AFTER 6 ns;
    ELSIF Clk'EVENT AND Clk = '1' THEN
        IF T = '1' THEN
            qint <= NOT qint AFTER 6 ns;
        END IF;
    END IF;
END PROCESS;

Q <= qint;
--NO_Q <= NOT qint;
END ifthen;
------------------------------------------------------

ENTITY flipflop_jk IS
PORT(J, K, Clk, Pre: IN BIT; Q: OUT BIT);
END flipflop_jk;

ARCHITECTURE ifthen OF flipflop_jk IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J, K, Clk, Pre)
BEGIN
    IF Pre = '0' THEN
        qint <= '1' AFTER 6 ns;
    ELSIF Clk'EVENT AND Clk = '1' THEN
        IF J = '0' AND K = '0' THEN
            qint <= qint AFTER 6 ns;
        ELSIF J = '0' AND K = '1' THEN
            qint <= '0' AFTER 6 ns;
        ELSIF J = '1' AND K = '0' THEN
            qint <= '1' AFTER 6 ns;
        ELSIF J = '1' AND K = '1' THEN
            qint <= NOT qint AFTER 6 ns;
        END IF;
    END IF;
END PROCESS;

Q <= qint;
--NO_Q <= NOT qint;
END ifthen;

-----------------------------------------------------------------------


ENTITY blocFFs IS
    PORT (
        a2,a1,a0 : IN BIT;
		clock: IN BIT;		
        f1,f0 : OUT BIT
    );
END blocFFs;


ARCHITECTURE estructural OF blocFFs IS
    COMPONENT cflipflop_t IS
        PORT(T, Clk, Pre: IN BIT; Q: OUT BIT);
    END COMPONENT;

    COMPONENT cflipflop_jk IS
	PORT(J, K, Clk, Pre: IN BIT; Q: OUT BIT);
    END COMPONENT;

    FOR DUT1: cflipflop_t USE ENTITY WORK.flipflop_t(ifthen);
    FOR DUT2: cflipflop_jk USE ENTITY WORK.flipflop_jk(ifthen);
BEGIN
    DUT1: cflipflop_t PORT MAP(a2, clock, '1', f1);
    DUT2: cflipflop_jk PORT MAP(a1, a0, clock, '1', f0);


END estructural;

-------------------------------------------------------



ENTITY circuit IS
    PORT (
        ent1, ent0, clock : IN BIT;
        sort2,sort1,sort0 : OUT BIT
    );
END circuit;



ARCHITECTURE estructural OF circuit IS
    COMPONENT cbloc1 IS
        PORT (
        b1,b0,a1,a0 : IN BIT;
        f1,f0 : OUT BIT
    );
    END COMPONENT;

    COMPONENT cbloc2 IS
	PORT (
        b1,b0,a1,a0 : IN BIT;
        f1,f0 : OUT BIT
    );
    END COMPONENT;

    COMPONENT cblocFFs IS
	PORT (
        a2,a1,a0 : IN BIT;
		clock: IN BIT;
        f1,f0 : OUT BIT
    );
    END COMPONENT;


SIGNAL b1f1, b1f0, bfff1, bfff0, b2f1 : BIT;

    FOR DUT1: cbloc1 USE ENTITY WORK.bloc1(estructural);
    FOR DUT2: cbloc2 USE ENTITY WORK.bloc2(estructural);
    FOR DUT3: cblocFFs USE ENTITY WORK.blocFFs(estructural);
BEGIN
    DUT1: cbloc1 PORT MAP(ent1, ent0, bfff1, bfff0, b1f1, b1f0);
    DUT2: cbloc2 PORT MAP(ent1, ent0, bfff1, bfff0, b2f1, sort0);
    DUT3: cblocFFs PORT MAP(b1f1, b1f0, b2f1,clock, bfff1, bfff0);
Sort2 <= bfff1;
Sort1 <= bfff0;


END estructural;


----------------------------------------------------------------

ENTITY bdp IS
END bdp;

ARCHITECTURE test OF bdp IS
COMPONENT circuit IS
PORT(ent1,ent0, clock:IN BIT; sort2,sort1,sort0: OUT BIT);
END COMPONENT;
 
SIGNAL clock: BIT;
SIGNAL ent1,ent0: BIT;
SIGNAL sort2, sort1, sort0: BIT;

FOR DUT: circuit USE ENTITY WORK.circuit(estructural);

BEGIN

DUT: circuit PORT MAP(ent1,ent0, clock, sort2,sort1,sort0);

PROCESS(clock)
BEGIN
clock <= NOT clock AFTER 50 ns;
END PROCESS;

PROCESS(ent1)
BEGIN
ent1 <= NOT ent1 AFTER 75 ns;
END PROCESS;

ent0 <= '0', '1' AFTER 120 ns, '0' AFTER 200 ns, '1' AFTER 250 ns, '0' AFTER 410 ns, '1' AFTER 585 ns, '0' AFTER 700 ns, '1' AFTER 830 ns, '0' AFTER 1110 ns;

END test;