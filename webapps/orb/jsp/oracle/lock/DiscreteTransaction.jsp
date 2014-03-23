<%@ page import = "com.orb.sys.ServerSession" %>
<%@ page import = "com.orb.oracle.DBHtmlSortable" %>


<%@ include file="../../sys/Session.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title></title>
</head>

<body>
<%@ include file="../Header.jsp"%>



<h3>Discrete transactions</h3> (­ 50% performance for small & light trans):
<ul>
	<li>DISCRETE_TRANSACTIONS_ENABLED = TRUE
	<li>Transactions do not generate any undo or rollback information
		<ul>
			<li>Redo is held in the separate location of the memory
			<li>Rollback is not modified until the transaction commits
		</ul>
	<li>When commit:
		<ul>
		<li>Db block changes are applied directly to the block
		<li>Redo à redo file
		</ul>

	<li>Limitation:
		<ul>
			<li>short & non-distributed
			<li>Db block is never modified more than once in the same transaction
			<li>Un-commited change is not visible to concurrent trans
			<li>A discrete tran starts during a long query trans will make the query to receive the  ‘snap-shot too old’ error
			<li>The new modified data does not need to be seen by the process
			<li>LONG columns are not modified
		</ul>
	<li>eg.
		<ul>
			<li>create or replace procedure test_ins(new_id in number)
			<li>as
			<li>begin
			<li>	dbms_transaction.begin_discrete_transaction;
			<li>	insert into test values (new_id);
			<li>	commit;
			<li>exception
			<li>	when dbms_transaction.discrete_transaction_failed then
			<li>		rollback;
			<li>end;

			<li>	SQL> exec test_ins(2);
		</ul>
</ul>

</body>
</html>
