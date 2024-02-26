SELECT l.lname,
    STRING_AGG(t.tname, ', ')
FROM l
    JOIN lt on l.lnr = lt.lnr
    join t on lt.tnr = t.tnr
group by l.lname;