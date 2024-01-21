------------------------------------------------Package Body------------------------------------------------

create or replace package body XXINTLGR_PROJECT1
is

/****************************************************
*		WHO 			WHEN 			WHY
*
*     VivekU		12-MAY-2023       Project1
****************************************************/

	/****************************************************
	*    Global variable declaration
	****************************************************/
	gn_chk number:=null;
	gn_count number := null;
	gc_chk varchar2(100) := null;
	
	procedure prc_print_base_report(p_batch_id IN number)
	IS
	--Cursor to print successfull data from Staging table
        cursor cur_emp_base
        is
        select  
                    stag_id,
                    emp_id,
                    name,
                    email,
                    phone_number,
                    salary,
                    hire_date,
					commission_pct,
                    job_id,
                    job_name,
                    department_id,
                    department_name,
                    location_id,
                    location_name,
                    country_id,
                    country_name,
                    region_id,
                    region_name,
                    status,
                    request_id,
                    creation_date ,
					created_by ,
					last_updated_date,
					last_updated_by,
					last_updated_login
        from employee_staging where 1=1
		and status='S' or status = 'V'
		and request_id = p_batch_id;
		
		
		
		--Cursor to print Data of unsuccessfull insertions from audit table
		cursor cur_emp_audit
        is
		select emp_stag.stag_id,
               emp_stag.emp_id,
			   emp_stag.name,
			   emp_stag.email,
			   emp_stag.phone_number,
			   emp_stag.salary,
			   emp_stag.hire_date,
			   emp_stag.commission_pct,
               emp_stag.job_id,
			   emp_stag.job_name,
			   emp_stag.department_id,
			   emp_stag.department_name,
			   emp_stag.location_id,
			   emp_stag.location_name,
			   emp_stag.country_id,
			   emp_stag.country_name,
			   emp_stag.region_id,
			   emp_stag.region_name,
			   emp_stag.status,
               emp_stag.request_id,
			   emp_stag.creation_date ,
			   emp_stag.created_by ,
			   emp_stag.last_updated_date,
			   emp_stag.last_updated_by,
			   emp_stag.last_updated_login,
			   listagg(emp_aud.error_message,' , ') as err_msg
		from employee_staging emp_stag, emp_stag_audit emp_aud
		where 1=1
		and  emp_stag.stag_id = emp_aud.audit_id
        and emp_stag.request_id = p_batch_id
		group by 
                emp_stag.stag_id,
                emp_stag.emp_id,
			   emp_stag.name,
			   emp_stag.email,
			   emp_stag.phone_number,
			   emp_stag.salary,
			   emp_stag.hire_date,
			   emp_stag.commission_pct,
               emp_stag.job_id,
			   emp_stag.job_name,
			   emp_stag.department_id,
			   emp_stag.department_name,
			   emp_stag.location_id,
			   emp_stag.location_name,
			   emp_stag.country_id,
			   emp_stag.country_name,
			   emp_stag.region_id,
			   emp_stag.region_name,
			   emp_stag.status,
               emp_stag.request_id,
			   emp_stag.creation_date ,
			   emp_stag.created_by ,
			   emp_stag.last_updated_date,
			   emp_stag.last_updated_by,
			   emp_stag.last_updated_login;
	BEGIN
		dbms_output.put_line('***************Displaying data For Successfull Insertions*****************');
		--Displaying Column names
        dbms_output.put_line(
							rpad('STAG_ID',10,' ')||'  '||
							rpad('EMP_ID',10,' ')||'  '||
							rpad('NAME',45,' ')||'  '||
							rpad('Email',25,' ')||'  '||
							rpad('Phone Number',25,' ')||'  '||
							rpad('Salary',10,' ')||'  '||
							rpad('Hire_date',15,' ')||'  '||
							rpad('Commission_pct',15,' ')||'  '||
							rpad('Job_ID',15,' ')||'  '||
							rpad('Job_Title',35,' ')||'  '||
							rpad('Dep_ID',20,' ')||'  '||
							rpad('Dep_name',25,' ')||'  '||
							rpad('Loc_Id',20,' ')||'  '||
							rpad('Location name',25,' ')||'  '||
							rpad('Country Id',15,' ')||'  '||
							rpad('Country name',25,' ')||'  '||
							rpad('Region id',10,' ')||'  '||
							rpad('Region name',25,' ')||'  '||
							rpad('Request Id',15,' ')||'  '||
							rpad('Status',10,' ')||'  '||
							rpad('Created by',25,' ')||'  '||
							rpad('Created date',25,' ')||'  '||
							rpad('Last_updated_by',25,' ')||'  '||
							rpad('Last_updated_date',25,' ')||'  '||
							rpad('Last_updated_login',25,' ')
							);
		
		-- Printing VALUES
		for rpt_emp_dump in cur_emp_base
        loop
			dbms_output.put_line(
								rpad(rpt_emp_dump.stag_id,10,' ')||'|'||  
								rpad(rpt_emp_dump.emp_id,10,' ')||'  '||
								rpad(rpt_emp_dump.name,45,' ')||'  '||
								rpad(rpt_emp_dump.email,25,' ')||'  '||
								rpad(rpt_emp_dump.phone_number,25,' ')||'  '||
								rpad(rpt_emp_dump.salary,10,' ')||'  '||
								rpad(rpt_emp_dump.hire_date,15,' ')||'  '||
								rpad(rpt_emp_dump.commission_pct,15,' ')||'  '||
								rpad(rpt_emp_dump.job_id,15,' ')||'  '||
								rpad(rpt_emp_dump.job_name,35,' ')||'  '||
								rpad(rpt_emp_dump.department_id,20,' ')||'  '||
								rpad(rpt_emp_dump.department_name,25,' ')||'  '||
								rpad(rpt_emp_dump.location_id,20,' ')||'  '||
								rpad(rpt_emp_dump.location_name,25,' ')||'  '||
								rpad(rpt_emp_dump.country_id,15,' ')||'  '||
								rpad(rpt_emp_dump.country_name,25,' ')||'  '||
								rpad(rpt_emp_dump.region_id,10,' ')||'  '||
								rpad(rpt_emp_dump.region_name,25,' ')||'  '||
								rpad(rpt_emp_dump.request_id,15,' ')||'  '||
								rpad(rpt_emp_dump.status,10,' ')||'  '||
								rpad(rpt_emp_dump.created_by,25,' ')||'  '||
								rpad(rpt_emp_dump.creation_date,25,' ')||'  '||
								rpad(rpt_emp_dump.last_updated_by,25,' ')||'  '||
								rpad(rpt_emp_dump.last_updated_date,25,' ')||'  '||
								rpad(rpt_emp_dump.last_updated_login,25,' ')
								);
        end loop;
		
		dbms_output.put_line('***************Displaying data For Unsuccessfull Insertions*****************');
		--Displaying Column names
		dbms_output.put_line(
							rpad('STAG_ID',10,' ')||'  '||
							rpad('EMP_ID',10,' ')||'  '||
							rpad('NAME',45,' ')||'  '||
							rpad('Email',25,' ')||'  '||
							rpad('Phone Number',25,' ')||'  '||
							rpad('Salary',10,' ')||'  '||
							rpad('Hire_date',15,' ')||'  '||
							rpad('Commission_pct',15,' ')||'  '||
							rpad('Job_ID',15,' ')||'  '||
							rpad('Job_Title',35,' ')||'  '||
							rpad('Dep_ID',20,' ')||'  '||
							rpad('Dep_name',25,' ')||'  '||
							rpad('Loc_Id',20,' ')||'  '||
							rpad('Location name',25,' ')||'  '||
							rpad('Country Id',15,' ')||'  '||
							rpad('Country name',25,' ')||'  '||
							rpad('Region id',10,' ')||'  '||
							rpad('Region name',25,' ')||'  '||
							rpad('Request Id',15,' ')||'  '||
							rpad('Status',10,' ')||'  '||
							rpad('Created by',25,' ')||'  '||
							rpad('Created date',25,' ')||'  '||
							rpad('Last_updated_by',25,' ')||'  '||
							rpad('Last_updated_date',25,' ')||'  '||
							rpad('Last_updated_login',25,' ')||'  '||
							rpad('Error_message',200,' ')
							);
		-- Printing VALUES
		for rpt_emp_audit in cur_emp_audit
        loop
			dbms_output.put_line(
								rpad(rpt_emp_audit.stag_id,10,' ')||'  '||  
								rpad(rpt_emp_audit.emp_id,10,' ')||'  '||
								rpad(rpt_emp_audit.name,45,' ')||'  '||
								rpad(rpt_emp_audit.email,25,' ')||'  '||
								rpad(rpt_emp_audit.phone_number,25,' ')||'  '||
								rpad(rpt_emp_audit.salary,10,' ')||'  '||
								rpad(rpt_emp_audit.hire_date,15,' ')||'  '||
								rpad(rpt_emp_audit.commission_pct,15,' ')||'  '||
								rpad(rpt_emp_audit.job_id,15,' ')||'  '||
								rpad(rpt_emp_audit.job_name,35,' ')||'  '||
								rpad(rpt_emp_audit.department_id,20,' ')||'  '||
								rpad(rpt_emp_audit.department_name,25,' ')||'  '||
								rpad(rpt_emp_audit.location_id,20,' ')||'  '||
								rpad(rpt_emp_audit.location_name,25,' ')||'  '||
								rpad(rpt_emp_audit.country_id,15,' ')||'  '||
								rpad(rpt_emp_audit.country_name,25,' ')||'  '||
								rpad(rpt_emp_audit.region_id,10,' ')||'  '||
								rpad(rpt_emp_audit.region_name,25,' ')||'  '||
								rpad(rpt_emp_audit.request_id,15,' ')||'  '||
								rpad(rpt_emp_audit.status,10,' ')||'  '||
								rpad(rpt_emp_audit.created_by,25,' ')||'  '||
								rpad(rpt_emp_audit.creation_date,25,' ')||'  '||
								rpad(rpt_emp_audit.last_updated_by,25,' ')||'  '||
								rpad(rpt_emp_audit.last_updated_date,25,' ')||'  '||
								rpad(rpt_emp_audit.last_updated_login,25,' ')||'  '||
								rpad(rpt_emp_audit.err_msg,200,' ')
								);
        end loop;
	EXCEPTION
		WHEN others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_print_base_report;
    
    
    	/********************************************************
	* Procedure to insert error message 
	********************************************************/
    procedure prc_emp_audit(
        audit_id IN number,
        batch_id IN number,
        error_message IN varchar2
    )
    is 
    PRAGMA autonomous_transaction;
    begin
        begin
            insert into emp_stag_audit values (audit_id,batch_id,error_message,sysdate,(select username||'-'||user_id from user_users));
            commit;
        exception 
        when others then
            dbms_output.put_line(SQLCODE||'  '||SQLERRM);
        end;
    exception 
    when others then
        dbms_output.put_line(SQLCODE||'  '||SQLERRM);
    end prc_emp_audit;

	
	/********************************************************
	* Procedure to insert validated data into base table
	********************************************************/
	procedure prc_insert_emp (p_batch_id IN number)
	IS
		cursor  cur_base_insert IS
		select stag_id, emp_id ,name ,salary ,email ,
				phone_number,hire_date,commission_pct,
				manager_id,department_id, job_id
                from employee_staging
				where 1=1
				and status = 'V'
				and request_id =p_batch_id;
	BEGIN
		FOR rpt_base_insert in cur_base_insert
		loop
			BEGIN
				insert into employees
				values(rpt_base_insert.emp_id,
					   substr(rpt_base_insert.name,1,instr(rpt_base_insert.name,' ',1,1)-1),
					   substr(rpt_base_insert.name,instr(rpt_base_insert.name,' ',1,1)+1),
					   rpt_base_insert.email,
					   rpt_base_insert.phone_number,
					   rpt_base_insert.hire_date,
					   rpt_base_insert.job_id,
					   rpt_base_insert.salary,
					   rpt_base_insert.commission_pct,
					   rpt_base_insert.manager_id,
					   rpt_base_insert.department_id
					   );
                 -- updating statging table      
                update employee_staging
                set status = 'S'
                where stag_id = rpt_base_insert.stag_id;
			EXCEPTION
				when others THEN
                     -- updating statging table      
                    update employee_staging
                    set status = 'S'
                    where stag_id = rpt_base_insert.stag_id;
                    
                    --inserting error into audit table
                    prc_emp_audit(rpt_base_insert.stag_id,p_batch_id,'Error during insertion in base table '||SQLCODE||' - '||SQLERRM);
			end;
		end loop;
		
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_emp;
	
		
	
	/*****************************************************
	* procedure Body to create new Department
	*****************************************************/
	procedure prc_insert_department(p_department_id		IN number,
									p_department_name	IN varchar2,
									p_location_id		IN number,
									p_stag_id			IN number,
									p_request_id		IN number
	)
	IS
		PRAGMA autonomous_transaction;
	BEGIN
		BEGIN
			insert into departments
			(department_id,department_name,location_id)
			values(p_department_id,p_department_name,p_location_id);
			commit;
		EXCEPTION
			WHEN OTHERS THEN
				update employee_staging
				set status = 'E'
				where stag_id = p_stag_id
				and request_id = p_request_id;
				prc_emp_audit(p_stag_id,p_request_id,'Error during Creating Departments');
				commit;
		end;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_department;

	/*****************************************************
	* procedure Body to create new location
	*****************************************************/
	procedure prc_insert_location(p_location_id		IN number,
								  p_city			IN varchar2,
								  p_country_id		IN varchar2,
								  p_stag_id			IN number,
								  p_request_id		IN number
	)
	IS
		PRAGMA autonomous_transaction;
	BEGIN
		BEGIN
			insert into locations
			(location_id,city,country_id)
			values(p_location_id,p_city,p_country_id);
			commit;
		EXCEPTION
			WHEN OTHERS THEN
				update employee_staging
				set status = 'E'
				where stag_id = p_stag_id
				and request_id = p_request_id;
				prc_emp_audit(p_stag_id,p_request_id,'Error during Creating Location');
				commit;
		end;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_location;




	/*****************************************************
	* procedure Body to create new Country
	*****************************************************/	
	procedure prc_insert_countries(p_country_id    IN varchar2,
								   p_country_name  IN varchar2,
								   p_region_id     IN number,
								   p_stag_id       IN number,
								   p_request_id    IN number
	)
	IS
    PRAGMA autonomous_transaction;
	BEGIN
		BEGIN
			insert into countries
			(country_id,country_name,region_id)
			values(p_country_id,p_country_name,p_region_id);
			commit;
		EXCEPTION
			WHEN OTHERS THEN
				update employee_staging
				set status = 'E'
				where stag_id = p_stag_id
				and request_id = p_request_id;
				prc_emp_audit(p_stag_id,p_request_id,'Error during Creating Countries');
				commit;
		end;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_countries;
	
	
	
	
	/*****************************************************
	* procedure Body to create new Region
	*****************************************************/	
	procedure prc_insert_region(p_reg_id	 IN number,
								p_stag_id    IN number,
								p_request_id IN number,
								p_reg_name   IN varchar2)
	IS
	    PRAGMA autonomous_transaction;
	BEGIN
		BEGIN
			insert into regions
			(region_id,region_name)
			values(p_reg_id,p_reg_name);
			commit;
		EXCEPTION
			WHEN OTHERS THEN
				update employee_staging
				set status = 'E'
				where stag_id = p_stag_id
				and request_id = p_request_id;
				prc_emp_audit(p_stag_id,p_request_id,'Error during Creating Region');
				commit;
		END;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_region;
	
	
	
	/*****************************************************
	* procedure Body to create new job 
	*****************************************************/
	procedure prc_insert_job (p_stag_id    IN number,
							  p_request_id IN number,
							  p_job_name   IN varchar2)
	IS
		PRAGMA autonomous_transaction;
	BEGIN
		BEGIN
			insert into jobs
			(job_id,job_title)
			values(substr(p_job_name,1,1)||substr(p_job_name,length(p_job_name)/2,1),p_job_name);
		EXCEPTION
			WHEN OTHERS THEN
				update employee_staging
				set status = 'E'
				where stag_id = p_stag_id
				and request_id = p_request_id;
				prc_emp_audit(p_stag_id,p_request_id,'Error during Creating job');
		END;
	EXCEPTION 
		WHEN OTHERS THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_insert_job;
	
	
	/*****************************************************
	* procedure Body to insert data into Staging table
	*****************************************************/
	procedure prc_insert_stage(p_batch_id IN number)
	IS
	BEGIN
		BEGIN
			insert into employee_staging
			(stag_id ,
			emp_id,
			name,
			salary,
			email,
			phone_number,
			hire_date ,
			job_name ,
			commission_pct ,
			manager_id ,
			department_name ,
			location_name ,
			country_name ,
			region_name ,
			creation_date ,
			created_by ,
			request_id ,
			last_updated_login ,
			status)
			values
			(seq_emp_stag.nextval,
			EMPLOYEES_SEQ.nextval,
			'Sourav Sharma',
			20000,
			'sourav.sharma@gmail.com',
			9456387269,
			sysdate,
			'Programmer',
			.25,
			102,
			'Administration',
			'Tokyo',
			'',
			'',
			sysdate,
			(select username||'-'||user_id from user_users),
			p_batch_id,
			-1,
			'N'
			);
            
            
            ----------------------test case 2------------------------
            insert into employee_staging
			(stag_id ,
			emp_id,
			name,
			salary,
			email,
			phone_number,
			hire_date ,
			job_name ,
			commission_pct ,
			manager_id ,
			department_name ,
			location_name ,
			country_name ,
			region_name ,
			creation_date ,
			created_by ,
			request_id ,
			last_updated_login ,
			status)
			values
			(seq_emp_stag.nextval,
			EMPLOYEES_SEQ.nextval,
			'James devil',
			2000,
			'',
			9456,
			sysdate,
			'Programmer',
			.25,
			102,
			'Administration',
			'',
			'',
			'',
			sysdate,
			(select username||'-'||user_id from user_users),
			p_batch_id,
			-1,
			'N'
			);
            
            ----------------------test case 3------------------------
            insert into employee_staging
			(stag_id ,
			emp_id,
			name,
			salary,
			email,
			phone_number,
			hire_date ,
			job_name ,
			commission_pct ,
			manager_id ,
			department_name ,
			location_name ,
			country_name ,
			region_name ,
			creation_date ,
			created_by ,
			request_id ,
			last_updated_login ,
			status)
			values
			(seq_emp_stag.nextval,
			EMPLOYEES_SEQ.nextval,
			'Ellena Jarvis',
			20090,
			'',
			9456123,
			sysdate,
			'Programmer',
			.25,
			102,
			'Health',
			'Kathmandu',
			'Nepal',
			'Antartica',
			sysdate,
			(select username||'-'||user_id from user_users),
			p_batch_id,
			-1,
			'N'
			);   
            
             ----------------------test case 4------------------------
            insert into employee_staging
			(stag_id ,
			emp_id,
			name,
			salary,
			email,
			phone_number,
			hire_date ,
			job_name ,
			commission_pct ,
			manager_id ,
			department_name ,
			location_name ,
			country_name ,
			region_name ,
			creation_date ,
			created_by ,
			request_id ,
			last_updated_login ,
			status)
			values
			(seq_emp_stag.nextval,
			EMPLOYEES_SEQ.nextval,
			'Ben tennison',
			13780,
			'',
			945978723,
			sysdate,
			'Programmer',
			.25,
			102,
			'Sports',
			'Kathmandu',
			'Nepal',
			'Antartica',
			sysdate,
			(select username||'-'||user_id from user_users),
			p_batch_id,
			-1,
			'N'
			);   
            
            
              ----------------------test case 5------------------------
            insert into employee_staging
			(stag_id ,
			emp_id,
			name,
			salary,
			email,
			phone_number,
			hire_date ,
			job_name ,
			commission_pct ,
			manager_id ,
			department_name ,
			location_name ,
			country_name ,
			region_name ,
			creation_date ,
			created_by ,
			request_id ,
			last_updated_login ,
			status)
			values
			(seq_emp_stag.nextval,
			EMPLOYEES_SEQ.nextval,
			'Kevin mekwal',
			13780,
			'',
			9459723,
			sysdate,
			'Programmer',
			.25,
			102,
			'Taxation',
			'Pokhra',
			'Nepal',
			'Antartica',
			sysdate,
			(select username||'-'||user_id from user_users),
			p_batch_id,
			-1,
			'N'
			);   
            
		EXCEPTION
			WHEN OTHERS THEN
				dbms_output.put_line(SQLCODE||' - '||SQLERRM);
		end;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM );
	END prc_insert_stage;
	
	
	
	/********************************************************
	* Proedure to validate/update data into the staging table
	********************************************************/
	procedure prc_validate_staging (p_batch_id IN number)
	IS
		cursor cur_staging_data IS
			select stag_id ,emp_id ,name ,salary ,email ,
				phone_number,hire_date,job_name,commission_pct,
				manager_id,department_name,location_name 
				,country_name,region_name,creation_date,created_by,
				last_updated_date,last_updated_by,request_id,last_updated_login,status,
				department_id, job_id,location_id,country_id,region_id 
			from employee_staging
			where 1=1
			and request_id=p_batch_id
			and status = 'N';
				   
	BEGIN
		for rpt_staging_data in cur_staging_data
		loop
			BEGIN
				--Reinitializing status as V
				rpt_staging_data.status := 'V';
				/******************************************
				*  Validating name
				*******************************************/
				IF(rpt_staging_data.name is null)
				THEN
					rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Name can''t be null');
				ELSE
--                    dbms_output.put_line('coming for name');
					IF(length(substr(rpt_staging_data.name,1,instr(rpt_staging_data.name,' ',1,1)-1)) > 20)
					THEN
						rpt_staging_data.status := 'E';
						prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'First name must be at most 20 characters in length');
					end if;
					if(length(substr(rpt_staging_data.name,instr(rpt_staging_data.name,' ',1,1)+1)) > 25)
					THEN
						rpt_staging_data.status := 'E';
						prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Last name must be at most 25 characters in length');
					end if;
				END IF;
				
				/******************************************
				*  Validating Salary
				*******************************************/
				if(rpt_staging_data.salary is null)
                then
                    rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Salary can''t be null');         
				elsif(rpt_staging_data.salary < 1000)
                then
					rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Salary can''t be less than 1000');         
				ELSE
--                    dbms_output.put_line('coming into Salary');
					rpt_staging_data.salary := round(rpt_staging_data.salary/12,2);
                end if;
				
				/******************************************
				*  Generating email
				*******************************************/
				--Checking whether a mail with the employees first and last name already exist or not
--                dbms_output.put_line('coming for email');
				select count(1)
				into gn_count
				from employees 
				where 1=1
				and lower(first_name) = lower(substr(rpt_staging_data.name,1,instr(rpt_staging_data.name,' ',1,1)-1))
				and lower(last_name) = lower(substr(rpt_staging_data.name,instr(rpt_staging_data.name,' ',1,1)+1));
				
				if(gn_count = 0)
				THEN
					rpt_staging_data.email := substr(rpt_staging_data.name,1,instr(rpt_staging_data.name,' ',1,1)-1)||'.'||substr(rpt_staging_data.name,instr(rpt_staging_data.name,' ',1,1)+1)||'@intelloger.com';
				ELSE
					rpt_staging_data.email := substr(rpt_staging_data.name,1,instr(rpt_staging_data.name,' ',1,1)-1)||'.'||substr(rpt_staging_data.name,instr(rpt_staging_data.name,' ',1,1)+1)||gn_count||'@intelloger.com';						
				end if;
				gn_count := null;
				
				
				/******************************************
				*  Validating phone number
				*******************************************/
				if(rpt_staging_data.phone_number is null)
                then
                    rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Phone number can not be null');         
                else
--                    dbms_output.put_line('coming for phone');
					select count(1)
					into gn_chk
					from employees emp
					where 1=1
					and emp.phone_number = rpt_staging_data.phone_number;
					
					if(gn_chk = 0)
					then
--                        dbms_output.put_line('phone no is unique');
						if(length(rpt_staging_data.phone_number) > 10)
						then
							 rpt_staging_data.status := 'E';
							 prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Phone should not be greater than 10 digits');         
						end if;
					else
						rpt_staging_data.status := 'E';
						prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Phone number already exist');         
					end if;
                end if;


				/******************************************
				*  Validating /generating hire date
				*******************************************/		
--                dbms_output.put_line('coming for hire_date');
				rpt_staging_data.hire_date := sysdate;
				
				
				/******************************************
				*  Validating / generating commission pct
				*******************************************/				
				if(rpt_staging_data.commission_pct is null)
				then 
--                    dbms_output.put_line('coming for cmsn_pct');
					rpt_staging_data.commission_pct :=0.5;
				elsif(rpt_staging_data.commission_pct < 0 and rpt_staging_data.commission_pct>1)
				THEN	
--                    dbms_output.put_line('coming into cmsn_pct');
					rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Commission pct should be in range between 0 and 1');         					
				end if;

				/******************************************
				*  Validating Job name
				*******************************************/		
				if(rpt_staging_data.job_name is null)
				then
                rpt_staging_data.status := 'E';
				prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Job name can''t be null');         					
				else
--                    dbms_output.put_line('coming for job');
                    begin
                        select jb.job_id
                        into rpt_staging_data.job_id
                        from jobs jb 
                        where 1=1
                        and lower(jb.job_title) = lower(rpt_staging_data.job_name);
                    exception 
                    when others then
						--Creating new job
						prc_insert_job(rpt_staging_data.stag_id,rpt_staging_data.request_id,rpt_staging_data.job_name);
                    end;
				end if;
				
				
				/******************************************
				*  Validating Manager
				*******************************************/	
				select count(1)
				into gn_chk
				from employees 
				where employee_id = rpt_staging_data.manager_id;
				
				if(gn_chk = 0)
				THEN
					rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Manager must be an employee first');
				end if;
				
				
				/******************************************************************
				*  Validating Department / Locations / Regions / Country  sections
				******************************************************************/
				if(rpt_staging_data.department_name is null)
				THEN
					rpt_staging_data.status := 'E';
					prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Department name can''t be null');       
				ELSE
--                    dbms_output.put_line('coming for departmnet');
					select count(1)
					into gn_chk
					from departments 
					where lower(department_name) = lower(rpt_staging_data.department_name);
					if(gn_chk = 0)
					then 
--                        dbms_output.put_line('coming for location');
						select count(1)
						into gn_chk
						from locations 
						where lower(city) = lower(rpt_staging_data.location_name);
						
						if(gn_chk = 0)
						THEN
--                            dbms_output.put_line('coming for country');
							select count(1)
							into gn_chk
							from countries 
							where lower(country_name) = lower(rpt_staging_data.country_name);
							
							if(gn_chk = 0)
							THEN
--                                dbms_output.put_line('coming for region');
								select count(1)
								into gn_chk
								from regions 
								where lower(region_name) = lower(rpt_staging_data.region_name);
								
								if(gn_chk = 0)
								then 
--                                    dbms_output.put_line('Region not found inserting region');
									-- Inserting region
									rpt_staging_data.region_id := seq_reg.nextval;
									prc_insert_region(rpt_staging_data.region_id,
													  rpt_staging_data.stag_id,
									                  rpt_staging_data.request_id,
													  rpt_staging_data.region_name);
--									dbms_output.put_line('Inserting country');
									-- Inserting countries
									rpt_staging_data.country_id := substr(rpt_staging_data.country_name,1,1)||substr(rpt_staging_data.country_name,length(rpt_staging_data.country_name)/2,1);
									prc_insert_countries(rpt_staging_data.country_id,
														 rpt_staging_data.country_name,
														 rpt_staging_data.region_id,
														 rpt_staging_data.stag_id,
														 rpt_staging_data.request_id);
--									dbms_output.put_line('Inserting Location');
									-- Inserting locations
									rpt_staging_data.location_id := LOCATIONS_SEQ.nextval;
									prc_insert_location(rpt_staging_data.location_id,
														rpt_staging_data.location_name,
														rpt_staging_data.country_id,
														rpt_staging_data.stag_id,
														rpt_staging_data.request_id);
--                                        dbms_output.put_line('Inserting department');
									-- Inserting Department
									rpt_staging_data.department_id := DEPARTMENTS_SEQ.nextval;
									prc_insert_department(rpt_staging_data.department_id ,
														  rpt_staging_data.department_name,
														  rpt_staging_data.location_id,
														  rpt_staging_data.stag_id,
														  rpt_staging_data.request_id
									);
								ELSE
									-- Inserting countries
									select region_id , region_name
									into rpt_staging_data.region_id,rpt_staging_data.region_name
									from regions 
									where lower(region_name) = lower(rpt_staging_data.region_name);
									
									rpt_staging_data.country_id := substr(rpt_staging_data.country_name,1,1)||substr(rpt_staging_data.country_name,length(rpt_staging_data.country_name)/2,1);
									prc_insert_countries(rpt_staging_data.country_id,
														 rpt_staging_data.country_name,
														 rpt_staging_data.region_id,
														 rpt_staging_data.stag_id,
														 rpt_staging_data.request_id);
									
									-- Inserting Locations 
									rpt_staging_data.location_id := LOCATIONS_SEQ.nextval;
									prc_insert_location(rpt_staging_data.location_id,
														rpt_staging_data.location_name,
														rpt_staging_data.country_id,
														rpt_staging_data.stag_id,
														rpt_staging_data.request_id);
									
									--Inserting DEPARTMENTS
									rpt_staging_data.department_id := DEPARTMENTS_SEQ.nextval;
									prc_insert_department(rpt_staging_data.department_id ,
														  rpt_staging_data.department_name,
														  rpt_staging_data.location_id,
														  rpt_staging_data.stag_id,
														  rpt_staging_data.request_id
									);
								end if;
							ELSE
								-- Inserting Location
								select c.country_id , c.country_name , r.region_id , r.region_name
								into rpt_staging_data.country_id,rpt_staging_data.country_name,rpt_staging_data.region_id,rpt_staging_data.region_name
								from countries c,regions r
								where 1=1
                                and c.region_id = r.region_id
                                and lower(country_name) = lower(rpt_staging_data.country_name);
								
								rpt_staging_data.location_id := LOCATIONS_SEQ.nextval;
								prc_insert_location(rpt_staging_data.location_id,
													rpt_staging_data.location_name,
													rpt_staging_data.country_id,
													rpt_staging_data.stag_id,
													rpt_staging_data.request_id);
													
								-- Inserting Department
								rpt_staging_data.department_id := DEPARTMENTS_SEQ.nextval;
								prc_insert_department(rpt_staging_data.department_id ,
													  rpt_staging_data.department_name,
													  rpt_staging_data.location_id,
													  rpt_staging_data.stag_id,
													  rpt_staging_data.request_id
								);
							end if;
							
						ELSE
                            dbms_output.put_line('location found now creating department');
							-- Inserting Department
							select l.Location_id , l.city,c.country_id,c.country_name,r.region_id,r.region_name
							into rpt_staging_data.location_id,rpt_staging_data.location_name,rpt_staging_data.country_id,
                            rpt_staging_data.country_name,rpt_staging_data.region_id,rpt_staging_data.region_name
							from locations l ,countries c, regions r
							where 1=1
                            and l.country_id = c.country_id
                            and c.region_id = r.region_id
                            and lower(l.city) = lower(rpt_staging_data.location_name);
							
							rpt_staging_data.department_id := DEPARTMENTS_SEQ.nextval;
							prc_insert_department(rpt_staging_data.department_id ,
												  rpt_staging_data.department_name,
												  rpt_staging_data.location_id,
												  rpt_staging_data.stag_id,
												  rpt_staging_data.request_id
							);
						end if;
					ELSE
						-- getting department_id
						select d.department_id , l.location_id , c.country_id , r.region_id,
                                  l.city,c.country_name,r.region_name
						into rpt_staging_data.department_id , rpt_staging_data.location_id,
							 rpt_staging_data.country_id ,rpt_staging_data.region_id,
                             rpt_staging_data.location_name,rpt_staging_data.country_name
                             ,rpt_staging_data.region_name
						from departments d , locations l ,countries c ,regions r
						where d.location_id = l.location_id
						and l.country_id = c.country_id
						and c.region_id = r.region_id
						and lower(department_name) = lower(rpt_staging_data.department_name);
					end if;
				end if;
				
				
				--Updating the VALUES
				begin
					update employee_staging
					set status = rpt_staging_data.status,
						email  = rpt_staging_data.email,
						salary = rpt_staging_data.salary,
						hire_date = rpt_staging_data.hire_date,
						job_id = rpt_staging_data.job_id,
						commission_pct = rpt_staging_data.commission_pct,
						department_id = rpt_staging_data.department_id,
						location_id = rpt_staging_data.location_id,
						country_id = rpt_staging_data.country_id,
						region_id  = rpt_staging_data.region_id,
                        department_name = rpt_staging_data.department_name,
                        location_name = rpt_staging_data.location_name,
                        country_name = rpt_staging_data.country_name,
                        region_name = rpt_staging_data.region_name,
						last_updated_date = sysdate,
						last_updated_by = (select username||'-'||user_id from user_users)
						where stag_id = rpt_staging_data.stag_id;
					commit;
				exception
					when others then 
						rpt_staging_data.status := 'E';
						prc_emp_audit(rpt_staging_data.stag_id,rpt_staging_data.request_id,'Error While Updating data-'||SQLCODE||' - '||SQLERRM);
				end;	
			EXCEPTION 
				WHEN OTHERS THEN
					dbms_output.put_line(SQLCODE||' - '||SQLERRM);
            end;
		end loop;
	EXCEPTION
		WHEN OTHERS THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	END prc_validate_staging;
	

	/*****************************************************
	* procedure Body to take user input for validation/
	* insertion into base table.
	*****************************************************/
	procedure prc_process_data(p_load_type 	IN varchar2,
							   p_batch_id	IN  number)
	IS
	BEGIN
		--Printing user input values
		dbms_output.put_line(rpad('Load_type',15,' ')||': '||p_load_type);
		dbms_output.put_line(rpad('Batch ID',15,' ')||': '||p_batch_id);		
		select count(1)
        into gn_chk
		from employee_staging
		where request_id = p_batch_id;
        
        if(gn_chk =0)
        THEN
            prc_insert_stage(p_batch_id);
            if(lower(p_load_type)='validate only')
            THEN
                prc_validate_staging(p_batch_id);
            elsif(lower(p_load_type)='insert')
            THEN
                prc_validate_staging(p_batch_id);
                prc_insert_emp(p_batch_id);
            end if;
            prc_print_base_report(p_batch_id);
        elsif(lower(p_load_type)='insert')
		THEN
			prc_insert_emp(p_batch_id);
			prc_print_base_report(p_batch_id);
		else
            dbms_output.put_line('Batch ID already processed');
        end if;
	EXCEPTION
		when others THEN
			dbms_output.put_line(SQLCODE||' - '||SQLERRM);
	end prc_process_data;
							   
end XXINTLGR_PROJECT1;