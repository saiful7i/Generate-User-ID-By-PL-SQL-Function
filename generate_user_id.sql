CREATE OR REPLACE FUNCTION generate_user_id (p_name IN VARCHAR2)
RETURN VARCHAR2
IS
    v_p_name    VARCHAR2(30);
    v_base_name VARCHAR2(4);
    v_last_two_chars VARCHAR2(2);
    v_random_digit1 CHAR(1);
    v_random_digit2 CHAR(1);
    v_random_alpha CHAR(1);
    v_special_char CHAR(1);
    v_user_id VARCHAR2(10);
    v_special_chars CONSTANT VARCHAR2(4) := '@#$&';
    v_alphabets CONSTANT VARCHAR2(26) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
BEGIN
    -- Check and remove specific prefixes if they exist
    IF INSTR(p_name, 'MD. ') = 1 THEN
        v_p_name := SUBSTR(p_name, 5);
    ELSIF INSTR(p_name, 'Md. ') = 1 THEN
        v_p_name := SUBSTR(p_name, 5);
    ELSIF INSTR(p_name, 'MD.') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'Md.') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'MD ') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'Md ') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'DR. ') = 1 THEN
        v_p_name := SUBSTR(p_name, 5);
    ELSIF INSTR(p_name, 'Dr. ') = 1 THEN
        v_p_name := SUBSTR(p_name, 5);
    ELSIF INSTR(p_name, 'DR.') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'Dr.') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'DR ') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSIF INSTR(p_name, 'Dr ') = 1 THEN
        v_p_name := SUBSTR(p_name, 4);
    ELSE
        v_p_name := p_name;
    END IF;

    -- Ensure the name is at least 6 characters long by padding if necessary
    IF LENGTH(v_p_name) >= 6 THEN
        v_base_name := SUBSTR(v_p_name, 1, 4);
        v_last_two_chars := SUBSTR(v_p_name, -2);
    ELSE
        v_base_name := SUBSTR(v_p_name || SUBSTR(v_alphabets, TRUNC(DBMS_RANDOM.VALUE(1, 27)), 4), 1, 4);
        v_last_two_chars := SUBSTR(v_p_name || SUBSTR(v_alphabets, TRUNC(DBMS_RANDOM.VALUE(1, 27)), 2), -2);
    END IF;

    -- Generate a random digit
    v_random_digit1 := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 10)));
    v_random_digit2 := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 10)));

    -- Generate a random alphabet
    v_random_alpha := SUBSTR(v_alphabets, TRUNC(DBMS_RANDOM.VALUE(1, 27)), 1);

    -- Select a random special character from the given set
    v_special_char := SUBSTR(v_special_chars, TRUNC(DBMS_RANDOM.VALUE(1, 5)), 1);

    -- Concatenate the parts to form the user ID
    v_user_id := v_base_name || v_random_digit1 || v_random_alpha || v_special_char || v_last_two_chars || v_random_digit2;

    RETURN v_user_id;
END;
/
