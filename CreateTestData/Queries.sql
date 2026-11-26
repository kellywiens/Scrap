select AcceptanceStatus
 from query.d_CP_ApplicationDocument
 where objectid in (
   select ApplicationDocumentId
   from query.r_BL_ApplicationAppDocument
   where ApplicationJobId = 104559415);