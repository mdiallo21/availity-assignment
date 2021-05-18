CREATE OR REPLACE PACKAGE ENROLL_CSV_PROCESSING IS

  /*************************************************************************
   * Declaring type variables to hold records and collection of records  ***
  *************************************************************************/
  TYPE T_ENROLL_RECORD IS RECORD(
    user_id           varchar2(10),
    first_name        varchar2(50),
    last_name         varchar2(50),
    record_version    number,
    insurance_company varchar2(50));
  TYPE T_READ_RECORDS_TAB IS TABLE OF T_ENROLL_RECORD INDEX BY PLS_INTEGER;
  
  /*************************************************************************
   * Declaring global variables and constants                            ***
  *************************************************************************/
  V_FILE         UTL_FILE.FILE_TYPE;
  V_ENROLL_REC   T_ENROLL_RECORD;
  V_READ_REC_TAB T_READ_RECORDS_TAB;
  C_MAX_BYTES CONSTANT PLS_INTEGER := 32767;
  V_INDEX     PLS_INTEGER := 0;
  V_LINE_TEXT VARCHAR2(32767);
  
 /*************************************************************************
   * Declaring Functions and procedures                                 ***
  *************************************************************************/
  FUNCTION READ_CSV(p_directory_name in varchar2, p_file_name in varchar2)
    RETURN T_READ_RECORDS_TAB;
  PROCEDURE WRITE_CSV(p_table_data     in t_read_records_tab,
                      p_directory_name in varchar2);

END ENROLL_CSV_PROCESSING;
/

CREATE OR REPLACE PACKAGE BODY ENROLL_CSV_PROCESSING IS
  --Function that reads a file from a directory and return a Associative Array of data
  FUNCTION READ_CSV(p_directory_name in varchar2, p_file_name in varchar2)
    RETURN T_READ_RECORDS_TAB IS
  BEGIN
    -- Open file handle for read
    V_FILE := UTL_FILE.fopen(p_directory_name,
                             p_file_name,
                             'R',
                             C_MAX_BYTES);
    loop
      --Loop through each line until end of lines
      UTL_FILE.get_line(V_FILE, V_LINE_TEXT, C_MAX_BYTES);
      --split line by ','
      V_ENROLL_REC.user_id           := regexp_substr(V_LINE_TEXT,
                                                      '[^,]+',
                                                      1,
                                                      1);
      V_ENROLL_REC.first_name        := regexp_substr(V_LINE_TEXT,
                                                      '[^,]+',
                                                      1,
                                                      2);
      V_ENROLL_REC.last_name         := regexp_substr(V_LINE_TEXT,
                                                      '[^,]+',
                                                      1,
                                                      3);
      V_ENROLL_REC.record_version    := regexp_substr(V_LINE_TEXT,
                                                      '[^,]+',
                                                      1,
                                                      4);
      V_ENROLL_REC.insurance_company := regexp_substr(V_LINE_TEXT,
                                                      '[^,]+',
                                                      1,
                                                      5);
      --Add the record into the collection
      V_READ_REC_TAB(V_INDEX) := V_ENROLL_REC;
      V_INDEX := V_INDEX + 1;
    end loop;
    utl_file.fclose(V_FILE);
    --Exception block: with more time could have added more specific exceptions
  EXCEPTION
    when others then
      null;
  END READ_CSV;
  --Procedure that takes an Associative array and write data to different files in the same directory
  PROCEDURE WRITE_CSV(p_table_data     in t_read_records_tab,
                      p_directory_name in varchar2) IS
    V_FILE_NAME VARCHAR2(30);
    --Find different insurance companies to split the data between
    CURSOR CUR_COMPANY_NAMES IS
      select distinct insurance_company from table(p_table_data);
  BEGIN
    FOR company_record in CUR_COMPANY_NAMES LOOP
      --This query satisfies the ordering by frist and last name, and the removing of duplicates with max version
      select user_id,
             first_name,
             last_name,
             insurance_company,
             max(record_version)
        bulk collect
        into V_READ_REC_TAB
        from table(p_table_data) t
       where t.insurance_company = company_record.insurance_company
       group by user_id, first_name, last_name, insurance_company
       order by first_name, last_name;
      --Give the file the same name as the insurance company
      V_FILE_NAME := company_record.insurance_company || '.csv';
      V_FILE      := utl_file.fopen(p_directory_name,
                                    V_FILE_NAME,
                                    'W',
                                    C_MAX_BYTES);
      V_INDEX     := V_READ_REC_TAB.FIRST;
      while (V_INDEX is not null) loop
        V_ENROLL_REC := V_READ_REC_TAB(V_INDEX);
        V_LINE_TEXT  := V_ENROLL_REC.user_id || ',' ||
                        V_ENROLL_REC.first_name || ',' ||
                        V_ENROLL_REC.last_name || ',' ||
                        V_ENROLL_REC.record_version || ',' ||
                        V_ENROLL_REC.insurance_company;
        utl_file.put_line(V_FILE, V_LINE_TEXT);
        V_INDEX := V_READ_REC_TAB.NEXT(V_INDEX);
      end loop;
      utl_file.fclose(V_FILE);
    END LOOP;
  EXCEPTION
    when others then
      null;
  END WRITE_CSV;
END ENROLL_CSV_PROCESSING;
/
