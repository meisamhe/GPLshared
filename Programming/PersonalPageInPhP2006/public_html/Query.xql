xquery version "1.0";
<rootTag>{
for $p in doc("untitled1.xml")/Employees/EMPLOYEE
where $p/SALARY >1000
return <employee>{$p/NAME} {$p/ADDRESS}</employee>
}</rootTag>