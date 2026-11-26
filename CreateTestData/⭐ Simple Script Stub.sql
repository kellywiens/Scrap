-- SCRIPT to UPDATE DATA
/*-----------------------------------------------------------------------------
XCR
Purpose:
Time to run:
-----------------------------------------------------------------------------*/
declare
begin

  api.pkg_LogicalTransactionUpdate.ResetTransaction();
  rollback;

  api.pkg_ColumnUpdate.RemoveValue(346225271, 'AdHocEmailAddress');

  -- Ensure this object is synchronized with the datamart.  Usually this
  -- would happen automatically in PostVerify, but since we're deliberately
  -- preventing that from happening (see below) we must do it manually.
  --
  --api.pkg_ObjectUpdate.SetObjectToSynchronize(t_ObjectId);
  
  -- Use pkg_EventQueue.EndSession('N') only if you're certain you're not needing post-verify, 
  -- rel cardinality verfication, to update indexes, to update corral, bypass data-validation for old data, etc.  
  --
  --objmodelphys.pkg_EventQueue.EndSession('N');
  
  api.pkg_LogicalTransactionUpdate.EndTransaction();
  commit;

exception
  when others then
    api.pkg_LogicalTransactionUpdate.ResetTransaction();
    rollback;
    raise;
end;
/*
Success Check:
--SQL to run before and after script to verify changes were made as expected.
select api.pkg_ColumnQuery.Value(346225271, 'AdHocEmailAddress') from dual;
*/
