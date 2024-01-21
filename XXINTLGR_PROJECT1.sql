------------------------------------------------Package Spec------------------------------------------------

create or replace package XXINTLGR_PROJECT1
is

/****************************************************
*		WHO 			WHEN 			WHY
*
*     VivekU		12-MAY-2023       Project1
****************************************************/

	/*****************************************************
	* procedure Spec to take user input for validation/
	* insertion into base table.
	*****************************************************/
	procedure prc_process_data(p_load_type	IN varchar2,
							   p_batch_id	IN  number);
							   
end XXINTLGR_PROJECT1;